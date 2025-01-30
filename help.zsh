#!/usr/bin/env zsh

if [[ $# -eq 0 ]]; then
  return
fi

# We handle the help case here to make sure that other checks work as expected
clpr default "This tool is a helper for git shortcuts\n"
clpr default "Usage: "
clpr default "$1 option [params]\n"
clpr default "Where 'option' is one of: "
clpr default "  s  : Shows configuration within git."
clpr default "  sk : Switches the keys used for connecting to remotes"
clpr default "  cp : Commits and Pushes the current branch to remote"
clpr default "  cpb: Same as 'cp' but uses the current branch name as first word of commit message"
clpr default "  ogh: Opens the GitHub Page for a given repo."
clpr default "       This option can take more arguments. To read help about the ogh option, run:"
clpr default "       $1 ogh help"
clpr default ""
clpr default "NOTE 1: Help is available for all options by typing '$1 <option> help'"
clpr magenta "NOTE 2: This tool will not run when inside directories where a git repo is not found.\n"
