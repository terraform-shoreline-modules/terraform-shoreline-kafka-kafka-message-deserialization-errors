resource "shoreline_notebook" "kafka_message_deserialization_errors_incident" {
  name       = "kafka_message_deserialization_errors_incident"
  data       = file("${path.module}/data/kafka_message_deserialization_errors_incident.json")
  depends_on = [shoreline_action.invoke_update_kafka_config]
}

resource "shoreline_file" "update_kafka_config" {
  name             = "update_kafka_config"
  input_file       = "${path.module}/data/update_kafka_config.sh"
  md5              = filemd5("${path.module}/data/update_kafka_config.sh")
  description      = "Consider scaling up the resources allocated to the Kafka message queue, such as increasing the number of partitions or brokers, to handle the increased load."
  destination_path = "/tmp/update_kafka_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_kafka_config" {
  name        = "invoke_update_kafka_config"
  description = "Consider scaling up the resources allocated to the Kafka message queue, such as increasing the number of partitions or brokers, to handle the increased load."
  command     = "`chmod +x /tmp/update_kafka_config.sh && /tmp/update_kafka_config.sh`"
  params      = []
  file_deps   = ["update_kafka_config"]
  enabled     = true
  depends_on  = [shoreline_file.update_kafka_config]
}

