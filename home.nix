{ config, pkgs, ... }:

let
  username = "globule";
  homedir = "/home/${username}";
in 
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "${homedir}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    ansible
    atuin
    bat
    cmake
    dnsutils
    ethtool
    eza
    fontconfig
    fzf
    google-chrome
    gcc
    gnumake
    grim
    htop
    lazygit
    jq
    ncdu
    neovim
    nodejs_22
    p7zip
    ripgrep
    rofi
    rustup
    starship
    terraform
    tmux
    waybar
    yazi
    zoxide

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

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
      set -g @catppuccin_status_connect_separator "no"
    '';
    };
  };

  wayland.windowManager.sway = {
    enable = true;
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # ".config/nvim".source = .dotfiles/nvim;
    ".config/starship.toml".source = ./starship/starship.toml;
    # ".config/tmux".source = ./tmux;
    ".config/kanata".source = ./kanata;
    ".config/sway".source = ./sway;
    ".config/waybar".source = ./waybar;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/globule/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    # STARSHIP_CONFIG="~/.config/starship/starship.toml";
    # PATH="$PATH:$HOME/.nix-profile/bin";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

