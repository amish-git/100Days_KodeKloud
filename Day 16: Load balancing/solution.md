Day by day traffic is increasing on one of the websites managed by the Nautilus production support team. Therefore, the team has observed a degradation in website performance. Following discussions about this issue, the team has decided to deploy this application on a high availability stack i.e on Nautilus infra in Stratos DC. They started the migration last month and it is almost done, as only the LBR server configuration is pending. Configure LBR server as per the information given below:



a. Install nginx on LBR (load balancer) server.


b. Configure load-balancing with the an http context making use of all App Servers. Ensure that you update only the main Nginx configuration file located at /etc/nginx/nginx.conf.


c. Make sure you do not update the apache port that is already defined in the apache configuration on all app servers, also make sure apache service is up and running on all app servers.


d. Once done, you can access the website using StaticApp button on the top bar.

Solution:

Find the apache port:

```bash
sudo ss -tulpn | grep httpd
tcp   LISTEN 0      511          0.0.0.0:8087       0.0.0.0:*    users:(("httpd",pid=1664,fd=3),("httpd",pid=1663,fd=3),("httpd",pid=1662,fd=3),("httpd",pid=1654,fd=3))
[banner@stapp03 ~]$ curl stapp01:8087
[banner@stapp03 ~]$ curl stapp02:8087
[banner@stapp03 ~]$ curl stapp03:8087
Welcome to xFusionCorp Industries!
```
