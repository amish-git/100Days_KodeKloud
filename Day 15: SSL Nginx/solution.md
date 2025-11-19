The system admins team of xFusionCorp Industries needs to deploy a new application on App Server 2 in Stratos Datacenter. They have some pre-requites to get ready that server for application deployment. Prepare the server as per requirements shared below:



1. Install and configure nginx on App Server 2.

    ```bash
    #Log into the appserver
    ssh steve@stapp02

    # Install nginx
    sudo yum install nginx -y

    # Enable and start nginx service
    sudo systemctl enable --now nginx
    sudo systemctl start nginx

    # Check status
    sudo systemctl status nginx

    ```


2. On App Server 2 there is a self signed SSL certificate and key present at location /tmp/nautilus.crt and /tmp/nautilus.key. Move them to some appropriate location and deploy the same in Nginx.
   
   ```bash
    sudo mkdir -p /etc/nginx/ssl
    sudo mv /tmp/nautilus.crt /etc/nginx/ssl/
    sudo mv /tmp/nautilus.key /etc/nginx/ssl/

    #Change the permissions:
    sudo chmod 777 /etc/nginx/ssl/*
    ```

3. Create an index.html file with content Welcome! under Nginx document root.

    ```bash

    cd /usr/share/nginx/html
    vi index.html
    ```


4. For final testing try to access the App Server 2 link (either hostname or IP) from jump host using curl command. For example curl -Ik https://<app-server-ip>/.
    ```bash
    thor@jumphost ~$ curl -Ik https://172.16.238.11 
    HTTP/1.1 200 OK
    Server: nginx/1.20.1
    Date: Wed, 19 Nov 2025 03:55:31 GMT
    Content-Type: text/html
    Content-Length: 9
    Last-Modified: Wed, 19 Nov 2025 03:53:37 GMT
    Connection: keep-alive
    ETag: "691d3f41-9"
    Accept-Ranges: bytes
    ```


Nginx configuration to enable the ssl:

**custom_nginx.conf**

```bash
  # SSL-enabled server
    server {
        listen 443 ssl;
        listen [::]:443 ssl;
        server_name 172.16.238.10;

        ssl_certificate     /etc/nginx/ssl/nautilus.crt;
        ssl_certificate_key /etc/nginx/ssl/nautilus.key;

        root /usr/share/nginx/html;
        index index.html;

        location / {
            try_files $uri $uri/ =404;
        }

        error_page 404 /404.html;
        location = /404.html {}

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {}
    }

    # Redirect HTTP to HTTPS
    server {
        listen 80;
        listen [::]:80;
        server_name 172.16.238.10;

        return 301 https://$host$request_uri;
    }
```