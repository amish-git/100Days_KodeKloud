Security-Enhanced Linux is a kernel security module created by the National Security Agency to provide a mechanism for access control policies. SELinux includes a set of kernel modifications and user tools to help configure access control policies on Linux.

SELinux can cause problems with applications that behave outside the norm. Web servers, like Nginx or Apache, configure apps to serve sites from a directory that doesn't follow the default document root. Get site-specific data from /srv/www instead of /var/www. Apache or Nginx blocks web servers from serving up content from the nonstandard directory unless SELinux is aware of the change.

Some admins disable SELinux on their servers due to complications with app configuration due to the policies' restrictions. This could leave servers open to attacks, however. Knowing how to write a SELinux policy enables developers to work with confined rules.

# SELinux domains

Writing a SELinux policy isn't like writing a Bash script. Complicated files aren't created and executed with SELinux. Instead, think of them more like iptables rules. SELinux policies set domains and disable various Boolean values.

Each SELinux domain takes care of a specific aspect of the system. The five different domains are as follows:

1. inti_t. Systemd.
2. httpd_t. HTTP daemon threads.
3. kernel_t. Kernel threads.
4. syslogd_t. The logging daemons for journald and rsyslogd.
5. unconfined_t. Processes executed by users in the unconfined domain.

## SELinux context

SELinux context contains additional information. The four different SELinux contexts are the following:

1. SELinux user. Linux users mapped to SELinux users.
2. Role. A role-based access control attribute that serves as an intermediary between domains and SELinux users.
3. Type. Definition of a domain for processes.
4. Level. Optional information that is an attribute of Multi-Level Security and Multi-Category Security.

### Policies

The two different types of policies are Targeted and Multi-Level Security:

1. **Targeted**. Applies access controls to a limited number of processes that are most likely to be the targets of an attack.
2. **Multi-Level Security**. Applies access controls to multiple levels of processes, each of which might have different rules for different users.

#### How to create an SELinux policy

Create a custom SELinux policy by enabling or disabling Boolean values so the application can run in a confined manner. Install the policycoreutils-devel package before creating a policy with the command:

```bash
sudo dnf install policycoreutils-devel -y
```

Let's say the app opens the /var/log/messages log file for writing. The process should not run unconfined by SELinux. This would enable the app to be hijacked and potentially used for bad purposes. Run the same process as confined to not have this issue.

For tutorial purposes, the newly created app is called sampleapp and should be installed into /usr/local/bin. Create a systemd service file to start and stop the service with ease. Once this is up and running, confirm it's running unconfined with the following command:

```bash
ps -efZ | grep sampleapp
```

The output of the above command might look like this:

```bash
system_u:system_r:unconfined_service_t:s0 root 366386  1  0 14:22 ?        00:00:00 /usr/local/bin/sampleapp
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 jack 372703 243891  0 14:28 pts/1 00:00:00 grep --color=auto sampleapp
```
The key bit of information is unconfined_service_t. Now, generate a custom policy for the app with the following command:

```bash
sudo sepolicy generate --init /usr/local/bin/sampleapp
```
The output looks like this:

```bash
Created the following files:
/home/jack/sampleapp.te # Type Enforcement file
/home/jack/sampleapp.if # Interface file
/home/jack/sampleapp.fc # File Contexts file
/home/jack/sampleapp_selinux.spec # Spec file
/home/jack/sampleapp.sh # Setup Script
```

The sepolicy command generated a setup script, called sampleapp.sh. Now, you can rebuild a system policy that uses the setup script with the following command:

```bash
sudo bash sampleapp.sh
```

The script should complete in under a minute and relabels the required portion of the file system with the restorecon command. If the output indicates that the rpmbuild wasn't found, install it with the following:

```bash
sudo dnf install rpm-build -y
```

Then, rerun the sampleapp.sh script.

Restart the app with the following:

```bash
sudo systemctl restart sampleapp
```

Once again, check the status of the app to see if it's running confined with the following command:

```bash
sudo sealert -l "*"
```

Near the bottom of that output, in the section for sampleapp, this line should appear:

```bash
SELinux is preventing /usr/local/bin/sampleapp from write access on the file /var/log/messages.
```

Your new application is now confined by SELinux.

The above points include the basics for writing a custom SELinux policy. These are helpful when creating applications for an SELinux-enabled server and ensure they are protected within the system.
