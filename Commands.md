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

kafka-topics --bootstrap-server ${KAFKA_URL} --describe --topic test-kafka-connect-vessel-efficiency-offset

  Topic: test-kafka-connect-vessel-efficiency-offset	PartitionCount: 25	ReplicationFactor: 3	Configs: min.insync.replicas=2,cleanup.policy=compact,message.format.version=2.5-IV0,unclean.leader.election.enable=true
    Topic: test-kafka-connect-vessel-efficiency-offset	Partition: 0	Leader: 2	Replicas: 2,3,1	Isr: 1,3,2
    Topic: test-kafka-connect-vessel-efficiency-offset	Partition: 1	Leader: 3	Replicas: 3,1,2	Isr: 1,3,2
```
