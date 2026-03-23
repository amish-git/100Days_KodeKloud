The Nautilus application development team shared static website content that needs to be hosted on the httpd web server using a containerised platform. The team has shared details with the DevOps team, and we need to set up an environment according to those guidelines. Below are the details:



a. On App Server 2 in Stratos DC create a container named httpd using a docker compose file /opt/docker/docker-compose.yml (please use the exact name for file).


b. Use httpd (preferably latest tag) image for container and make sure container is named as httpd; you can use any name for service.


c. Map 80 number port of container with port 3004 of docker host.


d. Map container's /usr/local/apache2/htdocs volume with /opt/data volume of docker host which is already there. (please do not modify any data within these locations).


### Solution steps:

```bash

ssh steve@stapp02

#Go te the directory
cd /opt/docker
# create a compose.yml file
vi docker-compose.yml

# run docker-compose file
docker compose up -d
```

![](done.png)