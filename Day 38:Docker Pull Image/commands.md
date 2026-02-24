Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task:


a. Pull busybox:musl image on App Server 3 in Stratos DC and re-tag (create new tag) this image as busybox:news.

### SOLUTION

Steps:
```bash
# 1. SSH into the App Server 3
ssh banner@stapp03

# 2. Pull busybox:musl image by running command
docker pull busybox:musl

# 3. Create a new tag for the image busybox:musl as busybox:news
docker tag busybox:musl busybox:news

# 4. Verify the new tag
docker images | grep busybox
```

![](task_done.png)
![](verify.png)