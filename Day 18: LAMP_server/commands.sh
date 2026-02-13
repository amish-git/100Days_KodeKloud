# Install httpd and php dependencies
sudo yum install -y httpd php php-mysqlnd php-cli php-common
sudo vi /etc/httpd/conf/httpd.conf

sudo yum install -y mariadb-server
sudo systemctl enable --now mariadb
sudo systemctl start mariadb

create database kodekloud_db10;
show databases;

create user 'kodekloud_gem'@'%' IDENTIFIED BY '********';
grant all privileges on kodekloud_db10 TO 'kodekloud_gem'@'%';

show grants for 'kodekloud_gem'@'%';
