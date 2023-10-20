
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kafka Message Deserialization Errors Incident.
---

This incident type involves errors that occur during the process of converting serialized data received by the Kafka message queue into a usable format. Deserialization errors can happen for various reasons, such as incorrect data types or missing fields in the serialized data. These errors can cause issues with the application's functionality and can lead to service disruptions or outages. Troubleshooting and resolving these errors can require a deep understanding of the application's code and the data being processed.

### Parameters
```shell
export KAFKA_LOG_FILE="PLACEHOLDER"

export TOPIC_NAME="PLACEHOLDER"

export ZOOKEEPER_HOST="PLACEHOLDER"

export ZOOKEEPER_PORT="PLACEHOLDER"

export VERSION_NUMBER="PLACEHOLDER"

export SUBJECT_NAME="PLACEHOLDER"

export BROKER_HOST="PLACEHOLDER"

export BROKER_PORT="PLACEHOLDER"


```

## Debug

### Find the most recent log file for the Kafka broker
```shell
ls -t /var/log/kafka/kafka.log.* | head -1
```

### Filter the log file for deserialization errors
```shell
grep "Error deserializing key/value" ${KAFKA_LOG_FILE}
```

### Check the topic configuration for message encoding
```shell
kafka-configs.sh --describe --zookeeper ${ZOOKEEPER_HOST}:${ZOOKEEPER_PORT} --entity-type topics --entity-name ${TOPIC_NAME}
```

### Check the message schema for compatibility issues
```shell
kafka-schema-registry.sh --compatibility --subject ${SUBJECT_NAME} --version ${VERSION_NUMBER}
```

### View the raw bytes of a message
```shell
kafka-console-consumer.sh --bootstrap-server ${BROKER_HOST}:${BROKER_PORT} --topic ${TOPIC_NAME} --from-beginning --formatter "kafka.tools.DefaultMessageFormatter" --property print.key=true --property print.value=true --max-messages 1
```

## Repair

### Consider scaling up the resources allocated to the Kafka message queue, such as increasing the number of partitions or brokers, to handle the increased load.
```shell


#!/bin/bash



# Set variables

${NUM_PARTITIONS}

${NUM_BROKERS}



# Stop Kafka service

sudo systemctl stop kafka



# Update Kafka configuration file with new partition and broker values

sudo sed -i "s/^num.partitions=.*/num.partitions=$NUM_PARTITIONS/" /path/to/server.properties

sudo sed -i "s/^num.brokers=.*/num.brokers=$NUM_BROKERS/" /path/to/server.properties



# Start Kafka service

sudo systemctl start kafka


```