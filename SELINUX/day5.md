Q. Following a security audit, the xFusionCorp Industries security team has opted to enhance application and server security with SELinux. To initiate testing, the following requirements have been established for App server 2 in the Stratos Datacenter:

- Install the required SELinux packages.

- Permanently disable SELinux for the time being; it will be re-enabled after necessary configuration changes.

- No need to reboot the server, as a scheduled maintenance reboot is already planned for tonight.

Disregard the current status of SELinux via the command line; the final status after the reboot should be disabled.


Answers:

```bash
sudo sestatus  #see status of the SELinux

#install the SELinux using:
sudo yum install -y policycoreutils selinux-policy selinux-policy-targeted
```

Edit **/etc/selinux/config** and

```
set SELINUX = disabled
```
