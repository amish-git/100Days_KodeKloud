The Nautilus DevOps team is conducting application deployment tests on selected application servers. They require a nginx container deployment on Application Server 1. Complete the task with the following instructions:


On Application Server 1 create a container named nginx_1 using the nginx image with the alpine tag. Ensure container is in a running state.


```bash
# Ssh into the App Server 1 :
ssh tony@stapp01

# Pull the nginx image with version alpine
docker pull nginx:alpine

# Verify the container image
docker images

# Run the nginx container with name nginx_1
# -d = detach mode, --name <container-name> image
docker run -d --name nginx_1 nginx:alpine

# Verify the container is running
docker ps

```