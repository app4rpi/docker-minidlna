# Create docker image with minidlna and run it in a container

1. Create the working directory and the configuration files

    $ mkdir docker-minidlna && cd docker-minidlna
  
    $ nano Dockerfile
  
    $ nano entrypoint.sh
  
    $ nano minidlna.conf
  

2. Create a docker image
  
    $ sudo docker build --rm -t docker-minidlna .

The image docker-minidlna:latest has been created with a size of 43.1MB

3. Run minidlna in a container

  $ sudo docker run -d --name minidlna --net=host -v /var/media:/media docker-minidlna:latest
