# stylecheck-hook
### [Installation] ###

To install the hook into your repository:
1. Clone this repository 
2. Navigate into the folder and run `install.sh` script with YOUR_REPOSITORY_PATH as the argument

**To get the latest available revision prior to installation use [--latest] parameter. `install.sh YOUR_REPOSITORY_PATH --latest`*

### [Description] ###

Code style policy checks tightly coupled with the open-source static-code analytic tool http://checkstyle.sourceforge.net
which is embeded into this tool.

The hook will be automatically triggered on each commit against the files that currently in the INDEX (after `git add`)
The **checkstyle** lib goes through the entire file and the hook will filter out only afftected lines (actual changes)

### [Usage] ###
After succesfull installation the hook would be executed on PRE-COMMIT phase once `git commit` command is issued
To trigger the check manually without doing the actual commit there is a command `git verify`.

(*NOTE: `git verify` will take into account only staged files*)

To bypass the check use the following syntax: `git commit -m "Your commit message" --no-verify`

That will strip the hook off the commit process ~~and life will get back to normal again :)~~

Example command output:

![Example output](https://raw.githubusercontent.com/dshelya-gonefire/stylecheck-hook/master/example_output.png)

### [Pre-configured policies] ###


### [Known Issues] ###
