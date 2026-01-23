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
    ${pkgs.tuigreet}/bin/tuigreet \
    --time \
    --asterisks \
    --user-menu \
    --cmd start-hyprland
    '';
      };
    };

    environment.etc."greetd/environments".text = ''
      sway
      hyprland
      '';
  };
}
