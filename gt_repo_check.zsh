!/usr/bin/env zsh

git status >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
  clpr red "Directory does not contain a git repo!!"
  clpr default "Please run 'gt help' to read usage."
  clpr red "Exiting!"
  return 1
fi

return 0
