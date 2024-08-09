{inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ./kanata.nix
  ];

  config.kanata-service.enable = lib.mkDefault true;

}

