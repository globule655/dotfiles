{inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ./kanata.nix
    ./strongswan.nix
  ];

  config.kanata-service.enable = lib.mkDefault true;
  config.strongswan-service.enable = lib.mkDefault false;

}

