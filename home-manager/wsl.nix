{ inputs, outputs, lib, config, pkgs, ... }:
{

  imports = [
    ./windowManager
    ./global
    ./packages
  ];

  sway-wm.enable = false;
  hyprland-wm.enable = false;

  home = {
    username = "globule";
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../waybar;
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # https://nixos.wiki/wiki/Home_Manager#Usage_on_non-NixOS_Linux
  targets.genericLinux.enable = true;

  programs = {
    zsh = {
      shellAliases = {
        sudo = "sudo --preserve-env=PATH";
      };
    };
  };

}

