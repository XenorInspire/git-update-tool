# This script was made by Xen0rInspire

# This script is used to update several git repositories (public or private ones) in the current directory
# It updates all their branches
# It is intended to be used with cron or systemd timers.

#!/bin/bash

declare -a git_directories

# Get all the directories in the current directory
git_directories=($(for i in $(ls -d */); do echo ${i%%/}; done))
# For any directory
for git_directory in ${git_directories[*]}; do

    echo "================================="
    echo "    Updating $git_directory"
    echo "================================="
    # Go to the directory
    pushd $git_directory
    # Update all the branches
    for branch in $(git branch -a | grep remotes | grep -v HEAD); do
        echo "Updating $branch"
        git branch --track ${branch#remotes/origin/} $branch 2> /dev/null
        git pull
        echo "---------------------------------"
    done
    popd
done
