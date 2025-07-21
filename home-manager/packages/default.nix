{ config, lib, pkgs, nixpkgs-nditools ? pkgs, ...}: {

  imports = [
    ./common.nix
    ./devops.nix
    ./utils.nix
    ./work.nix
    ./ghostty_wrapper.nix
    (import ./stream.nix { inherit config lib pkgs nixpkgs-nditools; })
  ];

  common-packages.enable = lib.mkDefault true;
  utils-packages.enable = lib.mkDefault true;
  devops-packages.enable = lib.mkDefault true;
  work-packages.enable = lib.mkDefault false;
  stream-packages.enable = lib.mkDefault false;

}
