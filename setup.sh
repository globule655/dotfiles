#!/bin/bash

# Install all needed packages and setup environment
# detect os distribution

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
NERD_FONT_NAME=JetBrainsMono
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/${NERD_FONT_NAME}.zip"

pkgs=(
  make
  cmake
  gcc
  gcc-c++
  nodejs-npm
  git
  tmux
  kitty
  unzip
  eza
  zsh
  zoxide
  sway
  waybar
  rofi
  )

zsh_plugs=(
  https://github.com/zsh-users/zsh-autosuggestions.git
  https://github.com/zsh-users/zsh-syntax-highlighting.git
  )

docker_pkgs=(
  docker-ce
  docker-ce-cli
  containerd.io
  docker-compose-plugin
  docker-buildx-plugin
  )

get_latest_release () {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

ZELLIJ_VERSION=$(get_latest_release zellij-org/zellij)

clone_plugs () {
  su $SUDO_USER -c "mkdir -p /home/$SUDO_USER/.zsh" && cd /home/$SUDO_USER/.zsh
  for repos in "${zsh_plugs[@]}"; do
    su $SUDO_USER -c "git clone $repos"
  done
}

find_os () {
  if [ $(grep -Fxq 'ID_LIKE' /etc/os-release) ]; then
    os=$(cat /etc/os-release |grep "ID_LIKE" | cut -d'=' -f2)
  else
    os=$(cat /etc/os-release | grep "^ID=" | cut -d'=' -f2)
  fi
  echo $os
}

create_symlinks () {
  su $SUDO_USER -c "mkdir -p /home/$SUDO_USER/.config"
  cd $SCRIPT_DIR
  for file in $(find $SCRIPT_DIR -maxdepth 1 -type d -not -path '*.git' | tail -n +2); do
    su $SUDO_USER -c "ln -sf $file /home/$SUDO_USER/.config/$(echo $file | awk -F/ '{print $NF}')"
  done
  su $SUDO_USER -c "ln -sf $SCRIPT_DIR/zshrc /home/$SUDO_USER/.zshrc"
}

install_fonts () {
  cd /tmp
  su $SUDO_USER -c "wget -qO $NERD_FONT_NAME.zip $NERD_FONT_URL && unzip -j $NERD_FONT_NAME.zip -d /home/$SUDO_USER/.local/share/fonts"
  rm -f $NERD_FONT_NAME.zip
  cd $HOME
}

third_parties () {
  case "$(find_os)" in
    "debian") wget -O /tmp/zellij.tar.gz https://github.com/zellij-org/zellij/releases/download/$ZELLIJ_VERSION/zellij-x86_64-unknown-linux-musl.tar.gz \
      && tar -xvzf /tmp/zellij.tar.gz -C /usr/bin && chmod 755 /usr/bin/zellij \
      && curl -sS https://starship.rs/install.sh | sh -s -- -y \
      && su $SUDO_USER -c "curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh" \
      && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
      && cd /tmp && wget -qO neovim https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && mv neovim /usr/local/bin/nvim \
      && chown root:root /usr/local/bin/nvim && chmod 755 /usr/local/bin/nvim
      ;;
    "fedora") dnf copr enable varlad/zellij && dnf install -y zellij \
      && curl -sS https://starship.rs/install.sh | sh -s -- -y \
      && su $SUDO_USER -c "curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh" \
      && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
      && cd /tmp && wget -qO neovim https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && mv neovim /usr/local/bin/nvim \
      && chown root:root /usr/local/bin/nvim && chmod 755 /usr/local/bin/nvim
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
      && apt update && apt install -y $pkgs
      ;;
    "fedora") dnf install -y dnf-plugins-core \
      && dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo \
      && dnf install -y ${pkgs[@]} \
      && dnf install -y ${docker_pkgs[@]} \
      && systemctl start docker && systemctl enable docker
      ;;
    *) echo 'system not supported' && exit 1
      ;;
  esac
}


clone_plugs
create_symlinks
package_install
install_fonts
third_parties
