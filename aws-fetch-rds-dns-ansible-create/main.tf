data "aws_db_instance" "dev" {
    db_instance_identifier = "ansible-test"
}

resource "null_resource" "write_vars" {
    depends_on = [
        data.aws_db_instance.dev,
        random_password.password
    ]
    provisioner "local-exec" {
        command = <<EOT
            echo "ansible_rds_hostname: '${data.aws_db_instance.dev.address}'" > ansible/vars.yml
            echo "ansible_rds_username: '${var.rds_admin_username}'" >> ansible/vars.yml
            echo "ansible_rds_password: '${var.rds_admin_password}'" >> ansible/vars.yml
            echo "service_username: '${var.service_name}'" >> ansible/vars.yml
            echo "service_database: '${var.service_name}'" >> ansible/vars.yml
            echo "service_password: '${random_password.password.result}'" >> ansible/vars.yml
        EOT
    }
}

resource "null_resource" "provision_mysql_user" {
    depends_on = [
        null_resource.provision_mysql_user,
        null_resource.write_vars
    ]
    provisioner "local-exec" {
        command = <<EOT
            ansible-playbook ansible/mysql_provision.yml
        EOT
    }
}
