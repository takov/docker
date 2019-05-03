#!/bin/bash

#TODO Enhance the script

#Start ssh service
sudo -S service ssh start && \

#Run only in the name node
if [ $1 == true ]
then
  echo "Y" | /home/hadoop/hadoop/bin/hdfs namenode -format
  /home/hadoop/hadoop/sbin/start-dfs.sh 
fi
#Keep the containers running 
tail -f /dev/null



