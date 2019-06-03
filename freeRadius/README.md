
### Docker image with freeRadius
https://hub.docker.com/r/freeradius/freeradius-server

```sh

#Build docker images
docker build -t freeradius .

#Run in attached mode
docker run -p 1812-1813:1812-1813/udp  -it freeradius  bash

#Run in detached mode
docker run -p 1812-1813:1812-1813/udp  -dt freeradius bash

#Run in DEBUG mode
docker run -p 1812-1813:1812-1813/udp  -it freeradius -X bash

#Attach to running container
docker exec -it containerID /bin/bash
```

