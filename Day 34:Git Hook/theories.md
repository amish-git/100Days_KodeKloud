

#### Some theories first:
**Git Hooks** are scripts that Git can execute automatically when certain events occur, such as before or after a commit, push, or merge.

#### Installing hooks

- Hooks reside in the **.git/hooks** directory of every Git repository.

- Hooks need to be executable, so we need to change the file permissions of the script.

#### Scope of hooks
Hooks are local to any given Git repository, and they are not copied over to the new repository when you run git clone. 

And, since hooks are local, they can be altered by anybody with access to the repository.


#### Local hooks
Local hooks affect only the repository in which they reside. 
(pre-commit,prepare-commit-msg,commit-msg,post-commit,post-checkout,pre-rebase)

#### Server-side hooks
Server-side hooks work just like local ones, except they reside in server-side repositories (e.g., a central repository, or a developer’s public repository). 
(pre-receive,update,post-receive)

```
$@ expands to: arg1 arg2 arg3
$# is the count: 3


cd /opt/
tag=release-$(date "+%Y-%m-%d")
git tag $tag


#Example usage of $@ and "$@"
script.sh "hello world" "foo bar"

# $@ splits on spaces
for arg in $@; do
    echo "[$arg]"
done

# Output:
# [hello]
# [world]
# [foo]
# [bar]

#!/bin/bash
script.sh "hello world" "foo bar"

# "$@" preserves the original arguments
for arg in "$@"; do
    echo "[$arg]"
done

# Output:
# [hello world]
