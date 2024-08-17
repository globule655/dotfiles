# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, modulesPath, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./config/configuration.nix
    ];

  k3s-server-service.enable = true;
  services.k3s.tokenFile = "/var/lib/rancher/k3s/server/token";

  networking.hostName = "kube-01"; # Define your hostname.

}

