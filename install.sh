#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage [install.sh PATH_TO_REPOSITORY]"
	exit
fi

ENGINE_DIR=~/stylecheck
GIT_HOOKS_DIR=$1/.git/hooks

if [ ! -d "$GIT_HOOKS_DIR" ]; then
    echo "Invalid repository path"
	exit
fi

echo "Installing hooks into repository: $GIT_HOOKS_DIR"
mkdir -p $ENGINE_DIR
cp checker/* $ENGINE_DIR
 
git config --global --unset-all check.engine
git config --global --unset-all check.style
git config --global --add check.engine $ENGINE_DIR/checkstyle.jar
git config --global --add check.style $ENGINE_DIR/style.xml

cp hook/* $GIT_HOOKS_DIR

