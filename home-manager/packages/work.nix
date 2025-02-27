{ config, lib, pkgs, ... }: {

  options = {
    work-packages = {
      enable = lib.mkEnableOption "install work packages";
    };
    config.work-packages.enable = lib.mkDefault false;
  };

  config = lib.mkIf config.work-packages.enable {
    home.packages = with pkgs; [

      google-cloud-sdk
      minicom
      teleport_16
      wireshark

    ];
  };

}

