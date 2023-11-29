#!/bin/bash

# Install all needed packages and setup environment
# detect os distribution

pkgs=(
  make
  cmake
  gcc
  git
  unzip
  eza
  )

find_os () {
  if [ 'ID_LIKE' in /etc/os-release ]; then
    os=$(cat /etc/os-release |grep "ID_LIKE" | cut -d'=' -f2)
  else
    os=$(cat /etc/os-release | grep "^ID=" | cut -d'=' -f2)
  fi
  echo $os
}

package_install ($pkgs) {
  case "$(find_os)" in
    "debian") apt update && apt install -y gpg \
      && mkdir -p /etc/apt/keyrings \
      && wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg \
      && echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list \
      && chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list \
      && apt update && apt install -y $pkgs
      ;;
    "fedora") dnf install -y $pkgs
      ;;
    *) echo 'system not supported' && exit 1
      ;;
  esac
}

