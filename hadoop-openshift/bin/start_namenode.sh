#!/bin/bash

mkdir -p ${DATA_DIR}/hdfs/namenode
mkdir -p ${DATA_DIR}/hdfs/datanode

HOST_IP=`ip -o -4 a | grep eth0 | sed -e 's/.*inet \([^/]*\).*/\1/'`
sed -i -e"s/<namenode_ip>/${HOST_IP}/" $HADOOP_INSTALL/etc/hadoop/core-site.xml
sed -i -e"s/<ip>/${HOST_IP}/g" $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml

hdfs namenode -format -nonInteractive

exec hdfs namenode

