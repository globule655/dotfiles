{ inputs, outputs, lib, config, pkgs, ... }:
{

  imports = [
    ./windowManager
    ./global
    ./packages
  ];

  sway-wm.enable = true;
  hyprland-wm.enable = false;
  work-packages.enable = true;

  home = {
    username = "gdebros";
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../waybar;
    };
    sessionVariables = {
      EDITOR = "nvim";
      VAULT_PATH = "$HOME/Documents/git_perso/doc.git/main";
    };
  };

  # https://nixos.wiki/wiki/Home_Manager#Usage_on_non-NixOS_Linux
  targets.genericLinux.enable = true;

  programs = {
    git = {
      userName = "gdebros";
      userEmail = "guillaume.debros@digeiz.com";
    };
    zsh = {
      shellAliases = {
        ov = "cd $VAULT_PATH && nvim .";
      };
    };
  };

}

