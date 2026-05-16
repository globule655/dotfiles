{ inputs, outputs, lib, config, pkgs, ... }:

let
  cfg = config.services.mouse-battery;
  pkg = outputs.packages.${pkgs.system}.mouse-battery;
in
{
  options.services.mouse-battery = {
    enable = lib.mkEnableOption "battery monitor for supported wireless mice";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkg ];

    # Allow the active user session to access supported HID devices.
    services.udev.extraRules = ''
      # Endgame Gear wireless dongle / mice
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1970", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1972", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1982", TAG+="uaccess"

      # VAXEE wireless dongles / mice
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="0005", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1001", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1002", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1003", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1004", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1005", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1006", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1007", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1008", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1009", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1010", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1011", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1012", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="1013", TAG+="uaccess"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3057", ATTRS{idProduct}=="2001", TAG+="uaccess"
    '';
  };
}
