
#!/bin/bash

PASS=$1
CERT_SUBJECT="CN=hadoop,OU=Docker,O=Dis,L=Springfield,ST=Sofia,C=BG"
CA_SUBJECT="/C=BG/ST=Sofia/L=Springfield/O=Dis/CN=CA"


if [ -z $PASS ] 
then
    echo "ERROR: Please specify password as argument ?" 
    exit 4
fi

keytool -keystore keystore.jks -alias hadoop -validity 3650 -genkey -noprompt -keyalg RSA -keypass $PASS -storepass $PASS -dname $CERT_SUBJECT 
#keytool -importkeystore -srckeystore keystore.jks -destkeystore keystore.jks -deststoretype pkcs12 -storepass $PASS
openssl req -new -x509 -keyout ca-key -out ca-cert -days 3650  -subj $CA_SUBJECT -passout pass:$PASS

keytool -keystore truststore.jks -alias CARoot -import  -noprompt -file ca-cert -storepass $PASS
keytool -keystore keystore.jks -alias hadoop -certreq   -noprompt -file hadoop.cer -storepass $PASS

openssl x509 -req -CA ca-cert -CAkey ca-key -in hadoop.cer -out hadoop-signed.cer -days 3650 -CAcreateserial -passin pass:$PASS

keytool -keystore keystore.jks -alias CARoot -import  -noprompt -file ca-cert -storepass $PASS
keytool -keystore keystore.jks -alias hadoop -import -noprompt  -file hadoop-signed.cer -storepass $PASS 

 
