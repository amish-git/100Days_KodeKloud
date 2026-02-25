One of the Nautilus developer was working to test new changes on a container. He wants to keep a backup of his changes to the container. A new request has been raised for the DevOps team to create a new image from this container. Below are more details about it:


a. Create an image media:xfusion on Application Server 1 from a container ubuntu_latest that is running on same server.


Theory:

- **docker commit** allows you to create a new image from a running or stopped container. Basically it captures the current state of a container and saves it as a new image.

### SOLUTION

Steps:
```bash
# Ssh into App Server 1 :
ssh tony@stapp01

# Commit the running container to a new image
# Syntax [OPTIONS => -m,-a,--pause,-c]
# docker commit [OPTIONS] CONTAINER_NAME IMAGE_NAME:TAG
docker commit ubuntu_latest media:xfusion

# Verify the new image
docker images

```


Examples with different options
```bash
# With message and author
docker commit -m "added curl and vim" -a "John" a1b2c3d4e5f6 my-ubuntu:v1

# With environment variable
docker commit -c "ENV APP_ENV=production" a1b2c3d4e5f6 my-app:v1

# With exposed port
docker commit -c "EXPOSE 8080" a1b2c3d4e5f6 my-app:v1
```