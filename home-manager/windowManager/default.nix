{inputs, outputs, lib, config, pkgs, ... }: {

  options = {
    sway-wm = {
      enable = lib.mkEnableOption "Enable sway windowManager";
    };
    hyprland-wm = {
      enable = lib.mkEnableOption "Enable hyprland windowManager";
    };
  };

  config = {
    wayland.windowManager = {
      sway = {
        enable = config.sway-wm.enable;
      };
      hyprland = {
        enable = config.hyprland-wm.enable;
      };
    };
  };

}

