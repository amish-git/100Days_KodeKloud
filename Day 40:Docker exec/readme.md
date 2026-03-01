One of the Nautilus DevOps team members was working to configure services on a kkloud container that is running on App Server 3 in Stratos Datacenter. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below:


a. Install apache2 in kkloud container using apt that is running on App Server 3 in Stratos Datacenter.
b. Configure Apache to listen on port 3000 instead of default http port. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc.

c. Make sure Apache service is up and running inside the container. Keep the container in running state at the end.


### SOLUTION steps:

```bash
#log in to App Server 3
ssh banner@stapp03

#Install apache in the running container kkloud executing bash shell
docker exec -it kkloud /bin/bash

apt-get update
apt-get install -y apache2
apt-get install vim
```

To configure the default http port for apache, navigate to the **/etc/apache2/ports.conf** and edit the file:

```bash
vi /etc/apache2/ports.conf

#Change the Listen 80 line
Listen 3000
```
Also configure the **VirtualHost** statement in **/etc/apache2/sites-enabled/000-default.conf**
```bash
<VirtualHost> *:3000
```
At last, restart the apache2 service:
```bash
service apache2 restart && \
service apache2 status
```
