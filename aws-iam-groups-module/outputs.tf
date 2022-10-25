output "group" {
  description = "The aws_iam_group object."
  value       = try(aws_iam_group.group[0], null)
}

output "policy" {
  description = "The aws_iam_group_policy object."
  value       = try(aws_iam_group_policy.policy[0], null)
}

output "policy_attachments" {
  description = "A list of aws_iam_group_policy_attachment objects."
  value       = try(aws_iam_group_policy_attachment.policy_attachment, null)
}

output "users" {
  description = "The aws_iam_group_membership object."
  value       = try(aws_iam_group_membership.users[0], null)
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------
output "module_enabled" {
  description = "Whether the module is enabled"
  value       = var.module_enabled
}

