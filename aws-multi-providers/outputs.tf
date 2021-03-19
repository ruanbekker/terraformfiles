output "root_account_id" {
    value = data.aws_caller_identity.root.account_id
}

output "staging_account_id" {
    value = data.aws_caller_identity.staging.account_id
}

output "tools_account_id" {
    value = data.aws_caller_identity.tools.account_id
}
