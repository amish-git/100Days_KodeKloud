# Question

As part of the temporary assignment to the Nautilus project, a developer named yousuf requires access for a limited duration.
To ensure smooth access management, **a temporary user account with an expiry date is needed**. Here's what you need to do:

Create a user named yousuf on App Server 3 in Stratos Datacenter. Set the **expiry date to 2024-01-28**,ensuring the user is created in lowercase as per standard protocol.

## Answer

```bash
thor@jumphost ~$  ssh banner@stapp03
The authenticity of host 'stapp03 (172.16.238.12)' can't be established.
ED25519 key fingerprint is SHA256:JIvb2zSuMOcqFKh5Ai04oj/NsaEFL83pviI+XSRr62g.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'stapp03' (ED25519) to the list of known hosts.
banner@stapp03's password: 

[banner@stapp03 ~]$ sudo  su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner: 
[root@stapp03 ~] id yousuf
id: ‘yousuf’: no such user
[root@stapp03 ~] adduser yousuf
[root@stapp03 ~] id yousuf
uid=1002(yousuf) gid=1002(yousuf) groups=1002(yousuf)
```

The **chage -l** mark command is used to display the password and account aging information for the user "mark", such as when the password was last changed when it will expire, and how many days before expiration the user will be warned.

```bash
[root@stapp03 ~] chage -l yousuf
Last password change                            : Aug 07, 2025
Password expires                                : never
Password inactive                               : never
Account expires                                 : never
Minimum number of days between password change  : 0
Maximum number of days between password change  : 99999
Number of days of warning before password expires: 7
```

## Change the expiry date of the user

```bash
sudo chage -E date(2024-01-28) username
```
