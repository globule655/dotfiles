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
  work-packages.enable = false;
  stream-packages.enable = false;

  home = {
    username = "fanny";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs = {
    zsh = {
      shellAliases = {
        ov = "cd $VAULT_PATH && nvim .";
      };
    };
  };

}

