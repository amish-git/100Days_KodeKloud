The Nautilus DevOps team aims to containerize various applications following a recent meeting with the application development team. They intend to conduct testing with the following steps:


Install docker-ce and docker compose packages on App Server 2.


Initiate the docker service.

```bash
# Docker CE and Docker Compose Installation on CentOS (App Server 2)

#  0⃣ Ssh into App Server 1
ssh steve@stapp02

# Update the system
sudo yum update -y

# Add Docker repository
#Install the dnf-plugins-core package (which provides the commands to manage your DNF repositories) and set up the repository

sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo


# Install Docker CE and docker compose plugin
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable --now docker
sudo systemctl enable --now containerd

# Verify installation
docker --version
docker-compose --version
sudo docker run hello-world
```

#### Post installation for docker

##### Manage Docker as a non-root user
The Docker daemon binds to a Unix socket, not a TCP port. By default it's the root user that owns the Unix socket, and other users can only access it using sudo. The Docker daemon always runs as the root user.

 > create a Unix group called docker and add users to it. When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group.

Create the docker group.
```bash
 sudo groupadd docker
```
Add your user to the docker group.
```bash
 sudo usermod -aG docker $USER
```

#### Install Docker Compose

If you want to manually install it
()[https://docs.docker.com/compose/install/linux/#install-using-the-repository]