During the weekly meeting, the Nautilus DevOps team discussed about the automation and configuration
management solutions that they want to implement. While considering several
options, the team has decided to go with Ansible for now due to its simple
setup and minimal pre-requisites. The team wanted to start testing using Ansible, 
so they have decided to use jump host as an Ansible controller to test 
different kind of tasks on rest of the servers.


**Task**

Install ansible version **4.10.0** on Jump host **using pip3 only**. Make sure Ansible binary is available globally on this system, i.e all users on this system are able to run Ansible commands.

```bash
sudo pip3 install "ansible==4.10.0"
sudo pip3 install ansible==4.7.0  //global 
```

From Ansible [Docs](https://docs.ansible.com/ansible/5/installation_guide/intro_installation.html)

If you wish to install Ansible globally, run the following commands:

```bash
$ sudo python3 get-pip.py
$ sudo python3 -m pip3 install ansible
```