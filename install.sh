#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage [install.sh PATH_TO_REPOSITORY]"
	exit
fi

if [[ ! -d "checker" ]]; then
    echo "Please run the install.sh directly from its folder"
	exit
fi

ENGINE_DIR=~/stylecheck
GIT_HOOKS_DIR=$1/.git/hooks

if [ ! -d "$GIT_HOOKS_DIR" ]; then
    echo "Invalid repository path: [$GIT_HOOKS_DIR]"
	exit
fi

echo "Installing hooks into repository: $GIT_HOOKS_DIR"
mkdir -p "$ENGINE_DIR"
cp checker/* "$ENGINE_DIR"
 
git config --global --unset-all check.engine
git config --global --unset-all check.style
git config --global --add check.engine "$ENGINE_DIR/checkstyle.jar"
git config --global --add check.style "$ENGINE_DIR/style.xml"
git config --global alias.verify '!sh .git/hooks/pre-commit'
 
cp hook/* "$GIT_HOOKS_DIR"

### Create aliased installer script for patched repository
if [[ "$1" != "." ]]; then
    ALIAS_NAME=`echo $1 | sed 's/.*\/\([a-zA-Z0-9_. -]\+$\)/\1/gi'`
	else
	ALIAS_NAME=`pwd | sed 's/.*\/\([a-zA-Z0-9_. -]\+$\)/\1/gi'`
fi

echo "./install.sh $1" > "install.$ALIAS_NAME.sh"
echo Done!
