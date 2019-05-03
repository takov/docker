FROM debian

ENV  PASS="123" \
     USER="hadoop" \
     HADOOP_VERSION="3.2.0" \ 
     JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre/" \
     CERT_PASS="12345678" \
     PDSH_RCMD_TYPE=ssh

RUN apt-get update && apt-get upgrade -y &&\ 
    apt-get install -y  openjdk-8-jdk pdsh wget  openssh-server sudo

RUN echo "root:${PASS}" | chpasswd &&\
    echo "${USER} ALL = NOPASSWD : ALL" > /etc/sudoers

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config

RUN  useradd -rm -d /home/${USER} -s /bin/bash -g root -G sudo -u 1000 ${USER} -p "$(openssl passwd -1 ${PASS})"

WORKDIR /home/${USER}

USER ${USER}

RUN mkdir data &&\
    mkdir certs &&\
    mkdir .ssh &&\
    ssh-keygen -t rsa -N "" -f .ssh/id_rsa && \
    wget -nv https://www-eu.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz &&\ 
    tar -xzf  hadoop-${HADOOP_VERSION}.tar.gz &&\
    mv hadoop-${HADOOP_VERSION}/ hadoop/ &&\
    rm -f hadoop-${HADOOP_VERSION}.tar.gz &&\
    cp .ssh/id_rsa.pub .ssh/authorized_keys
    
#TODO check if it possible to use ENV ${USER}
COPY --chown=hadoop:root ./resources/gen_certs.sh ./certs

WORKDIR /home/${USER}/certs

RUN chmod +x ./gen_certs.sh &&\
     ./gen_certs.sh $CERT_PASS

WORKDIR /home/${USER}/hadoop/
#Same as the first COPY
COPY  --chown=hadoop:root ./resources/core-site.xml ./resources/hdfs-site.xml ./resources/ssl-server.xml ./resources/ssl-client.xml ./etc/hadoop/

RUN sed -Ei 's|.*export JAVA.*|export JAVA_HOME='${JAVA_HOME}'|g' ./etc/hadoop/hadoop-env.sh &&\
    sed -Ei 's|CUSTOMPASS|'${CERT_PASS}'|g' ./etc/hadoop/ssl-server.xml &&\
    sed -Ei 's|CUSTOMPASS|'${CERT_PASS}'|g' ./etc/hadoop/ssl-client.xml &&\
    echo "node1" >> ./etc/hadoop/workers && \
    echo "node2" >> ./etc/hadoop/workers

COPY  --chown=hadoop:root ./resources/start_hadoop.sh .

EXPOSE 22 9871 9870

CMD [ "bash", "start_hadoop.sh","true"]