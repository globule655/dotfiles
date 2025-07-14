{ config, lib, pkgs, ... }: {

  options = {
    stream-packages = {
      enable = lib.mkEnableOption "install streaming PC packages";
    };
    config.stream-packages.enable = lib.mkDefault true;
  };

  config = lib.mkIf config.stream-packages.enable {
    home.packages = with pkgs; [
      ndi-6
      davinci-resolve
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          distroav
          obs-teleport
        ];
      })
    ];
  };

}
