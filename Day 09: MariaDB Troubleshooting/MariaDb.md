There is a critical issue going on with the Nautilus 
application in Stratos DC. The production support team identified that the application is unable to connect to the database. 
After digging into the issue, the team found that mariadb service is down on the database server.

Let's get our hands dirty:

- First ssh to the Database server

    ```bash
    thor@jumphost ~$  ssh peter@stdb01
    ```

- First, check system mariadb service:
    ```bash
        [peter@stdb01 ~]$  systemctl status mariadb
        × mariadb.service - MariaDB 10.5 database server
        Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: disabled
        )
        Active: failed (Result: exit-code
        ) since Fri 2025-08-29 13:19:25 UTC; 59s ago
        Duration: 6.864s
        Docs: man:mariadbd(8) https://mariadb.com/kb/en/library/systemd/
        Process: 2553 ExecStartPre=/usr/libexec/mariadb-check-socket (code=exited, status=0/SUCCESS)
        Process: 2597 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir mariadb.service (code=exited, status=0/SUCCESS)
        Process: 2693 ExecStart=/usr/libexec/mariadbd --basedir=/usr $MYSQLD_OPTS $_WSREP_NEW_CLUSTER (code=exited, status=1/FAILURE)
        Main PID: 2693 (code=exited, status=1/FAILURE)
    ```
- Now, we need to check the logs of mariadb server database
    ```bash
    [root@stdb01 ~]$ cd /var/log/mariadb/
    [root@stdb01 mariadb]$ ls
    mariadb.log

    [root@stdb01 mariadb]$ cat mariadb.log

    2025-08-29 13:19:25 0 [Note] Server socket created on IP: '::'.
    2025-08-29 13:19:25 0 [ERROR] mariadbd: Can't create/write to file '/run/mariadb/mariadb.pid' (Errcode: 13 "Permission denied")
    2025-08-29 13:19:25 0 [ERROR] Can't start server: can't create PID file: Permission denied
    ```

**Issue:**
```txt
[ERROR] mariadbd: Can't create/write to file '/run/mariadb/mariadb.pid' (Errcode: 13 "Permission denied
```

This indicates that the MariaDB server process (mariadbd) lacks the necessary permissions to create or write to the specified file, which is used to store the process ID (PID) of the running server.

So to resolve this, we need to see the permissions of **/run/mariadb/** directory and adjust the necessary permissions for this.

```bash

[root@stdb01 run]$ chown mysql:mysql mariadb/
```

After that, try to restart mariadb server and see the status:
```bash
[root@stdb01 run]$ systemctl restart mariadb

[root@stdb01 run]$ systemctl status mariadb
● mariadb.service - MariaDB 10.5 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: disabled)
     Active: active (running) since Fri 2025-08-29 13:24:41 UTC; 12s ago
       Docs: man:mariadbd(8)
             https://mariadb.com/kb/en/library/systemd/
    Process: 3100 ExecStartPre=/usr/libexec/mariadb-check-socket (code=exited, status=0/SUCCESS)
    Process: 3144 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir mariadb.service (code=exited, status=0/SUCCESS)
    Process: 3275 ExecStartPost=/usr/libexec/mariadb-check-upgrade (code=exited, status=0/SUCCESS)
   Main PID: 3241 (mariadbd)
     Status: "Taking your SQL requests now..."
      Tasks: 16 (limit: 411434)
     Memory: 88.5M
     CGroup: /docker/1b8244acdcba60a580fdf92bf8956e02270c8ce734958f0fbb3cfbe4a4cdd0cf/system.slice/mariadb.service
             └─3241 /usr/libexec/mariadbd --basedir=/usr
```