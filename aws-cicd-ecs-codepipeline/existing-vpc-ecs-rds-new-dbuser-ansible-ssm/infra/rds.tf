data "aws_db_instance" "qa" {
    db_instance_identifier = "shared-${var.platform_type}-${var.environment_name}-instance"
}

resource "random_password" "db_password" {
    length = 16
    special = true
    override_special = "_"
}

resource "null_resource" "write_vars" {
    depends_on = [
        data.aws_db_instance.qa,
        data.aws_ssm_parameter.rds_admin_database_username,
        data.aws_ssm_parameter.rds_admin_database_password,
        random_password.db_password
    ]
    provisioner "local-exec" {
        command = <<EOT
            echo "ansible_rds_hostname: '${data.aws_db_instance.qa.address}'" > ansible/vars.yml
            echo "ansible_rds_username: '${data.aws_ssm_parameter.rds_admin_database_username.value}'" >> ansible/vars.yml
            echo "ansible_rds_password: '${data.aws_ssm_parameter.rds_admin_database_password.value}'" >> ansible/vars.yml
            echo "service_username: '${var.service_name_short}'" >> ansible/vars.yml
            echo "service_database: '${var.service_name_short}'" >> ansible/vars.yml
            echo "service_password: '${random_password.db_password.result}'" >> ansible/vars.yml
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
            ansible-playbook ansible/mysql_tasks.yml
        EOT
    }
}
