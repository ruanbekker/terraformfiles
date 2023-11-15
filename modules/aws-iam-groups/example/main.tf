module "terraform-aws-iam-group" {
  source  = "../"

  name = "terraform-dynamodb-users"

  path = "/users/"

  policy_statements = [
    {
      sid = "ReadDynamoDBAccess"
      effect = "Allow"
      actions       = ["dynamodb:DescribeTable", "dynamodb:GetItem"]
      not_actions   = []
      resources     = ["arn:aws:dynamodb:eu-west-1:000000000000:table/pet-store"]
      not_resources = []
      conditions    = []
    }
  ]

  policy_name        = null
  policy_name_prefix = null

  policy_arns = []
  module_depends_on = []
  module_enabled    = true
  users = ["peter", "frank"]
}
