We have one of our websites up and running on our Nautilus infrastructure in Stratos DC. Our security team has raised a concern that right now Apache’s port i.e 8083 is open for all since there is no firewall installed on these hosts. So we have decided to add some security layer for these hosts and after discussions and recommendations we have come up with the following requirements:

SOLUTION:

1. Install iptables and all its dependencies on each app host.

    ```bash
    sudo yum install iptables-services -y 
    sudo systemctl enable iptables      
    sudo systemctl start iptables 
    sudo systemctl status iptables
    sudo iptables -nvL 
    ```

1. Block incoming port 8083 on all apps for everyone except for LBR host.

    ```bash
    #REPLACED AND destination port  LBR SERVER IP ADRESS WHICH ADDRESS WE WANT TO ALLOW GIVE IT HERE
    
    sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    sudo iptables -R INPUT 5 -p tcp --dport 8083 -s 172.16.238.14 -j ACCEPT
    sudo iptables -A INPUT -p tcp --dport 8083 -j DROP
    sudo iptables -L -n --line-numbers
    ```


3. Make sure the rules remain, even after system reboot.
    ```bash
    sudo sh -c '/sbin/iptables-save > /etc/sysconfig/iptables'
    ```

### Verify from LB Server

Login to LBR server and check the appservers if they are reachable or not.

    ```bash
        curl 172.16.238.10:5002
        curl 172.16.238.11:5002
        curl 172.16.238.12:5002
    ```


### Some useful commands and notes about iptables rules:


Use the iptables command:
```bash
/sbin/iptables -L -n -v
/sbin/iptables -L -n -v | grep port
/sbin/iptables -L -n -v | grep -i DROP
/sbin/iptables -L OUTPUT -n -v
/sbin/iptables -L INPUT -n -v
```

Some extra notes:

#### Flush existing rules to start with a clean slate:

```bash
sudo iptables -t filter -F   
```

#### Allow established and related connections to maintain existing communication.

```bash
sudo iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT  
```

#### Block all other incoming traffic on port 8083.

```bash
sudo iptables -t filter -A INPUT -p tcp --dport 8083 -j DROP   
```

#### Save the current rules to the configuration files.

```bash
sudo iptables-save > /etc/iptables/rules.v4

```
**Linux block Incoming Port With IPtables**

The syntax is as follows to block incoming port using IPtables:

```bash
/sbin/iptables -A INPUT -p tcp --destination-port {PORT-NUMBER-HERE} -j DROP
 
### interface section - use eth1 ###
/sbin/iptables -A INPUT -i eth1 -p tcp --destination-port {PORT-NUMBER-HERE} -j DROP
 
### only drop port for given IP or Subnet ##
/sbin/iptables -A INPUT -i eth0 -p tcp --destination-port {PORT-NUMBER-HERE} -s {IP-ADDRESS-HERE} -j DROP
/sbin/iptables -A INPUT -i eth0 -p tcp --destination-port {PORT-NUMBER-HERE} -s {IP/SUBNET-HERE} -j DROP


**Block incoming Port *) except for ip ...**
/sbin/iptables -A INPUT -p tcp -i -eth ! -s ip,, --dport 80 -j DROP

# /sbin/iptables -A INPUT -p tcp -i eth1 ! -s 1.2.3.4 –dport 80 -j DROP

```

**Block Outgoing Port**

The syntax is as follows:

```bash

/sbin/iptables -A OUTPUT -p tcp --dport {PORT-NUMBER-HERE} -j DROP

### interface section use eth1
/sbin/iptables -A OUTPUT -o eth1 -p tcp --dport {PORT-NUMBER-HERE} -j DROP
 
### only drop port for given IP or Subnet ##
/sbin/iptables -A OUTPUT -o eth0 -p tcp --destination-port {PORT-NUMBER-HERE} -s {IP-ADDRESS-HERE} -j DROP
/sbin/iptables -A OUTPUT -o eth0 -p tcp --destination-port {PORT-NUMBER-HERE} -s {IP/SUBNET-HERE} -j DROP
```

Example:

To block outgoing port # 25:
```bash
/sbin/iptables -A OUTPUT -p tcp --dport 25 -j DROP
/sbin/service iptables save
```
You can also block port # 1234 for IP address 192.168.1.2 only:

```bash
/sbin/iptables -A OUTPUT -p tcp -d 192.168.1.2 --dport 1234 -j DROP
/sbin/service iptables save
```
### How Do I Log Dropped Port Details?
Use the following syntax:

## Logging #
### If you would like to log dropped packets to syslog, first log it ###

```bash
/sbin/iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "PORT 80 DROP: " --log-level 7
 
### now drop it ###
/sbin/iptables -A INPUT -p tcp --destination-port 80 -j DROP
```