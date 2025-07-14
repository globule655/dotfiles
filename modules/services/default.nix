{inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ./kanata.nix
    # ./strongswan.nix
    ./greetd.nix
    ./k3s-server.nix
    ./k3s-agent.nix
    ./avahi.nix
  ];

  config.kanata-service.enable = lib.mkDefault true;
  config.greetd-service.enable = lib.mkDefault true;
  # config.strongswan-service.enable = lib.mkDefault true;
  config.k3s-server-service.enable = lib.mkDefault false;
  config.k3s-agent-service.enable = lib.mkDefault false;
  config.avahi-service.enable = lib.mkDefault true;

}

