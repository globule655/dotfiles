{ inputs, outputs, lib, config, pkgs, ... }:
let
  username = "globule";
in
{

  imports = [
    ./global
    ./windowManager
    ./packages
  ];

  nixpkgs_conf.enable = false;
  sway-wm.enable = false;
  hyprland-wm.enable = true;
  work-packages.enable = true;
  stream-packages.enable = true;

  home = {
    username = username;
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../hypr-waybar;
      ".config/hypr".source = ../hypr;
      ".config/ghostty".source = ../ghostty;
      ".config/wl-kbptr".source = ../wl-kbptr;
      ".config/wallpaper/wallpaper.jpg".source = ../wallpaper/Fantasy-Landscape3.jpg;
      ".config/mcphub".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/mcphub";
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/nvim";
      ".config/opencode".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/opencode";
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

