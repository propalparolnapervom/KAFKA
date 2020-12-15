#!/bin/bash

###################################################
# Create lists of Kafka topics 
# that are included or not in some local directory
###################################################


# Dev-Test
ENV_INSTANCE="Dev-Test"
KAFKA_URL="<some_server>:<some_port>"
K8SRELEASES_DIR="/Users/sbur/overall/git_area/90POE/k8s-releases"


CURR_DATE=`date +"%Y-%m-%d %H:%M"`
BASE_DIR_OUTPUT="/Users/sbur/Downloads/topics_k8s_${ENV_INSTANCE}"
mkdir -p ${BASE_DIR_OUTPUT}
#TOPICS_LIST="/tmp/tst.tst"
TOPICS_LIST="${BASE_DIR_OUTPUT}/topics_full_list_${ENV_INSTANCE}.txt"
MENTIONS_LIST="${BASE_DIR_OUTPUT}/topics_mentions_in_repo_${ENV_INSTANCE}.txt"
NOT_PRESENT_LIST="${BASE_DIR_OUTPUT}/topics_ARE_NOT_present_in_repo_${ENV_INSTANCE}.txt"
PRESENT_LIST="${BASE_DIR_OUTPUT}/topics_ARE_present_in_repo_${ENV_INSTANCE}.txt"


echo "
#############################################
# The full list of topics 
# currently present on ${ENV_INSTANCE} Kafka
#
# Date:  ${CURR_DATE}
#############################################
" > ${TOPICS_LIST}

echo "
#######################################################
# The current mentions of ${ENV_INSTANCE} Kafka topics 
# in 'k8s-releases' repo
#
# Date:  ${CURR_DATE}
#######################################################
" > ${MENTIONS_LIST}

echo "
#######################################################
# The list of topics on ${ENV_INSTANCE} Kafka instance
# that currently ARE NOT present 
# in 'k8s-releases' repo 
#
# Date:  ${CURR_DATE}
#######################################################
" > ${NOT_PRESENT_LIST}

echo "
#######################################################
# The list of topics on ${ENV_INSTANCE} Kafka instance
# that currently ARE present 
# in 'k8s-releases' repo 
#
# Date:  ${CURR_DATE}
#######################################################
" > ${PRESENT_LIST}

kafka-topics --bootstrap-server ${KAFKA_URL} --list >> ${TOPICS_LIST}

cd ${K8SRELEASES_DIR}
for i in `cat ${TOPICS_LIST} | grep -v "#" | grep -v -e '^$'`
do 
  if grep -rnw . -e ${i} > /dev/null
  then
      echo                                >> ${MENTIONS_LIST}
      echo "    # TOPIC ON DEV-TEST KAFKA" >> ${MENTIONS_LIST} 
      echo "${i}"                         >> ${MENTIONS_LIST}
      echo                                >> ${MENTIONS_LIST}
      echo "    # MENTIONS IN K8S-RELEASES" >> ${MENTIONS_LIST} 
      grep -rnw . -e ${i} | cut -c 3- | awk '{ print $1 }' | sort >> ${MENTIONS_LIST}
      echo                                >> ${MENTIONS_LIST}
      echo                                >> ${MENTIONS_LIST}
      echo "${i}"                         >> ${PRESENT_LIST}
  else
      echo "${i}"                         >> ${NOT_PRESENT_LIST}
  fi
done

cd ${BASE_DIR_OUTPUT}
zip topics_k8s_mapping_${ENV_INSTANCE}.zip topics_full_list_${ENV_INSTANCE}.txt topics_mentions_in_repo_${ENV_INSTANCE}.txt topics_ARE_NOT_present_in_repo_${ENV_INSTANCE}.txt topics_ARE_present_in_repo_${ENV_INSTANCE}.txt
