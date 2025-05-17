{ config, lib, pkgs, nixpkgs-nditools, ... }: {

  options = {
    stream-packages = {
      enable = lib.mkEnableOption "install streaming PC packages";
    };
    config.stream-packages.enable = lib.mkDefault true;
  };

  config = lib.mkIf config.stream-packages.enable {
    home.packages = with pkgs; [
    nixpkgs-nditools.ndi-6
    nixpkgs-nditools.davinci-resolve
    (nixpkgs-nditools.wrapOBS {
      plugins = with nixpkgs-nditools.obs-studio-plugins; [
        distroav
        obs-teleport
      ];
    })
    ];
  };

}
