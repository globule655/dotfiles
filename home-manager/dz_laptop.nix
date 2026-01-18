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
      ".config/wallpaper/wallpaper.jpg".source = ../wallpaper/Fantasy-MountainLake.jpg;
      ".config/wallpaper/screenlock.jpg".source = ../wallpaper/Fantasy-Autumn.jpg;
      ".config/mcphub".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/mcphub";
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/nvim";
      ".config/opencode".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/opencode";
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
    nyxt = {
      enable = true;
      config = ''
        (in-package #:nyxt-user)
  
        (defvar *my-search-engines*
          (list
           (make-instance 'search-engine
                          :name "Google"
                          :shortcut "goo"
                          #+nyxt-4 :control-url #+nyxt-3 :search-url
                          "https://duckduckgo.com/?q=~a")
           (make-instance 'search-engine
                          :name "MDN"
                          :shortcut "mdn"
                          #+nyxt-4 :control-url #+nyxt-3 :search-url
                          "https://developer.mozilla.org/en-US/search?q=~a")))
        
        (define-configuration browser
          ((restore-session-on-startup-p nil)
           (default-new-buffer-url (quri:uri "https://www.google.fr"))
           (external-editor-program (if (member :flatpak *features*)
                                        "flatpak-spawn --host emacsclient -r"
                                        "emacsclient -r"))
           #+nyxt-4
           (search-engine-suggestions-p nil)
           #+nyxt-4
           (search-engines (append %slot-default% *my-search-engines*))
           ;; Sets the font for the Nyxt UI (not for webpages).
           (theme (make-instance 'theme:theme
                                 :font-family "Iosevka"
                                 :monospace-font-family "Iosevka"))
           ;; Whether code sent to the socket gets executed.  You must understand the
           ;; risks before enabling this: a privileged user with access to your system
           ;; can then take control of the browser and execute arbitrary code under your
           ;; user profile.
           ;;
      '';
    };
  };

}

