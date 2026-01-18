The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/blog present on Storage server in Stratos DC. One of the developers stashed some in-progress changes in this repository, but now they want to restore some of the stashed changes. Find below more details to accomplish this task:



Look for the stashed changes under /usr/src/kodekloudrepos/blog git repository, and restore the stash with stash@{1} identifier. Further, commit and push your changes to the origin.

git stash temporarily shelves (or stashes) changes you've made to your working copy so you can work on something else, and then come back and re-apply them later on

Popping your stash removes the changes from your stash and reapplies them to your working copy.

Alternatively, you can reapply the changes to your working copy and keep them in your stash with git stash apply:



[root@ststor01 blog]# git stash list
stash@{0}: WIP on master: 28d8962 initial commit
stash@{1}: WIP on master: 28d8962 initial commit
[root@ststor01 blog]# git stash apply stash@{1}
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   welcome.txt

[root@ststor01 blog]# git commit -m"apply stash"
[master 4b523d8] apply stash
 1 file changed, 1 insertion(+)
 create mode 100644 welcome.txt
[root@ststor01 blog]# git push origin master
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 16 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 303 bytes | 303.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To /opt/blog.git
   28d8962..4b523d8  master -> master