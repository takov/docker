FROM debian

ENV FTP_USER="takov" FTP_USER_PASS="123" CERT_SUBJ="/C=BG/ST=Sofia/L=Springfield/O=Dis/CN=proftpd"

RUN apt-get update && apt-get upgrade -y && apt-get install -y proftpd openssl

RUN mkdir /etc/proftpd/ssl \
  && openssl req -new -x509 -days 365 -nodes -subj $CERT_SUBJ -out /etc/proftpd/ssl/proftpd.cert.pem -keyout /etc/proftpd/ssl/proftpd.key.pem \
  && chmod 600 /etc/proftpd/ssl/proftpd.*

COPY ./resources/proftpd.conf /etc/proftpd/
COPY ./resources/tls.conf   /etc/proftpd/

RUN useradd --shell /bin/false $FTP_USER \
    && mkdir /home/$FTP_USER \
    && chown $FTP_USER:$FTP_USER  /home/$FTP_USER/ \
    && echo ''$FTP_USER':'$FTP_USER_PASS'' | chpasswd \
    && service proftpd restart

EXPOSE 20 21 49152 49153 49154 49155 
ENTRYPOINT service proftpd start && /bin/bash

