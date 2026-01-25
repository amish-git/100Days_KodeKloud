Sarah and Max were working on writting some stories which they have pushed to the repository. Max has recently added some new changes and is trying to push them to the repository but he is facing some issues. Below you can find more details:


SSH into storage server using user max and password Max_pass123. Under /home/max you will find the story-blog repository. Try to push the changes to the origin repo and fix the issues. The story-index.txt must have titles for all 4 stories. Additionally, there is a typo in The Lion and the Mooose line where Mooose should be Mouse.


Click on the Gitea UI button on the top bar. You should be able to access the Gitea page. You can login to Gitea server from UI using username sarah and password Sarah_pass123 or username max and password Max_pass123.


Note: For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.






max (master)$  git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
max (master)$  git branch
* master
max (master)$ git push origin master
Username for 'http://git.stratos.xfusioncorp.com': max
Password for 'http://max@git.stratos.xfusioncorp.com': 
To http://git.stratos.xfusioncorp.com/sarah/story-blog.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'http://git.stratos.xfusioncorp.com/sarah/story-blog.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.


max (master)$ git pull --rebase
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
From http://git.stratos.xfusioncorp.com/sarah/story-blog
   f91b850..4402284  master     -> origin/master
First, rewinding head to replay your work on top of it...
Applying: Added the fox and grapes story
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging story-index.txt
CONFLICT (add/add): Merge conflict in story-index.txt
error: Failed to merge in the changes.
Patch failed at 0001 Added the fox and grapes story
The copy of the patch that failed is found in: .git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

max ((no branch, rebasing master))$ git status
rebase in progress; onto 4402284
You are currently rebasing branch 'master' on '4402284'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   fox-and-grapes.txt

Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution)

        both added:      story-index.txt

max ((no branch, rebasing master))$  vi story-index.txt 
max ((no branch, rebasing master))$ git status
rebase in progress; onto 4402284
You are currently rebasing branch 'master' on '4402284'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   fox-and-grapes.txt

Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution)

        both added:      story-index.txt

max ((no branch, rebasing master))$ git add story-index.txt 
max ((no branch, rebasing master))$ git rebase --continue
Applying: Added the fox and grapes story
Applying: fix: typo error fix
Using index info to reconstruct a base tree...
M       story-index.txt
Falling back to patching base and 3-way merge...
No changes -- Patch already applied.
max (master)$  git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
max (master)$ git push -u origin master
Username for 'http://git.stratos.xfusioncorp.com': max
Password for 'http://max@git.stratos.xfusioncorp.com': 
Counting objects: 4, done.
Delta compression using up to 16 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 882 bytes | 0 bytes/s, done.
Total 4 (delta 0), reused 0 (delta 0)
remote: . Processing 1 references
remote: Processed 1 references in total
To http://git.stratos.xfusioncorp.com/sarah/story-blog.git
   4402284..552cc9d  master -> master
Branch master set up to track remote branch master from origin.
max (master)$  git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean



Git pull --rebase combines git fetch and git rebase to update your local branch with the latest changes from a remote repository while maintaining a clean, linear commit history. 