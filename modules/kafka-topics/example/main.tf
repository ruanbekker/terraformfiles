locals {
  kafka_topics = [
    {
      "name"           = "topic-one"
      "segment_ms"     = "20000"
      "cleanup_policy" = "compact"
    },
    {
      "name"           = "topic-two"
      "segment_ms"     = "20000"
      "cleanup_policy" = "compact"
    },
  ]
}

module "kafka-mps-topics" {
  for_each             = {for topic in local.kafka_topics: topic.name => topic}
  source               = "../"
  bootstrap_servers    = var.bootstrap_servers
  kafka_topic_name     = each.value.name
  kafka_segment_ms     = each.value.segment_ms
  kafka_cleanup_policy = each.value.cleanup_policy
}

