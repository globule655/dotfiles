#!/bin/bash

# Rewrite of the setup script to setup everything with nixpkgs

# Install system packages
sudo dnf install -y sway kitty

# check if nix command exists
if ! [ -x "$(command -v nix)" ]; then
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi

# source nix environment
. $HOME/.nix-profile/etc/profile.d/nix.sh

# Symlink the dotfiles directory
mkdir -p $HOME/.config
ln -sf $HOME/.dotfiles $HOME/.config/home-manager
# Backup bashrc and bash_profile files
mv $HOME/.bashrc{,.bkp}
mv $HOME/.bash_profile{,.bkp}
# Allows sway to load nix installed binaries
echo "$HOME/.nix-profile/bin:$PATH" > $HOME/.config/environment.d/sway.conf

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
