# Create docker image with minidlna and run it in a container

1. Create the working directory and the configuration files

```
$ mkdir docker-minidlna && cd docker-minidlna
$ nano Dockerfile
$ nano entrypoint.sh
$ nano minidlna.conf
```

2. Create a docker image

``` 
$ docker build --rm -t docker-minidlna .
```

The image docker-minidlna:latest has been created with a size of 43.1MB

3a. Run minidlna in a container

```
$ docker run -d --name minidlna --net=host -v /var/media:/media docker-minidlna:latest
```

3b. Run minidlna in a container and start automatically

```
$ docker run -d --restart always --name minidlna --net=host -v /var/media:/media docker-minidlna:latest
```


To open console session in the started minidlna container:

```
$ docker exec -i -t minidlna /bin/bash
```
