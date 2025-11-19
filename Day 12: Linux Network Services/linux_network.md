Our monitoring tool has reported an issue in Stratos Datacenter. One of our app servers has an issue, as its Apache service is not reachable on port 6400 (which is the Apache port). The service itself could be down, the firewall could be at fault, or something else could be causing the issue.



Use tools like telnet, netstat, etc. to find and fix the issue. Also make sure Apache is reachable from the jump host without compromising any security settings.

Once fixed, you can test the same using command curl http://stapp01:6400 command from jump host.

Note: Please do not try to alter the existing index.html code, as it will lead to task failure.

~~~bash
[tony@stapp01 ~]$  curl http://stapp01:6400
curl: (7) Failed to connect to stapp01 port 6400: Connection refused

[tony@stapp01 ~]$ sudo netstat -tlpn | grep 6400
tcp        0      0 127.0.0.1:6400          0.0.0.0:*               LISTEN      445/sendmail: accep


tony@stapp01 ~]$  sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Sun 2025-09-07 15:17:20 UTC; 7min ago
     Docs: man:httpd.service(8)
  Process: 506 ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND (code=exited, status=1/FAILURE)
 Main PID: 506 (code=exited, status=1/FAILURE)
   Status: "Reading configuration..."

Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com httpd[506]: (98)Address already in use: AH00072: make_sock: could
 not bind to address 0.0.0.0:6400
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com httpd[506]: no listening sockets available, shutting down
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com httpd[506]: AH00015: Unable to open logs
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Child 506 belo
ngs to httpd.service.
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Main process e
xited, code=exited, status=1/FAILURE
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Failed with re
sult 'exit-code'.
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Changed start 
-> failed
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Job httpd.serv
ice/start finished, result=failed
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com systemd[1]: Failed to start The Apache HT
TP Server.
Sep 07 15:17:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Unit entered f
ailed state.



[tony@stapp01 ~]$ sudo systemctl status sendmail
● sendmail.service - Sendmail Mail Transport Agent
   Loaded: loaded (/usr/lib/systemd/system/sendmail.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2025-09-07 15:17:19 UTC; 9min ago
  Process: 438 ExecStart=/usr/sbin/sendmail -bd $SENDMAIL_OPTS $SENDMAIL_OPTARG (code=exited, status=0/SUCCESS)
  Process: 434 ExecStartPre=/etc/mail/make aliases (code=exited, status=0/SUCCESS)
  Process: 433 ExecStartPre=/etc/mail/make (code=exited, status=0/SUCCESS)
 Main PID: 445 (sendmail)
    Tasks: 1 (limit: 411434)
   Memory: 7.0M
   CGroup: /docker/dbfe6ea7a8983550e763ed928ed4b76e9e04402d9a36619cc399fe9f525163fd/system.slice/sendmail.service
           └─445 sendmail: accepting connections


[tony@stapp01 ~]$  sudo iptables -I INPUT 4 -p tcp --dport 6400 -j ACCEPT

~~~