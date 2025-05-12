{ config, lib, pkgs, ... }: {

  options = {
    stream-packages = {
      enable = lib.mkEnableOption "install streaming PC packages";
    };
    config.stream-packages.enable = lib.mkDefault true;
  };

  config = lib.mkIf config.stream-packages.enable {
    home.packages = with pkgs.nditools; [
    ndi-6
    davinci-resolve
    (pkgs.nditools.wrapOBS {
      plugins = with pkgs.nditools.obs-studio-plugins; [
        obs-studio-plugins.distroav
        obs-studio-plugins.obs-teleport
      ];
    })
    ];
  };

}
