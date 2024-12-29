{
  inputs, outputs, pkgs, lib, config,
    ...
}: {

  options = {
    avahi-service = {
      enable = lib.mkEnableOption "Enable avahi service";
    };
  };


  config = lib.mkIf config.avahi-service.enable {
    services.avahi = {
      enable = lib.mkDefault true;
    };

  };
}
