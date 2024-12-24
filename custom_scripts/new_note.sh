#!/usr/bin/env zsh

VAULT_DIR="$HOME/Documents/git_perso/doc.git/main"

if [ -z "$1" ]; then
  echo "Error: A file name must be set, e.g. on \"the wonderful thing about tiggers\"."
  exit 1
fi

file_name=$(echo "$1" | tr ' ' '-')
formatted_file_name=$(date "+%Y-%m-%d")_${file_name}.md
cd "$VAULT_DIR" || exit
touch "inbox/${formatted_file_name}"
nvim "inbox/${formatted_file_name}"
