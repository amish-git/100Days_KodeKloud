The production support team of xFusionCorp Industries has deployed some of the latest monitoring tools to keep an eye on every service, application, etc. running on the systems. One of the monitoring systems reported about Apache service unavailability on one of the app servers in Stratos DC.


Identify the faulty app host and fix the issue. Make sure Apache service is up and running on all app hosts. They might not have hosted any code yet on these servers, so you don’t need to worry if Apache isn’t serving any pages. Just make sure the service is up and running. Also, make sure Apache is running on port 5004 on all app servers.


First identify the faulty app host:
~~~bash
curl http:<app server ip>
~~~

Check whether apache service is working or not:
~~~bash
sudo systemctl status httpd

# Try to restart or enable the httpd service using:
sudo systemctl enable httpd
sudo systemctl start httpd
~~~

If the httpd service is down, see the logs using:
```bash
sudo jurnalctl -xeu httpd
```
Check if the port is already binding some other addresses:
```bash
ss -tulpn | grep 5004
```
Stop the service that is using that port
For example,
```bash
sudo systemctl stop sendmail
sudo systemctl disable sendmail
```
Restart the apache service
```bash
sudo systemctl restart httpd
```

