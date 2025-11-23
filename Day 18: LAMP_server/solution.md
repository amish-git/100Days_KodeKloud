xFusionCorp Industries is planning to host a WordPress website on their infra in Stratos Datacenter. They have already done infrastructure configuration—for example, on the storage server they already have a shared directory /vaw/www/html that is mounted on each app host under /var/www/html directory. Please perform the following steps to accomplish the task:

a. Install httpd, php and its dependencies on all app hosts.
```bash
sudo yum install -y httpd php php-mysqlnd php-cli php-common
```

b. Apache should serve on port 8084 within the apps.

```bash
[tony@stapp01 ~]$ sudo vi /etc/httpd/conf/httpd.conf

# Change this to Listen on a specific IP address, but note that if
# httpd.service is enabled to run at boot time, the address may not be
# available when the service starts.  See the httpd.service(8) man
# page for more information.
#
#Listen 12.34.56.78:80
Listen 8084
```

c. Install/Configure MariaDB server on DB Server.

On db server install mariadb server,
```bash
sudo yum install -y mariadb-server

sudo systemctl enable --now mariadb
sudo systemctl start mariadb
```

d. Create a database named kodekloud_db10 and create a database user named kodekloud_aim identified as password dCV3szSGNA. Further make sure this newly created user is able to perform all operation on the database you created.

```bash
[peter@stdb01 ~]$ sudo mysql
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 3
Server version: 10.5.29-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> create database kodekloud_db10;
Query OK, 1 row affected (0.000 sec)

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| kodekloud_db10     |
| mysql              |
| performance_schema |
+--------------------+
4 rows in set (0.001 sec)
##Mysql
create user 'kodekloud_gem'@'%' IDENTIFIED BY 'B4zNgHA7Ya'

grant all privileges on kodekloud_db10 TO 'kodekloud_gem'@'%';

show grants for 'kodekloud_gem'@'%';

MariaDB [(none)]> show grants for 'kodekloud_gem'@'%';
+--------------------------------------------------------------------------------------------------------------+
| Grants for kodekloud_gem@%                                                                                   |
+--------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `kodekloud_gem`@`%` IDENTIFIED BY PASSWORD '*1C03A6A05FB7E9535126357D3FD7AD5106E1EAA0' |
+--------------------------------------------------------------------------------------------------------------+
1 row in set (0.000 sec)
```

e. Finally you should be able to access the website on LBR link, by clicking on the App button on the top bar. You should see a message like App is able to connect to the database using user kodekloud_aim
```bash
[tony@stapp01 ~]$ curl localhost:8084
App is able to connect to the database using user kodekloud_gem

[steve@stapp02 ~]$ curl localhost:8084
App is able to connect to the database using user kodekloud_gem

[banner@stapp03 ~]$ curl localhost:8084
App is able to connect to the database using user kodekloud_gem
```