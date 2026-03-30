{ inputs, outputs, lib, config, pkgs, ... }:
{

  imports = [
    ./global
    ./windowManager
    ./packages
  ];

  nixpkgs_conf.enable = false;
  sway-wm.enable = true;
  hyprland-wm.enable = true;
  work-packages.enable = true;
  stream-packages.enable = false;

  home = {
    username = "globule";
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../hypr-waybar;
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
        asr = "atuin script run";
        jjf = "jj git fetch";
        jjp = "jj git push";
      };
      initContent = ''
        jjb() {
          if [ $# -eq 0 ]; then
            jj bookmark list
          else
            jj bookmark set "$@"
          fi
        }
        jjd() {
          if [ $# -eq 0 ]; then
            jj describe
          else
            jj describe -m "$@"
          fi
        }
        jjr() {
          if [ $# -eq 0 ]; then
            jj rebase -d main
          else
            jj rebase -d "$@"
          fi
        }
      '';
    };
  };

}

