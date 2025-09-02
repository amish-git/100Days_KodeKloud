# Linux User Setup with Non-Interactive Shell

Q. To accommodate the backup agent tool's specifications, the system admin team at xFusionCorp Industries requires the creation of a user with a non-interactive shell. Here's your task:

Create a user named **yousuf** with a non-interactive shell on App Server 3.

Server Details:

```
Server Name IP Hostname User Password Purpose
stapp01 1  72.16.238.10 stapp01.stratos.xfusioncorp.com tony Ir0nM@n Nautilus App 1
stapp02 172.16.238.11 stapp02.stratos.xfusioncorp.com steve Am3ric@ Nautilus App 2
stapp03 172.16.238.12 stapp03.stratos.xfusioncorp.com banner BigGr33n Nautilus App 3
stlb01 172.16.238.14 stlb01.stratos.xfusioncorp.com loki Mischi3f Nautilus HTTP LBR
stdb01 172.16.239.10 stdb01.stratos.xfusioncorp.com peter Sp!dy Nautilus DB Server
ststor01 172.16.238.15 ststor01.stratos.xfusioncorp.com natasha Bl@kW Nautilus Storage Server
stbkp01 172.16.238.16 stbkp01.stratos.xfusioncorp.com clint H@wk3y3 Nautilus Backup Server
stmail01 172.16.238.17 stmail01.stratos.xfusioncorp.com groot Gr00T123 Nautilus Mail Server
jump_host Dynamic jump_host.stratos.xfusioncorp.com thor mjolnir123 Jump Server to Access Stork DC
jenkins 172.16.238.19 jenkins.stratos.xfusioncorp.com jenkins j@rv!s Jenkins Server for CI/`

```

A non-interactive shell in Linux is a shell that is typically used for running automated scripts or commands that don’t require user interaction. Such shells are executed without the normal environment and settings of an interactive shell, allowing the execution of commands to be done without interruption.

For example, you can use a non-interactive shell to schedule a cron job that runs a script every day at a specific time to back up the data on your server. The script is executed by the non-interactive shell, and the backups are done without any human intervention, ensuring that the backups are done at the scheduled time without fail.

## id
>
>“id” command is used to display user and group information for a specified user in Linux, including the user ID (UID) and primary group ID (GID), as well as any supplementary groups that the user is a member of.

### Answer

```bash
thor@jumphost ~$ ssh banner@stapp03
banner@stapp03's password:
Last failed login: Thu Aug  7 02:48:52 UTC 2025 from 172.16.238.3 on ssh:notty
There were 2 failed login attempts since the last successful login.
Last login: Thu Aug  7 02:43:33 2025 from 172.16.238.3

[banner@stapp03 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
Last failed login: Thu Aug  7 02:51:22 UTC 2025 on pts/0
There were 3 failed login attempts since the last successful login.
```

You need to have root or administrative privileges to be able to run this command.
>sudo su -

#### Add user with non-interactive shell

```bash
[root@stapp03 ~] adduser anita -s /sbin/nologin
[root@stapp03 ~] cat /etc/passwd | grep anita
anita:x:1002:1002::/home/anita:/sbin/nologin

```

#### Validate the user

```bash
[root@stapp03 ~]#  id anita
uid=1002(anita) gid=1002(anita) groups=1002(anita)

cat /etc/passwd | grep user_name  # command in Linux that is used to display information about a specific user
```
