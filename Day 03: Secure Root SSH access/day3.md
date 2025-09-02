
Following security audits, the xFusionCorp Industries security team has rolled out new protocols,
including the restriction of direct root SSH login.

Your task is to disable direct SSH root login on all app servers within the Stratos Datacenter.

To disable direct SSH root login on all app servers in Stratos Datacenter, you can follow these steps:

Connect to each app server using SSH as a user with administrative privileges.
Open the SSH server configuration file using a text editor. The location of the file may vary depending on the Linux distribution, but it is commonly found at /etc/ssh/sshd_config.
Search for the PermitRootLogin directive in the SSH server configuration file. By default, it may be set to yes or prohibit-password.
Change the value of PermitRootLogin to no. If the directive is commented out with a # at the beginning, remove the # symbol.
Save the changes and exit the text editor.
Restart the SSH service to apply the new configuration using sudo systemctl restart sshd
Repeat these steps for each app server in the Stratos Datacenter.

By disabling direct SSH root login, you enhance the security of your servers by preventing attackers from attempting to log in directly as the root user. Instead, it is recommended to log in as a regular user with administrative privileges and then switch to the root user using the sudo command when necessary.

