{ config, lib, pkgs, inputs, ... }: {

  options = {
    common-packages = {
      enable = lib.mkEnableOption "install common packages";
    };
    config.common-packages.enable = lib.mkDefault true;
  };

  config = lib.mkIf config.common-packages.enable {
    home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    bottles
    cmake
    discord
    dnsutils
    dotool
    easyeffects
    edk2
    ethtool
    ffmpeg-full
    fontconfig
    freerdp
    gcc
    gnumake
    google-chrome
    grim
    htop
    hyprlauncher
    hyprpaper
    iptables
    jq
    kdePackages.okular
    librewolf
    ncdu
    nil
    nodejs_22
    onlyoffice-desktopeditors
    p7zip
    qemu
    ripgrep
    rustup
    slurp
    starship
    swappy
    swaynotificationcenter
    tmux
    tree-sitter
    vlc
    waybar
    wdisplays
    wf-recorder
    wlr-randr
    wlrctl
    xdg-desktop-portal-hyprland
    inputs.mcp-hub.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
  };

}
