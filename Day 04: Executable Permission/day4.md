# Executable Permission

In a bid to automate backup processes, the xFusionCorp Industries sysadmin team has developed a new bash script named **xfusioncorp.sh**. 
While the script has been distributed to all necessary servers, it lacks executable permissions on App Server 1 within the Stratos Datacenter.

Q. Your task is to grant executable permissions to the **/tmp/xfusioncorp.sh** script on App Server 1. **Additionally, ensure that all users have the capability to execute it.**

Answer:
> First log in to app server 1.

```bash
thor@jumphost ~$  ssh tony@stapp01
The authenticity of host 'stapp01 (172.16.238.10)' can't be established.
ED25519 key fingerprint is SHA256:QdWaC/cGmxEEv6kh+Xttzf6Av3c2TwrW5iA2ThvXJ50.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'stapp01' (ED25519) to the list of known hosts.
tony@stapp01's password:
```
>Find the bash file and see the permissions using;

```bash
sudo su -
ls -al
#Change the file permissions
chmod o+rx filename
```