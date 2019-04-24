
### Docker image with proftpd 
The following commands bellow will automatically pull Debian image and it will install proftpd on it. Also it create certificates need it for enabled TLS connections. 
If you want to change the user name or  certificate subject open the DockerFile and do the need it corrections.

```sh

#Build docker images
docker build -t ftpimage .

#Run in attached mode
docker run  -p 8821:21 -p 20:20 -p 49152:49152 -p 49153:49153 -p 49154:49154 -p 49155:49155 -v /opt/docker/uploadFile/files:/home/takov/ -it ftpimage bash

#Run in detached mode
docker run  -p 8821:21 -p 20:20 -p 49152:49152 -p 49153:49153 -p 49154:49154 -p 49155:49155 -v /opt/docker/uploadFile/files:/home/takov/ -dt ftpimage

#Attach to running container
docker exec -it containerID /bin/bash
```

