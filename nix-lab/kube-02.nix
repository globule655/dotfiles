# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, modulesPath, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./config/configuration.nix
    ];

  k3s-agent-service.enable = true;
  services.k3s.tokenFile = "/var/lib/rancher/k3s/server/token";
  services.k3s.serverAddr = "https://10.11.1.113:6443";

  networking.hostName = "kube-02"; # Define your hostname.

}


