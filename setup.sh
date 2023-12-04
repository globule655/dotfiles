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
  zsh
  )

get_latest_release () {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

ZELLIJ_VERSION=$(get_latest_release zellij-org/zellij)

find_os () {
  if [ 'ID_LIKE' in /etc/os-release ]; then
    os=$(cat /etc/os-release |grep "ID_LIKE" | cut -d'=' -f2)
  else
    os=$(cat /etc/os-release | grep "^ID=" | cut -d'=' -f2)
  fi
  echo $os
}

third_parties () {
  case "$(find_os)" in
    "debian") wget -O /tmp/zellij.tar.gz https://github.com/zellij-org/zellij/releases/download/$ZELLIJ_VERSION/zellij-x86_64-unknown-linux-musl.tar.gz
      tar -xvzf /tmp/zellij.tar.gz -C /usr/bin && chmod 755 /usr/bin/zellij
      ;;
    "fedora") dnf copr enable varlad/zellij && dnf install -y zellij
      ;;
    *) echo 'system not supported' && exit 1
      ;;
  esac
    }

package_install () {
  case "$(find_os)" in
    "debian") apt update && apt install -y gpg \
      && mkdir -p /etc/apt/keyrings \
      && wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg \
      && echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list \
      && chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list \
      && apt update && apt install -y $1
      ;;
    "fedora") dnf install -y $1
      ;;
    *) echo 'system not supported' && exit 1
      ;;
  esac
}

