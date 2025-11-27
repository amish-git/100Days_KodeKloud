cd /usr/src/kodekloudrepos
sudo git clone /opt/news.git 

#Check the status of the repository
git status

#lists all the remote repositories (remotes) configured for your current Git repository
git remote -v

#adds a specific directory to your global Git "safe directories" whitelist
#It tells Git, "Hey, treat /usr/src/kodekloudrepos/news as a trusted directory where I can safely run Git commands, even if it's not owned by me." (src:Grok)
git config --global --add safe.directory /usr/src/kodekloudrepos/news