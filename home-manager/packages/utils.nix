{ config, lib, pkgs, ... }: {

  options = {
    utils-packages = {
      enable = lib.mkEnableOption "install utils packages";
    };
    config.utils-packages.enable = lib.mkDefault true;
  };

  config = lib.mkIf config.utils-packages.enable {
    home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    atuin
    bat
    eza
    fzf
    lazygit
    yazi
    zoxide
    ];
  };

}
