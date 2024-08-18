{ inputs, outputs, lib, config, pkgs, ... }:
{

  imports = [
    ./global
    ./windowManager
    ./packages
  ];

  nixpkgs_conf.enable = false;
  sway-wm.enable = true;
  hyprland-wm.enable = false;
  work-packages.enable = true;

  home = {
    username = "globule";
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../waybar;
      ".config/hypr".source = ../hypr;
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

}

