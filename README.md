# stylecheck-hook
To install the hook into your repository:
1. Clone this repository 
2. Navigate into the folder and run `install.sh` script with YOUR_REPOSITORY_PATH as the argument

The check will be triggered on each commit and the hook will perform pre-validation only against afftected lines (actual changes)

To bypass the check use the following syntax: `git commit -m "Your commit message" --no-verify`

Example output (executed from bash-console):

![Example output](https://raw.githubusercontent.com/dshelya-gonefire/stylecheck-hook/master/example_output.png)