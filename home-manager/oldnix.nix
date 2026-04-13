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
  stream-packages.enable = false;

  home = {
    username = username;
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../hypr-waybar;
      ".config/hypr/hypridle.conf".source = ../hypr/hypridle.conf;
      ".config/hypr/hyprlock.conf".source = ../hypr/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ../hypr/hyprpaper.conf;
      ".config/hypr/autostart-local.conf" = {
        force = true;
        text = ''
          exec-once = steam -silent
        '';
      };
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

    activation.cloneWikiRepo = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      WIKI_DIR="$HOME/Documents/git_perso/doc"
      if [ ! -d "$WIKI_DIR" ]; then
        if [ -S "''${SSH_AUTH_SOCK:-}" ]; then
          mkdir -p "$HOME/Documents/git_perso"
          ${pkgs.jujutsu}/bin/jj git clone --colocate git@gitlab.com:globule655/doc.git "$WIKI_DIR" \
            && echo "Wiki repo cloned to $WIKI_DIR" \
            || echo "WARNING: Failed to clone wiki repo — run manually: jj git clone --colocate git@gitlab.com:globule655/doc.git $WIKI_DIR"
        else
          echo "INFO: No SSH agent available, skipping wiki clone. Run manually: jj git clone --colocate git@gitlab.com:globule655/doc.git $WIKI_DIR"
        fi
      fi
    '';
  };

  wayland.windowManager.hyprland.extraConfig = ''
    source = /home/${username}/.dotfiles/hypr/hyprland.conf
    source = /home/${username}/.config/hypr/autostart-local.conf
  '';

  programs = {
    git = {
      settings.user.name = "globule";
      settings.user.email = "globule655@gmail.com";
    };
    zsh = {
      shellAliases = {
        ov = "cd $VAULT_PATH && nvim .";
        asr = "atuin script run";
        jjf = "jj git fetch";
        jjp = "jj git push";
        jjr = "jj rebase -d";
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
      '';
    };
  };

}
