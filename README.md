# Create docker image with minidlna and run it in a container

## 1a. Cloning data from GitHub and modify config files if necessary
```
$ git clone https://github.com/app4rpi/docker-minidlna.git 
$ cd docker-minidlna
$ nano <configfile>
```
## 1b. Create the working directory and the configuration files
```
$ mkdir docker-minidlna && cd docker-minidlna
$ nano Dockerfile
$ nano entrypoint.sh
$ nano minidlna.conf
```
## 2. Create a docker image
``` 
$ docker build --rm -t docker-minidlna .
```
The image docker-minidlna:latest has been created with a size of 43.1MB

## 3a. Run minidlna in a container
```
$ docker run -d --name minidlna --net=host docker-minidlna:latest
```
## 3b. Run minidlna in a container and force rescan and restart the database
```
$ docker run -d --name minidlna --net=host docker-minidlna:latest -R
```
## 3c. Run minidlna in a container and start automatically
```
$ docker run -d --restart always --name minidlna --net=host docker-minidlna:latest
```
## 3d. Run in a container with different media directories and a container volume of databases and with automatic startup
```
$ docker run -d --restart always --name minidlna --net=host \
    -v /var/media/musica:/media/music -v /media/ssd1/musica:/media/m1 \
    -v /var/media/video:/media/video -v /media/ssd1/VideoClips:/media/v1 \
    --mount source=minidlna,target=/var/cache/minidlna minidlna:latest
```
### To open console session in the started minidlna container:
```
$ docker exec -it minidlna /bin/bash
```
### Start, stop and remove a docker container
```
$ docker start minidlna
$ docker stop minidlna
$ docker rm minidlna
```
