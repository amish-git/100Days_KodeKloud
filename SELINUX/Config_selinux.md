How to configure SELinux for applications and services
Admins need to follow six steps to configure SELinux properly to run applications and services. This tutorial walks you through how to configure the security system.
Jack Wallen
By
Jack Wallen
Published: 31 Jul 2023
Security-Enhanced Linux is a powerful security system that is enabled, by default, on most Linux distributions based on RHEL. Admins and users often disable SELinux, even though that's not the best option.

SELinux can make it a challenge to get newly installed or custom applications to run because it blocks them from having access to certain directories in the file system hierarchy. Instead of disabling SELinux, the better option is to configure the security system so applications and services can function as expected. This is especially important when you have an application or service that requires a nonstandard configuration.

Take, for example, the Apache web server. Apache on RHEL-based distributions defaults to the /var/httpd directory as the document root and ports 80 (for HTTP) and 443 (for HTTPS) when installed.

Admins who want to use a different directory and port for a website might opt for /srv as the document root and port 8080. Out of the box, SELinux denies those nonstandard options, so they must be configured to work properly.

How to configure SELinux for nonstandard configurations
To configure SELinux, you need a running instance of a Linux distribution that uses the system, such as Rocky Linux, AlmaLinux or RHEL. You also need a user with sudo privileges.

1. Install Apache
The first thing to do is install the Apache web server. Log in to your Linux server, or connect to it via SSH and install the necessary software with the following command:

sudo dnf install httpd -y
When that installation completes, start and enable the service with the following:

sudo systemctl enable --now httpd
Next, install two more packages related to SELinux, with the following command:

sudo dnf install policycoreutils-python-utils setroubleshoot -y
2. Check the default ports
To verify SELinux is allowing Apache to serve sites via the default ports, issue the following command:

sudo semanage port -l | grep http
You should see output that looks like this:

http_cache_port_t    tcp 8080, 8118, 8123, 10001-10010
http_cache_port_t    udp 3130
http_port_t          tcp 80, 81, 443, 488, 8008, 8009, 8443, 9000
pegasus_http_port_t  tcp 5988
pegasus_https_port_t tcp 5989
The good news is that Apache is already listening on both 80 and 8080. If you want to serve it up on port 8088, make the following changes.

Open the Apache configuration file with the following command:

sudo nano /etc/httpd/conf/httpd.conf
The first thing to do is change the port. Look for the following line:

Listen 80
Change that line to the following:

Listen 80
Listen 8088
3. Change the document root
First, change the document root. Look for the following line:

DocumentRoot "/var/www/html"
Change that line to the following:

DocumentRoot "/srv/www"
Save and close the file.

Create the new document root with the following command:

sudo mkdir /srv/www
Give the directory write permissions with the following:

sudo chmod -R ug+w /srv/www
Then, create an index file with the following:

sudo nano /srv/www/index.html
In that file, paste the following:

<!DOCTYPE html>
<html>
<body>

<h1>Apache Welcome Page</h1>
<p>Welcome to Apache.</p>

</body>
</html>
Save and close the file.

4. Restart Apache
In order to restart Apache, make SELinux aware of the new port. For that, use the semanage command -- the tool used to manage SELinux policies:

sudo semanage port -a -t http_port_t -p tcp 8088
Restart Apache with the following:

sudo systemctl restart httpd
5. Make SELinux aware of the directory
Even with the new port added, you aren't able to access the index.html page in /srv/www because you need to make SELinux aware of the new directory. To do this, first compare the directories with the following command:

sudo matchpathcon /var/www/html /srv/www
The /var/www/html directory listing should look like this:

/var/www/html system_u:object_r:httpd_sys_content_t:s0
Match those SELinux contexts so /srv/www is listed as httpd_sys_content_t. Change the SELinux type for the new directory with the following:

sudo semanage fcontext -a -t httpd_sys_content_t "/srv/www(/.*)?"
The fcontext option manages file context mapping definitions, which is essential in enabling nonstandard directories for a service. Following that change, relabel the /srv directory recursively with the restorecon command that restores default SELinux security contexts:

sudo restorecon -RFvv /srv/
6. Open port 8088 via the firewall
Finally, open port 8088 via the firewall with the following commands:

sudo firewall-cmd --permanent --zone=public --add-port=8088/tcp
sudo firewall-cmd --reload
At this point, if you open a web browser on your LAN to http://SERVER:8088 -- where SERVER is the IP address of the hosting server -- you see the content of the new index.html. If SELinux was not made aware of the new port and document root, Apache wouldn't start or be able to serve up the new location.