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
        kns = lib.mkDefault "kubectl config use-context";
        on = lib.mkDefault "~/.dotfiles/custom_scripts/new_note.sh";
      };
    };
    atuin = {
      enable = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
    };
    carapace = {
      enable = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
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
      # themeFile = lib.mkDefault "Default";
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
      settings.user.name = lib.mkDefault "Globule";
      settings.user.email = lib.mkDefault "globule655@gmail.com";
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
          # Catppuccin theme adapted from catppuccin/tmux discussion #317.
          set -g @catppuccin_flavor "macchiato"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_window_status_style "none"
          set -g @catppuccin_pane_status_enabled "off"
          set -g @catppuccin_pane_border_status "off"

          set -g status-left-length 100
          set -g status-left ""
          set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  PREFIX },#{#[bg=#{@thm_bg},fg=#{@thm_green}]  NORMAL }}"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_maroon}]  #{pane_current_command} "
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

          set -g status-right-length 100
          set -g status-right ""
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_green}] #H "
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_mauve}] #S "
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

          set -wg automatic-rename on
          set -g automatic-rename-format "Window"
          set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
          set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
          set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
          set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
          set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
          set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"
          set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
          set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"
        '';
        }
      ];
    extraConfig = lib.mkDefault ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g status-position bottom
      set -g status-style "bg=#{@thm_bg}"
      set -g status-justify "absolute-centre"
      set -g mouse on
      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"

      setw -g pane-border-status off
      setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
      setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
      setw -g pane-border-lines single

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
