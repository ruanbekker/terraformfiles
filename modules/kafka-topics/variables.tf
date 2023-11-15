variable "bootstrap_servers" {
  type = list(string)
}

variable "kafka_topic_name" {
  type = string
}

variable "kafka_replication_factor" {
  type    = number
  default = 3
}

variable "kafka_partition_count" {
  type    = number
  default = 3
}

variable "kafka_segment_ms" {
  type    = string
  default = "20000"
}

variable "kafka_cleanup_policy" {
  type    = string
  default = "compact"
}

