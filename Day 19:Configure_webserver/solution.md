xFusionCorp Industries is planning to host two static websites on their infra in Stratos Datacenter. The development of these websites is still in-progress, but we want to get the servers ready. Please perform the following steps to accomplish the task:



a. Install httpd package and dependencies on app server 1.
```bash
sudo yum install -y httpd
sudo systemctl enable --now httpd
sudo systemctl start httpd
```

b. Apache should serve on port 8086.

```bash
sudo vi /etc/httpd/conf/httpd.conf

#Listen on
Listen 8086

#Restart the httpd server
sudo systemctl restart httpd
```

c. There are two website's backups /home/thor/news and /home/thor/games on jump_host. Set them up on Apache in a way that news should work on the link http://localhost:8086/news/ and games should work on link http://localhost:8086/games/ on the mentioned app server.

First copy those files to app server.
```bash
thor@jumphost ~$ scp -r games/ tony@stapp01:~/

index.html                             100%  118   231.8KB/s   00:00    

thor@jumphost ~$ scp -r news/ tony@stapp01:~/

index.html                             100%  117   252.9KB/s   00:00    
```
Then move those files into the apache document root folder i.e **/var/www/html** where it serves html files.

```bash

sudo mv games/ news/ /var/www/html/
```

d. Once configured you should be able to access the website using curl command on the respective app server, i.e curl http://localhost:8086/news/ and curl http://localhost:8086/games/

Verify the output:
```bash
curl localhost:8086/news/
curl localhost:8086/games/
```
