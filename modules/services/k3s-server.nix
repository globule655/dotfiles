{inputs, outputs, lib, config, pkgs, ... }: {


  options = {
    k3s-server-service = {
      enable = lib.mkEnableOption "Enable k3s-server service";
    };
  };

  config = lib.mkIf config.k3s-server-service.enable {
    services.k3s = {
      enable = lib.mkDefault true;
      role = lib.mkDefault "server";
      token = lib.mkDefault "<randomized common secret>";
      clusterInit = lib.mkDefault true;
      extraFlags = lib.mkDefault [
        "--disable traefik"
        "--disable servicelb"
        ];
    };
  };
}
