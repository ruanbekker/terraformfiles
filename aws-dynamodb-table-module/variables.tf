variable "table_name" {
  description = "Name of the DynamoDB table."
  type        = string
}

variable "billing_mode" {
  description = "Billing mode of the DynamoDB table."
  type        = string
  default     = "PROVISIONED"
}

variable "hash_key" {
  description = "Hash key of the DynamoDB table."
  type        = string
  default     = null
}

variable "range_key" {
  description = "Range key of the DynamoDB table."
  type        = string
  default     = null
}

variable "read_capacity" {
  description = "Read capacity of the DynamoDB table."
  type        = number
  default     = 1
}

variable "write_capacity" {
  description = "Write capacity of the DynamoDB table."
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags to add to the DynamoDB table."
  type        = map(string)
  default     = {}
}

variable "enable_hash_key" {
  description = "Enable hash key for the DynamoDB table."
  type        = bool
  default     = true
}

variable "enable_range_key" {
  description = "Enable range key for the DynamoDB table."
  type        = bool
  default     = false
}
