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
        systemd.variables = ["--all"];
        settings = {
          decoration = {
            shadow_offset = "0 5";
            "col.shadow" = "rgba(00000099)";
          };

          "$mod" = "SUPER";

          bindm = [
            # mouse movements
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod ALT, mouse:272, resizewindow"
          ];
        };
      };
    };
  };

}

