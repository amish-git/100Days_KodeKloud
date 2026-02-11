```bash
# Ssh into the App Server 1 :
ssh tony@stapp01

# Pull the nginx image
docker pull nginx:alpine

# Run the nginx container with name nginx_1
docker run -d --name nginx_1 nginx:alpine

# Step 3: Verify the container is running
docker ps

```