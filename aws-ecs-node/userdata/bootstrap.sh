#!/bin/bash
export PATH=${PATH}:/usr/local/bin

AWS_ACCOUNT="dev"
CLUSTER_NAME="ecs-dev"
ENVIRONMENT_NAME="dev"
NODE_EXPORTER_VERSION="1.0.1"
NODE_EXPORTER_USER="node_exporter"
CADVISOR_VERSION="0.37.0"
MY_HOSTNAME="$(curl -s http://169.254.169.254/latest/meta-data/local-hostname)"
INSTANCE_ID="$(curl -s http://instance-data/latest/meta-data/instance-id)"
INSTANCE_LIFECYCLE="$(curl -s http://169.254.169.254/latest/meta-data/instance-life-cycle)"
REGION="$(curl -s http://instance-data/latest/meta-data/placement/availability-zone | rev | cut -c 2- | rev)"
SHORT_ID="$(echo ${INSTANCE_ID} | tail -c 4)"
INSTANCE_NAME="ecs-${ENVIRONMENT_NAME}-ec2-instance-${SHORT_ID}"

# write ecs config
echo "ECS_CLUSTER=${CLUSTER_NAME}" >> /etc/ecs/ecs.config
echo "ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\"]" >> /etc/ecs/ecs.config
echo "ECS_INSTANCE_ATTRIBUTES={\"environment\":\"${ENVIRONMENT_NAME}\"}" >> /etc/ecs/ecs.config

# install loki docker plugin
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions

# install dependencies
sudo yum install awscli unzip wget jq -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf ./aws

sleep 1

LOKI_USERNAME="$(aws ssm get-parameter --name '/devops/tools/LOKI_USERNAME' | jq -r '.Parameter.Value')"
LOKI_PASSWORD="$(aws ssm get-parameter --name '/devops/tools/LOKI_PASSWORD' | jq -r '.Parameter.Value')"
LOKI_HOSTNAME="$(aws ssm get-parameter --name '/devops/tools/LOKI_HOSTNAME' | jq -r '.Parameter.Value')"

sleep 1
aws --region eu-west-1 ec2 create-tags --resources ${INSTANCE_ID} --tags Key=Name,Value=${INSTANCE_NAME}

cat > /etc/docker/daemon.json << EOF
{
    "debug" : true,
    "log-driver": "loki",
    "log-opts": {
        "loki-url": "https://${LOKI_USERNAME}:${LOKI_PASSWORD}@${LOKI_HOSTNAME}/loki/api/v1/push",
        "loki-batch-size": "300",
        "loki-external-labels": "job=dev/dockerlogs,name=${INSTANCE_NAME},container_name={{.Name}},cluster_name=${CLUSTER_NAME},instanceid=${INSTANCE_ID},instance_lifecycle=${INSTANCE_LIFECYCLE},aws_account=${AWS_ACCOUNT},environment=${ENVIRONMENT_NAME}"
    }
}
EOF

/etc/init.d/docker restart

id -u ${NODE_EXPORTER_USER} &> /dev/null && EXIT_CODE=${?} || EXIT_CODE=${?}
if [ ${EXIT_CODE} == 1 ]
  then
    useradd --no-create-home --shell /bin/false ${NODE_EXPORTER_USER}
fi

wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar -xf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
cp node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/bin/
chown ${NODE_EXPORTER_USER}:${NODE_EXPORTER_USER} /usr/bin/node_exporter
rm -rf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64*

wget https://github.com/google/cadvisor/releases/download/v${CADVISOR_VERSION}/cadvisor
chmod +x ./cadvisor
mv ./cadvisor /usr/bin/cadvisor

cat > /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
StartLimitIntervalSec=500
StartLimitBurst=5
[Service]
User=${NODE_EXPORTER_USER}
Group=${NODE_EXPORTER_USER}
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/bin/node_exporter
[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/cadvisor.service << EOF
[Unit]
Description=cAdvisor
Wants=network-online.target
After=network-online.target
[Service]
User=root
Group=root
Type=simple
ExecStart=/usr/bin/cadvisor
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable node_exporter
systemctl enable cadvisor
systemctl start node_exporter
systemctl start cadvisor

sleep 5

if [ $(docker ps -f name=ecs-agent | grep 'amazon' | wc -l) -eq 1 ]
    then 
        echo "ecs-agent is running"
    else 
        docker start ecs-agent
fi
