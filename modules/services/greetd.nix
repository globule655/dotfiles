{
  inputs, outputs, pkgs, lib, config,
    ...
}: {

  options = {
    greetd-service = {
      enable = lib.mkEnableOption "Enable greetd service";
    };
  };


  config = lib.mkIf config.greetd-service.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session.command = ''
    ${pkgs.greetd.tuigreet}/bin/tuigreet \
    --time \
    --asterisks \
    --user-menu \
    --cmd sway
    '';
      };
    };

    environment.etc."greetd/environments".text = ''
      sway
      hyprland
      '';
  };
}
