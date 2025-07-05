{ config, lib, pkgs, ... }: {

  options = {
    utils-packages = {
      enable = lib.mkEnableOption "install utils packages";
    };
    config.utils-packages.enable = lib.mkDefault true;
  };

  config = lib.mkIf config.utils-packages.enable {
    home.packages = with pkgs; [
    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    nerd-fonts.jetbrains-mono
    age # encrypt/decrypt files
    atuin
    bat
    bashmount
    bitwarden-cli
    btop
    carapace
    ddrescue
    diffutils
    eza
    fzf
    ghostty
    insync
    lazygit
    meld
    papers
    pwgen
    sshs
    termshark # wireshark in a termUI
    tmate
    usbutils
    udisks
    udiskie
    yazi # Terminal file explorer
    veracrypt
    zoxide
    ];
  };

}
