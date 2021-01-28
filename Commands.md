# Commands


## TOPICS

### List

List topics
```
KAFKA_URL="<some_host>:<some_port>"

kafka-topics --bootstrap-server ${KAFKA_URL} --list
```

## PARTITIONS

### List

List partitions for specific topic
```
KAFKA_URL="<some_host>:<some_port>"
TOPIC_NAME="dev_di_voyage_monitor_interpolated_position"

kafka-topics --bootstrap-server ${KAFKA_URL} --describe --topic ${TOPIC_NAME}

  Topic: test-kafka-connect-vessel-efficiency-offset	PartitionCount: 25	ReplicationFactor: 3	Configs: min.insync.replicas=2,cleanup.policy=compact,message.format.version=2.5-IV0,unclean.leader.election.enable=true
    Topic: test-kafka-connect-vessel-efficiency-offset	Partition: 0	Leader: 2	Replicas: 2,3,1	Isr: 1,3,2
    Topic: test-kafka-connect-vessel-efficiency-offset	Partition: 1	Leader: 3	Replicas: 3,1,2	Isr: 1,3,2
```

## OFFSET

### Reset

Reset Offset of the Topic's specific Partition to some value
```
KAFKA_URL="<some_host>:<some_port>"
CONSUMER_GROUP="dev-voyage-monitor-weather-stream-v0.0.19"
TOPIC_NAME="dev_di_voyage_monitor_interpolated_position"
TOPIC_PARTITION_NUMBER="2"
REQUIRED_OFFSET_NUMBER="27000"

# Dry-run
kafka-consumer-groups --bootstrap-server ${KAFKA_URL} --group ${CONSUMER_GROUP} --topic ${TOPIC_NAME}:${TOPIC_PARTITION_NUMBER} --reset-offsets --to-offset ${REQUIRED_OFFSET_NUMBER} --dry-run

# Execute
kafka-consumer-groups --bootstrap-server ${KAFKA_URL} --group ${CONSUMER_GROUP} --topic ${TOPIC_NAME}:${TOPIC_PARTITION_NUMBER} --reset-offsets --to-offset ${REQUIRED_OFFSET_NUMBER} --execute
```

