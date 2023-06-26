#!/usr/bin/env zsh

git status >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
  pr red "Directory does not contain a git repo!!"
  pr default "Please run 'gt help' to read usage."
  pr red "Exiting!"
  return 1
fi

return 0
