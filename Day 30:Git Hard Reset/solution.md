The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/news present on Storage server in Stratos DC. This was just a test repository and one of the developers just pushed a couple of changes for testing, but now they want to clean this repository along with the commit history/work tree, so they want to point back the HEAD and the branch itself to a commit with message add data.txt file. Find below more details:



In /usr/src/kodekloudrepos/news git repository, reset the git commit history so that there are only two commits in the commit history i.e initial commit and add data.txt file.


Also make sure to push your changes.

commit f242a4dc95d1ce814aa90feb58f74dcc5ddee7bd
Author: Admin <admin@kodekloud.com>
Date:   Sat Jan 17 17:45:16 2026 +0000

    add data.txt file

commit 9e3d2a3096592e8b8bc12736ef46ba4f715357c1
Author: Admin <admin@kodekloud.com>
Date:   Sat Jan 17 17:45:16 2026 +0000

    initial commit


[root@ststor01 news]# git reset --hard f242a4dc95d1ce814aa90feb58f74dcc5ddee7bdHEAD is now at f242a4d add data.txt file
[root@ststor01 news]# git log --oneline
f242a4d (HEAD -> master) add data.txt file
9e3d2a3 initial commit