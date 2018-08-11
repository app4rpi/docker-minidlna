# Tips&Tricks of MiniDlna Config 
## Arguments to starting Minidlna
It is possible to pass arguments to minidlna when starting the container:

```
$ docker run ... [-f config_file] [-d] [-v] [-u user] [-i interface] [-p port] [-s serial] [-m model_number] [-t notify_interval] [-P pid_filename] [-w url] [-S] [-L] [-R]
```

It can be especially interesting to force the new scan of multimedia files, eliminating the previous database:
```
$ docker run -d --name minidlna --net=host docker-minidlna:latest -R
```
## Modification of the minidlna configuration
It is possible to modify the minidlna parameters by adding new lines to the configuration file. This is possible because the launch script of the minidlna entrypoint.sh reviews all declared variables and is added to minidlna.conf. These variables must begin with ```MINIDLNA_``` and include the minidlna.conf parameter in capital letters:-e MINIDLNA_MEDIA_DIR=/var/media \
Examples
```
-e MINIDLNA_PORT=8200 \
-e MINIDLNA_LISTENING_IP=192.168.0.5 \
-e MINIDLNA_FRIENDLY_NAME=MyDlnaServer \
-e MINIDLNA_ROOT_CONTAINER=. \
```
You can also add multimedia file locations. Keep in mind that these locations refer to the file system of the container and not the host:
```
-e MINIDLNA_MEDIA_DIR=/var/media \
```
Care must be taken in declarations to avoid duplicate areas.
If the directories do not exist they will be created as necessary
From their declaration and creation they can be linked to directories of the file system of the host
```
-v /var/media/:/var/media \
docker run -d --name mini2dlna --net=host \ 
  -v /media/ssd1/musica:/media/m0 \ 
  -e MINIDLNA_MEDIA_DIR=/home/pi/video \ 
  -v /media/ssd1/VideoClips:/home/pi/video \ 
  -v /var/media/.db:/var/cache/minidlna \ 
  docker-minidlna:latest
```
## Access the media directories
The file system of the Docker container is inaccessible and the data / files have been added as soon as they are created. In addition, the file system is reset every time along with the docker container
The directory of multimedia files is habitually located in the host, local or removable media. These locations must be made accessible from Docker
Because the docker can access the data, the volume must be declared as a link to the command line when the container is launched:
```
docker run [...] -v &lt;hostDirectory>:&lt;dockerDirectory> [...]
```
The directories in the docker file system must be created or created automatically when necessary. In any case, it must be checked that they are declared in minidlna.conf so that they can be used by minidlna
```
v /var/media/musica:/media/music
-v /media/hd01/video:/media/video
```
Any modification of the declared file system of docker or host will cause a new scan. If the same declaration of volumes is maintained, you can even use a container of another image.
The symlinks to directories has not worked with minidlna. Minidlna recognizes them, but does not scan their content.
## Database directory
Because the file system is created and destroyed in each release of the Docker container, databases and associated files are regenerated every time. In the case of systems with many files, it may be appropriate to keep the data between start and stop, new releases of the container (eg when starting the system) or containers of different images. For this purpose, the local db_dir must be linked to a host directory.
```
docker run [...] -v /var/media/.db:/var/cache/minidlna [...]
```
It is also possible to leave the permanent data using a Docker Volume
```
$ docker run [...] --mount source = minidlna, target = / var / cache / minidlna [...]
```
This volume has been created as a Docker data container
```
$ docker volume create minidlna
```
The management of volumes follows the insgutions:
```
$ docker volume [create <name>] [inspect <name>] [ls] [prune] [rm]
```
The use of volumes increases the security and portability of the data
