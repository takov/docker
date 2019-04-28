FROM debian

ENV  PASS="123" \
     HOST_NAME="localhost" \
     USER="takov" \
     DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y \ 
    && apt-get install -y krb5-admin-server krb5-kdc

COPY ./resources/krb5.conf /etc/

RUN  sed -i 's/host/'${HOST_NAME}'/g' ./etc/krb5.conf \
     && sed -i 's/EXAMPLE.COM/LOCAL.NAME/g' ./etc/krb5kdc/kdc.conf

RUN /usr/sbin/kdb5_util create -s -P ${PASS} \
    && kadmin.local -q "addprinc -pw ${PASS} admin/admin" \
    && kadmin.local -q "addprinc -pw ${PASS} ${USER}"

EXPOSE 750 88
ENTRYPOINT /etc/init.d/krb5-admin-server start && /etc/init.d/krb5-kdc start && /bin/bash

