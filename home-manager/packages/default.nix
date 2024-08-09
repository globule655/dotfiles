{ config, lib, pkgs, ...}: {

  imports = [
    ./common.nix
    ./devops.nix
    ./utils.nix
    ./work.nix
  ];

  common-packages.enable = lib.mkDefault true;
  utils-packages.enable = lib.mkDefault true;
  devops-packages.enable = lib.mkDefault true;
  work-packages.enable = lib.mkDefault false;

}
