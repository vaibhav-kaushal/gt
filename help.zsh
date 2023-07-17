#!/usr/bin/env zsh

if [[ $# -eq 0 ]]; then
  return
fi

# We handle the help case here to make sure that other checks work as expected
pr default "This tool is a helper for git shortcuts\n"
pr default "Usage: "
pr default "$1 option [params]\n"
pr default "Where 'option' is one of: "
pr default "  s  : Shows configuration within git."
pr default "  sk : Switches the keys used for connecting to remotes"
pr default "  cp : Commits and Pushes the current branch to remote"
pr default "  cpb: Same as 'cp' but uses the current branch name as first word of commit message"
pr default "  ogh: Opens the GitHub Page for a given repo."
pr default "       This option can take more arguments. To read help about the ogh option, run:"
pr default "       $1 ogh help"
pr default ""
pr default "NOTE 1: Help is available for all options by typing '$1 <option> help'"
pr magenta "NOTE 2: This tool will not run when inside directories where a git repo is not found.\n"
