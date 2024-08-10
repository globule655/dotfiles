{ inputs, outputs, lib, config, pkgs, ... }: {

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
        cat = lib.mkDefault "bat";
        ls = lib.mkDefault "eza";
        dot = lib.mkDefault "cd ~/.dotfiles; nvim .";
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
      userName = lib.mkDefault "Globule";
      userEmail = lib.mkDefault "globule655@gmail.com";
    };
    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      historyLimit = 100000;
      keyMode = "vi";
      clock24 = true;
      sensibleOnTop = true;
      plugins = with pkgs; [
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
    '';
    };
  };
}

