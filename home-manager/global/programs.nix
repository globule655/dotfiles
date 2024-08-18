{ inputs, outputs, lib, config, pkgs, ... }: {

  programs = {
    bash = {
      enable = lib.mkDefault true;
      enableCompletion = lib.mkDefault true;
    };
    zsh = {
      enable = lib.mkDefault true;
      enableCompletion = lib.mkDefault true;
      autosuggestion.enable = lib.mkDefault true;
      syntaxHighlighting.enable = lib.mkDefault true;
      completionInit = lib.mkDefault ''
        autoload -Uz compinit && compinit
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' completer _extensions _complete _approximate
      '';
      shellAliases = {
        cat = lib.mkDefault "bat";
        ls = lib.mkDefault "eza";
        dot = lib.mkDefault "cd ~/.dotfiles; nvim .";
        k = lib.mkDefault "kubectl";
      };
    };
    atuin = {
      enable = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
    };
    starship = {
      enable = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
    };
    zoxide = {
      enable = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      options = lib.mkDefault [
        "--cmd cd"
      ];
    };
    kitty = {
      enable = lib.mkDefault true;
      font = {
        name = lib.mkDefault "JetBrainsMono Nerd Font";
        size = lib.mkDefault 11;
      };
      shellIntegration.enableZshIntegration = lib.mkDefault true;
      theme = lib.mkDefault "Default";
      extraConfig = lib.mkDefault ''
        background_opacity 0.8
        '';
    };
    rofi = {
      enable = lib.mkDefault true;
      font = lib.mkDefault "JetBrainsMono Nerd Font";
      theme = lib.mkDefault "solarized_alternate";
    };
    git = {
      enable = lib.mkDefault true;
      userName = lib.mkDefault "Globule";
      userEmail = lib.mkDefault "globule655@gmail.com";
    };
    direnv = {
      enable = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
    };
    tmux = {
      enable = lib.mkDefault true;
      shell = lib.mkDefault "${pkgs.zsh}/bin/zsh";
      terminal = lib.mkDefault "tmux-256color";
      historyLimit = lib.mkDefault 100000;
      keyMode = lib.mkDefault "vi";
      clock24 = lib.mkDefault true;
      sensibleOnTop = lib.mkDefault true;
      plugins = with pkgs; lib.mkDefault [
        tmuxPlugins.yank
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.sensible
        {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
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
        }
      ];
    extraConfig = lib.mkDefault ''
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
    '';
    };
  };
}

