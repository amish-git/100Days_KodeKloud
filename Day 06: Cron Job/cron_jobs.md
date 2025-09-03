Q. The Nautilus system admins team has prepared scripts to automate several day-to-day tasks. They want them to be deployed on all app servers in Stratos DC on a set schedule. Before that they need to test similar functionality with a sample cron job. Therefore, perform the steps below:

a. Install **cronie** package on all Nautilus app servers and start **crond** service.

```sh
sudo yum install cronie -y
```

See the status of cronie service:

```bash
sudo systemctl status crond
#START CROND SERVICE
sudo systemctl start crond                     
```
b. Add a cron */5 * * * * echo hello > /tmp/cron_text for root user.

```sh
#ADD CRON JOBS
crontab -e(editing)

*/5 * * * * root echo hello > /tmp/cron_text 
```

List the cron jobs:

```bash
crontab -l
```
 


 	  
   