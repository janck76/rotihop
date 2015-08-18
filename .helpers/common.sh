#!/bin/bash - 

# Default name for production branch
# Override with: export PROD_BRANCH=<branch_name>
x=${PROD_BRANCH:='master'}

function suggest {
    current_branch=$(git branch|perl -ne 'print "$1\n" if(/^\*\s(.*)/)')
    remote_branch=$(git branch -vv|perl -ne 'print "$1\n" if(/^\*.*\[(.*?)[:\]].*/)')
    
    echo "Producion branch: $PROD_BRANCH (Override: export PROD_BRANCH=name)"
    echo You should probably:
    echo git log --stat ..$remote_branch
    if [[ $current_branch == $PROD_BRANCH ]]; then
        echo git merge $remote_branch
    else
        echo git rebase $remote_branch
    fi
}
