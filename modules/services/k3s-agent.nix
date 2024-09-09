{inputs, outputs, lib, config, pkgs, ... }: {

  options = {
    k3s-agent-service = {
      enable = lib.mkEnableOption "Enable k3s-agent service";
    };
  };

  config = lib.mkIf config.k3s-agent-service.enable {
    services.k3s = {
      enable = lib.mkDefault true;
      role = lib.mkDefault "agent";
      token = lib.mkDefault "<randomized common secret>";
      serverAddr = lib.mkDefault "https://<ip of first node>:6443";
    };
  };
}
