resource "aws_iam_group" "group" {
  count = var.module_enabled ? 1 : 0

  name = "${var.name}"
  path = "${var.path}"

  #depends_on = ["${var.module_depends_on}"]
}

locals {
  policy_enabled = "${var.module_enabled}" && length("${var.policy_statements}") > 0
}

data "aws_iam_policy_document" "policy" {
  count = "${local.policy_enabled}" ? 1 : 0

  dynamic "statement" {
    for_each = "${var.policy_statements}"

    content {
      sid           = try("${statement.value.sid}", null)
      effect        = try("${statement.value.effect}", null)
      actions       = try("${statement.value.actions}", null)
      not_actions   = try("${statement.value.not_actions}", null)
      resources     = try("${statement.value.resources}", null)
      not_resources = try("${statement.value.not_resources}", null)

      dynamic "condition" {
        for_each = try("${statement.value.conditions}", [])

        content {
          test     = "${condition.value.test}"
          variable = "${condition.value.variable}"
          values   = "${condition.value.values}"
        }
      }
    }
  }
}

resource "aws_iam_group_policy" "policy" {
  count = "${local.policy_enabled}" ? 1 : 0

  name        = "${var.policy_name}"
  name_prefix = "${var.policy_name_prefix}"

  policy = "${data.aws_iam_policy_document.policy[0].json}"
  group  = "${aws_iam_group.group[0].name}"

  #depends_on = ["${var.module_depends_on}"]
}

resource "aws_iam_group_policy_attachment" "policy_attachment" {
  count = "${var.module_enabled}" ? length("${var.policy_arns}") : 0

  group      = "${aws_iam_group.group[0].name}"
  policy_arn = "${var.policy_arns[count.index]}"

  #depends_on = ["${var.module_depends_on}"]
}

# Add list of users to the group
resource "aws_iam_group_membership" "users" {
  count = "${var.module_enabled}" && "${var.users}" != null ? 1 : 0

  name  = "${aws_iam_group.group[0].name}"
  group = "${aws_iam_group.group[0].name}"
  users = "${var.users}"

  #depends_on = ["${var.module_depends_on}"]
}

