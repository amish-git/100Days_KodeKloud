Q. The system admins team of xFusionCorp Industries has set up some scripts 
on jump host that run on regular intervals and perform operations on all 
app servers in Stratos Datacenter. 
To make these scripts work properly we need to make sure the thor user on 
jump host has password-less SSH access to all app servers through their 
respective sudo users (i.e tony for app server 1). 
Based on the requirements, perform the following:

#### Q.Set up a password-less authentication from user thor on jump host to all app servers through their respective sudo users.

##### Changing passphrase
>If you need to change a passphrase on your private key or if you initially set an empty passphrase and want that protection at a later time, use the ssh-keygen command with the -p option:
```bash
ssh-keygen -p
```
### Answers
1.Generate the key to the default location ~/.ssh/
```bash
ssh-keygen
```
2.Propagating the public key to remote system/hosts
```bash
ssh-copy-id username@hostip
```

To add extra layer of security to your server, you can disable the password authentication for SSH. Before disabling the SSH password authentication make sure you can log in to your server without a password and the user you are logging in with has sudo privileges.


- Open the SSH configuration file "/etc/ssh/sshd_config” and modify the settings as below:
```
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
```
