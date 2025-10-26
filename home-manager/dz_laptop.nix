{ inputs, outputs, lib, config, pkgs, ... }:
let
  username = "gdebros";
in
{

  imports = [
    ./windowManager
    ./global
    ./packages
  ];

  sway-wm.enable = true;
  hyprland-wm.enable = true;
  work-packages.enable = true;

  home = {
    username = username;
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../hypr-waybar;
      ".config/hypr".source = ../hypr;
      ".config/ghostty".source = ../ghostty;
      ".config/wl-kbptr".source = ../wl-kbptr;
      ".config/mcphub".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/mcphub";
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/nvim";
    };
    sessionVariables = {
      EDITOR = "nvim";
      VAULT_PATH = "$HOME/Documents/git_perso/doc.git/main";
      TSH_LOGIN_SCRIPT = "$HOME/.dotfiles/custom_scripts/tsh_login.sh";
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
      initContent = ''
        if command -v tmux &>/dev/null; then
          if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
            tmux attach -t default || tmux new -s default
          fi
        fi
          '';
      shellAliases = {
        ov = "cd $VAULT_PATH && nvim .";
        tsh_login = "/home/${username}/.dotfiles/custom_scripts/tsh_login.sh";
        ssh_config = "/home/${username}/.dotfiles/custom_scripts/tsh_hosts.sh";
        asr = "atuin script run";
      };
    };
  };

}

