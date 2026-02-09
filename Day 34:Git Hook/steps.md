## Question
The Nautilus application development team was working on a git repository /opt/apps.git which is cloned under /usr/src/kodekloudrepos directory present on Storage server in Stratos DC. The team want to setup a hook on this repository, please find below more details:


1. **Merge** the feature branch into the master branch, but before pushing your changes complete below point.

2. Create a **post-update hook** in this git repository so that whenever any changes are pushed to the master branch, it creates a release** tag** with name **release-2023-06-15**, where 2023-06-15 is supposed to be the current date. For example if today is 20th June, 2023 then the release tag must be **release-2023-06-20**. Make sure you test the hook at least once and create a release tag for today's release.

Finally remember to push your changes.
Note: Perform this task using the natasha user, and ensure the repository or existing directory permissions are not altered.

## SOLUTION

Steps:


```bash
# 1. First ssh into the storage server 
ssh natasha@ststor01

# 2. Navigate to hooks directory
cd /opt/blog.git/hooks

# 3. Create the post-update using hooks/post-update.sample
cp post-update.sample post-update

# 4. We need to populate this file with script

#!/bin/sh
# post-update hook: always create today's release tag for master

TODAY=$(date +%F)

for ref in "$@"; do
    if [[ echo "$ref" == "refs/heads/master" ]]; then
        tag=release-$TODAY
        git tag $tag
    fi
done
exit 0

#5. Make the hook executable
chmod +x post-update

# 6. Now, merging feature into master
cd /usr/src/kodekloudrepos/blog
git checkout master
git merge --no-ff feature -m "Merging feature branch into master branch"

# 7. Push master to trigger the hook
git push

# 8. Fetch tags 
git fetch --tags
git tag

```