The Nautilus application development team has shared that they are planning to deploy one newly developed application on Nautilus infra in Stratos DC. The application uses PostgreSQL database, so as a pre-requisite we need to set up PostgreSQL database server as per requirements shared below:



PostgreSQL database server is already installed on the Nautilus database server.


a. Create a database user kodekloud_sam and set its password to GyQkFRVNr3.

```bash
[peter@stdb01 ~]$ sudo -u postgres psql
could not change directory to "/home/peter": Permission denied
psql (13.14)
Type "help" for help.

postgres=# \c
You are now connected to database "postgres" as user "postgres".
postgres=#  \du
                                   List of roles
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}

postgres=# CREATE USER kodekloud_sam WITH PASSWORD 'GyQkFRVNr3';
CREATE ROLE
postgres=# \du
                                     List of roles Role name   |                         Attributes                         | Member of 
---------------+------------------------------------------------------------+-----------
 kodekloud_sam |                                 
                           | {}
 postgres      | Superuser, Create role, Create D, Replication, Bypass RLS | {}

```


b. Create a database kodekloud_db5 and grant full permissions to user kodekloud_sam on this database.
```bash
postgres=# create database kodekloud_db5;
CREATE DATABASE
postgres=# grant all privileges on database kodekloud_db5 to kodekloud_sam;
GRANT
```

Note: Please do not try to restart PostgreSQL server service.