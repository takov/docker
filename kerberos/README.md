
### Docker image with kerberos 
More info about what is kerberos can be find on the following website https://web.mit.edu/kerberos/

### Server

```sh

#Build docker images
docker build -t kerberos .

#Run in attached mode
docker run -p 750:750 -p 88:88 -it kerberos bash

#Run in detached mode
docker run -p 750:750 -p 88:88 -dt kerberos bash

#Open SSH tunel to running container
docker exec -it containerID /bin/bash
```

### Client

To connect to Kerberos you will need to install Kerberos klient.

```sh
#Debian
apt-get install krb5-user

#RHEL
yum install krb5-workstation krb5-libs krb5-auth-dialog

```
Then open /etc/krb5.conf file and add the host name of the machine where the server is installed. 

Test the connecitons 

```sh
#Authenticate
kinit takov@LOCAL.INT

#Show tikets
klist
#Klist should return similar output
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: takov@LOCAL.INT

Valid starting       Expires              Service principal
04/28/2019 16:16:32  04/29/2019 16:16:27  krbtgt/LOCAL.INT@LOCAL.INT

#Destroy the session
kdestroy
```
