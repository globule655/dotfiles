{ inputs, outputs, lib, config, pkgs, ... }:

let
  cfg = config.services.op1w-battery;
  pkg = outputs.packages.${pkgs.system}.op1w-battery;
in
{
  options.services.op1w-battery = {
    enable = lib.mkEnableOption "Endgame Gear OP1w 4k battery tray monitor";

    user = lib.mkOption {
      type = lib.types.str;
      description = "User under whose session the tray app runs.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkg ];

    # Allow the user to access the HID device without root
    services.udev.extraRules = ''
      # Endgame Gear OP1w 4k - wireless dongle
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1970", TAG+="uaccess"
      # Endgame Gear OP1w 4k - wired / charging
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1972", TAG+="uaccess"
    '';
  };
}
