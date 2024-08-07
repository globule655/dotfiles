{ inputs, outputs, lib, config, pkgs, ... }:
{

  imports = [
    ./global
    ./windowManager
    ./packages
  ];

  nixpkgs.enable = false;
  sway-wm.enable = true;
  hyprland-wm.enable = true;

  home = {
    username = "globule";
    homeDirectory = "/home/globule";
    stateVersion = "24.05";
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../waybar;
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font"
        ];
      sansSerif = [
        "JetBrainsMono Nerd Font"
        ];
      serif = [
        "JetBrainsMono Nerd Font"
        ];
    };
  };

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      completionInit = ''
        autoload -Uz compinit && compinit
      '';
      initExtra = ''
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' completer _extensions _complete _approximate
      '';
      shellAliases = {
        cat = "bat";
        ls = "eza";
      };
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };
      shellIntegration.enableZshIntegration = true;
      theme = "Default";
      extraConfig = ''
        background_opacity 0.8
        '';
    };
    rofi = {
      enable = true;
      font = "JetBrainsMono Nerd Font";
      theme = "solarized_alternate";
    };
    git = {
      enable = true;
      userName = "Globule";
      userEmail = "globule655@gmail.com";
    };
    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      historyLimit = 100000;
      keyMode = "vi";
      clock24 = true;
      plugins = with pkgs; [
        tmuxPlugins.yank
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.sensible
        tmuxPlugins.catppuccin
      ];
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g mouse on
      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"

      # Allow resize with vim nav keys
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
      bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

      unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode when dragging with mouse

      #catppuccin config
      set -g @catppuccin_window_left_separator "█"
      set -g @catppuccin_window_right_separator "█ "
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_middle_separator "  █"

      set -g @catppuccin_window_default_fill "number"

      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#{pane_current_path}"

      set -g @catppuccin_status_modules_right "application session date_time"
      set -g @catppuccin_status_left_separator  ""
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_right_separator_inverse "yes"
      set -g @catppuccin_status_fill "all"
      set -g @catppuccin_status_connect_separator "yes"
    '';
    };
  };

}

