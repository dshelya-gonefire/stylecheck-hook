#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage [install.sh PATH_TO_REPOSITORY]"
	exit
fi

if [[ ! -d "checker" ]]; then
    echo "Please run the install.sh directly from its folder"
	exit
fi

if [[ "$2" == "--latest" ]]; then
	echo -e "------------------------------"
    echo -n "Checking for updates...  "
	### rename itself to install.sh.old
	mv $0 $0.old
	
	git reset --hard > /dev/null
	git fetch -p > /dev/null && git rebase > /dev/null
	
	echo "done"
	echo -e "------------------------------\n"
fi

REPOSITORY_PATH=$1
ENGINE_DIR=~/stylecheck
GIT_DIR=/.git
GIT_HOOKS_DIR=/hooks

if [ ! -d "$REPOSITORY_PATH/$GIT_DIR" ]; then
    echo "Unable to find repository folder: [$REPOSITORY_PATH]"
	exit
fi

if [ ! -d "$REPOSITORY_PATH/$GIT_DIR" ]; then
    echo "Invalid repository: [$REPOSITORY_PATH]"
	exit
fi

if [ ! -d "$REPOSITORY_PATH/$GIT_DIR/$GIT_HOOKS_DIR" ]; then
    echo "Unable to find [$GIT_HOOKS_DIR] directory. Creating..."
	mkdir $REPOSITORY_PATH/$GIT_DIR/$GIT_HOOKS_DIR
fi

if [ ! -d "$REPOSITORY_PATH/$GIT_DIR/$GIT_HOOKS_DIR" ]; then
    echo "Cannot create [$GIT_HOOKS_DIR] directory. Halting :("
	exit
fi

echo "Installing hooks into repository: $REPOSITORY_PATH$GIT_DIR$GIT_HOOKS_DIR"
mkdir -p "$ENGINE_DIR"
cp checker/* "$ENGINE_DIR"
 
git config --global --unset-all check.engine
git config --global --unset-all check.style
git config --global --add check.engine "$ENGINE_DIR/checkstyle.jar"
git config --global --add check.style "$ENGINE_DIR/style.xml"
git config --global alias.verify '!sh .git/hooks/pre-commit'
 
cp hook/* "$REPOSITORY_PATH/$GIT_DIR/$GIT_HOOKS_DIR"

### Create aliased installer script for patched repository
if [[ "$1" != "." ]]; then
    ALIAS_NAME=`echo $1 | sed 's/.*\/\([a-zA-Z0-9_. -]\+$\)/\1/gi'`
	else
	ALIAS_NAME=`pwd | sed 's/.*\/\([a-zA-Z0-9_. -]\+$\)/\1/gi'`
fi

echo "./install.sh $1 \$1" > "install.$ALIAS_NAME.sh"
rm $0.old -f

echo Done!
