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
    ddrescue
    diffutils
    eza
    fzf
    lazygit
    meld
    sshs
    termshark # wireshark in a termUI
    tmate
    yazi # Terminal file explorer
    zoxide
    ];
  };

}
