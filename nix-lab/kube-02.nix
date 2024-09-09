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
  services.k3s.serverAddr = "https://10.29.100.5:6443";
  # services.k3s.tokenFile = "/var/lib/rancher/k3s/server/token";

  networking = {
    hostName = "kube-02"; # Define your hostname.
    interfaces.eth0.ipv4.addresses = [{
      address = "10.29.100.6";
      prefixLength = 28;
    }];
    defaultGateway = "10.29.100.1";
    nameservers = ["10.29.100.10"];
    vlans = {
      vlan200 = {
        id = 200;
        interface = "eth0";
      };
      vlan500 = {
        id = 500;
        interface = "eth0";
      };
      vlan300 = {
        id = 300;
        interface = "eth0";
      };
    };
  };

}


