The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/demo present on Storage server in Stratos DC. However, they reported an issue with the recent commits being pushed to this repo. They have asked the DevOps team to revert repo HEAD to last commit. Below are more details about the task:


In /usr/src/kodekloudrepos/demo git repository, revert the latest commit ( HEAD ) to the previous commit (JFYI the previous commit hash should be with initial commit message ).


Use revert demo message (please use all small letters for commit message) for the new revert commit.


## SOLUTION

**Git Revert** creates a new commit that undoes the changes made by a previous commit without altering the commit history.

```bash
cd /usr/src/kodekloudrepos/demo
sudo -i

[natasha@ststor01 demo]$ git log --oneline        
0664aa1 (HEAD -> master, origin/master) add data.txt file
4bd9d08 initial commit

git revert HEAD -n

git status

git add .

git commit -m "initial commit"
```