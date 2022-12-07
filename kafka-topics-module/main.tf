resource "kafka_topic" "default" {
  name               = var.kafka_topic_name
  replication_factor = var.kafka_replication_factor
  partitions         = var.kafka_partition_count

  config = {
    "segment.ms"     = var.kafka_segment_ms
    "cleanup.policy" = var.kafka_cleanup_policy
  }
}

