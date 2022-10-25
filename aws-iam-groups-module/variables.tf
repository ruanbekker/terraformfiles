variable "name" {
  type        = string
  description = "(Required, Forces new resource) The name of the group."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ------------------------------------------------------------------------------

variable "path" {
  type        = string
  description = "(Optional) The path to the group. See IAM Identifiers for more information."
  default     = "/"
}

# inline policy

variable "policy_statements" {
  type        = any
  description = "(Optional) List of IAM policy statements to attach to the group as an inline policy."
  default     = []
}

variable "policy_name" {
  type        = string
  description = "(Optional) The name of the group policy. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "policy_name_prefix" {
  type        = string
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name."
  default     = null
}

# managed / custom policies

variable "policy_arns" {
  type        = list(string)
  description = "(Optional) List of IAM custom or managed policy ARNs to attach to the group."
  default     = []
}

variable "users" {
  type        = set(string)
  description = "(Optional) List of IAM users to bind to the group."
  default     = null
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------
variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is true."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is []."
  default     = []
}

