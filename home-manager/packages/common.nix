{ config, lib, pkgs, ... }: {

  options = {
    common-packages = {
      enable = lib.mkEnableOption "install common packages";
    };
    config.common-packages.enable = lib.mkDefault true;
  };

  config = lib.mkIf config.common-packages.enable {
    home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    cmake
    dnsutils
    ethtool
    ffmpeg-full
    fontconfig
    gcc
    gnumake
    google-chrome
    grim
    htop
    jq
    ncdu
    neovim
    nil
    nodejs_22
    obsidian
    parsec-bin
    p7zip
    ripgrep
    rofi
    rustup
    slurp
    starship
    swappy
    swaynotificationcenter
    tmux
    vlc
    waybar
    ];
  };

}
