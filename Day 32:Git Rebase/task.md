The Nautilus application development team has been working on a project repository /opt/demo.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with DevOps team:



One of the developers is working on feature branch and their work is still in progress, however there are some changes which have been pushed into the master branch, the developer now wants to rebase the feature branch with the master branch without loosing any data from the feature branch, also they don't want to add any merge commit by simply merging the master branch into the feature branch. Accomplish this task as per requirements mentioned.


Also remember to push your changes once done.

[root@ststor01 demo]#  git log
commit dc3e8344bbb4ed168be0bded9569ff3fbcb3e3d0 (HEAD -> feature, origin/feature)
Author: Admin <admin@kodekloud.com>
Date:   Wed Jan 21 16:14:30 2026 +0000

    Add new feature

commit e4b27619421e2224779edd8c47886c1586f8ad44
Author: Admin <admin@kodekloud.com>
Date:   Wed Jan 21 16:14:30 2026 +0000

    initial commit


[root@ststor01 demo]#  git checkout master
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
[root@ststor01 demo]# git log 
commit 0bbb7480cb43372336ff84e3c35f2a6853dd1306 (HEAD -> master, origin/master)
Author: Admin <admin@kodekloud.com>
Date:   Wed Jan 21 16:14:31 2026 +0000

    Update info.txt

commit e4b27619421e2224779edd8c47886c1586f8ad44
Author: Admin <admin@kodekloud.com>
Date:   Wed Jan 21 16:14:30 2026 +0000


[root@ststor01 demo]#  git remote -v
origin  /opt/demo.git (fetch)
origin  /opt/demo.git (push)
[root@ststor01 demo]# git fetch origin master
From /opt/demo
 * branch            master     -> FETCH_HEAD
[root@ststor01 demo]#  git log
commit 790a9b13a308931b0f9bba98e19c48342e0412a1 (HEAD -> feature, origin/feature)
Author: Admin <admin@kodekloud.com>
Date:   Wed Jan 21 17:34:40 2026 +0000

    Add new feature

commit ab53f9855ff92e4d382270f741df877b04924cdf
Author: Admin <admin@kodekloud.com>
Date:   Wed Jan 21 17:34:40 2026 +0000

    initial commit
[root@ststor01 demo]# git fetch -a
[root@ststor01 demo]# git status
On branch feature
nothing to commit, working tree clean
[root@ststor01 demo]# git rebase origin/master
Successfully rebased and updated refs/heads/feature.
[root@ststor01 demo]#  git status
On branch feature


[root@ststor01 demo]# git push -u origin feature
To /opt/demo.git
 ! [rejected]        feature -> feature (non-fast-forward)
error: failed to push some refs to '/opt/demo.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. If you want to integrate the remote changes,
hint: use 'git pull' before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
[root@ststor01 demo]# git push -u origin feature -f
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 16 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 297 bytes | 297.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To /opt/demo.git
 + 790a9b1...32f4bb4 feature -> feature (forced update)
branch 'feature' set up to track 'origin/feature'.