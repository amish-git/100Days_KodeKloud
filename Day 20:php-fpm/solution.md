The Nautilus application development team is planning to launch a new PHP-based application, which they want to deploy on Nautilus infra in Stratos DC. The development team had a meeting with the production support team and they have shared some requirements regarding the infrastructure. Below are the requirements they shared:


a. Install nginx on app server 1 , configure it to use port 8096 and its document root should be /var/www/html.

b. Install php-fpm version 8.1 on app server 1, it must use the unix socket /var/run/php-fpm/default.sock (create the parent directories if don't exist).

c. Configure php-fpm and nginx to work together.

d. Once configured correctly, you can test the website using curl http://stapp01:8096/index.php command from jump host.



NOTE: We have copied two files, index.php and info.php, under /var/www/html as part of the PHP-based application setup. Please do not modify these files.

# PHP-FPM WITH NGINX

### TASK HIGHLIGHT

- Listen nginx on port 8096
- Document root: /var/www/html
- Install PHP-FPM 8.1
- Php socket: /var/run/php-fpm/default.sock

### On App-server 1:
```bash
ssh tony@stapp01
```
### Install and start nginx:
```bash
sudo yum install nginx -y
sudo systemctl enable --now nginx
sudo systemctl start nginx
```

### Configure Nginx to use port 8096 and Document Root

```bash
sudo vi /etc/nginx/nginx.conf

server {
    listen 8096;
    server_name stapp01;

    root /var/www/html;
    index index.php index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/var/run/php-fpm/default.sock;  #Path to socket
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

Test the nginx syntax:
```bash
sudo nginx -t
sudo nginx -s reload
```

### Install PHP-FPM(8.1)

The Remi PHP repository is a third-party repository that offers the latest PHP versions. Before adding the Remi repository, you must install the EPEL repository, which provides extra packages for Enterprise Linux.

```bash
sudo dnf config-manager --set-enabled crb
```

After enabling CRB, install the EPEL repository for EL9 using:
```bash
sudo dnf install \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm
```

Finally, import the Remi PHP repository for EL9:

```bash
sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
```

Listing available PHP modules
```bash
dnf modules list php
```

```bash
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
sudo dnf module reset php -y

# enable a specific PHP version from the Remi repository
sudo dnf module enable php:remi-8.1 -y

#If you’re using Nginx, you’ll need to install PHP FastCGI Process Manager (FPM) alongside the PHP CLI
sudo dnf install -y php php-fpm php-cli

#Verify php installation
php -v
```

### Viewing Loaded PHP Modules
```bash
php -m
```

## Configuring PHP-FPM for Nginx to use Custom Socket
```bash
sudo vi /etc/Php-fpm.d/www.conf
```
### Modify User and Group:

Update these lines.
```bash
listen = /var/run/php-fpm/default.sock
listen.owner = nginx
listen.group = nginx

user = nginx
group = nginx
```

## A step to remember:

### Create the directory for the socket:

```bash
sudo mkdir -p /var/run/php-fpm
sudo chown -R nginx:nginx /var/run/php-fpm
```

### Restart the services
```bash
sudo systemctl enable php-fpm
sudo systemctl start php-fpm
sudo systemctl restart nginx
```

>[!NOTE]
>If there are any issues, debug using:

```bash
#For nginx, see the error logs
sudo tail -f error_log /var/log/nginx/error.log;
sudo journalctl -u nginx -e

sudo nginx -T | grep -A5 -B5 "listen 8095" (dumps the full loaded config—look for the socket there).

#For php-fpm
sudo journalctl -u php-fpm -f
```

Since I was facing the socket error, i.e The 404 which was almost certainly because Nginx config was pointing to the wrong socket path (e.g., the default /run/php-fpm/www.sock.

I had to do the following:

- Search all Nginx configs for the bad path:
    ```bash
    sudo grep -r "www.sock" /etc/nginx/  # Lists files with the wrong socket
    sudo grep -r "php-fpm" /etc/nginx/   # Broader search for any PHP-FPM refs
    ```
- Edit every matching file i.e **/etc/nginx/conf.d/php-fpm.conf**
- Update /etc/nginx/conf.d/php-fpm.conf
    ```bash
    upstream php-fpm {
        server unix:/run/php-fpm/www.sock;
    }
    To:
    textupstream php-fpm {
        server unix:/var/run/php-fpm/default.sock;
    }
    ```
- Confirm PHP-FPM socket is live: 
    ``` bash
    ls -la /var/run/php-fpm/default.sock
    ```

### Verify from JUMP HOST
```bash
curl http://stapp01:8096/index.php
curl http://stapp01:8096/info.php

#Answer
thor@jumphost ~$ curl http://stapp01:8095/index.php
Welcome to xFusionCorp Industries!
```