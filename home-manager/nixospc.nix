{ inputs, outputs, lib, config, pkgs, ... }:
{

  imports = [
    ./global
    ./windowManager
    ./packages
  ];

  nixpkgs_conf.enable = false;
  sway-wm.enable = false;
  hyprland-wm.enable = false;
  work-packages.enable = true;
  stream-packages.enable = true;

  home = {
    username = "globule";
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../waybar;
      ".config/hypr".source = ../hypr;
      ".config/ghostty".source = ../ghostty;
      ".config/wl-kbptr".source = ../wl-kbptr;
    };
    sessionVariables = {
      EDITOR = "nvim";
      VAULT_PATH = "$HOME/Documents/git_perso/doc.git/main";
    };
  };

  programs = {
    git = {
      userName = "globule";
      userEmail = "globule655@gmail.com";
    };
    zsh = {
      shellAliases = {
        ov = "cd $VAULT_PATH && nvim .";
      };
    };
  };

}

