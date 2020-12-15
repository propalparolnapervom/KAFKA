#!/bin/bash

####################################################
# Counts all partitions (including replicated ones)
# for specified topics
####################################################

KAFKA_URL="<some_server>:<some_port>"

# Get list of topics
kafka-topics --bootstrap-server ${KAFKA_URL} --list > /tmp/topics_devtest.list

# Count all partitions (including replicas) of those topics
sum=0
for i in `cat /tmp/topics_devtest.list`
do 
    count=$(kafka-topics --bootstrap-server ${KAFKA_URL} --describe --topic ${i} | grep ReplicationFactor | awk '{ print $4 * $6}')
    sum=`expr $sum + $count`

    echo
    echo "Topic:        ${i}"
    echo "Partitions:   ${count}"
    echo
    echo "Interim partitons count with current topic would be:   $sum"
    echo
done
echo "        TOTAL:  $sum"


