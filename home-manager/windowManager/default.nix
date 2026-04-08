{inputs, outputs, lib, config, pkgs, ... }: {

  options = {
    sway-wm = {
      enable = lib.mkEnableOption "Enable sway windowManager";
    };
    hyprland-wm = {
      enable = lib.mkEnableOption "Enable hyprland windowManager";
      nixgl = lib.mkEnableOption "Use nixGL for hyprland (required on non-NixOS systems)";
    };
  };

  config = lib.mkMerge [
    {
      wayland.windowManager = {
        sway = {
          enable = config.sway-wm.enable;
        };
        hyprland = {
          enable = config.hyprland-wm.enable;
          # On NixOS, use pkgs.hyprland (NixOS handles GPU drivers natively).
          # On non-NixOS with nixgl = true, set null so we manage the package
          # ourselves via home.packages, and GPU wrapping is handled by
          # start-hyprland's built-in nixGL support (it calls `nixGL` from PATH).
          package = lib.mkIf (!config.hyprland-wm.nixgl) (lib.mkDefault pkgs.hyprland);
        };
      };
    }

    (lib.mkIf config.hyprland-wm.nixgl {
      wayland.windowManager.hyprland.package = null;

      # Install hyprland directly. start-hyprland (the .desktop Exec entry)
      # detects it is a Nix build on non-NixOS and automatically prepends the
      # `nixGL` binary from PATH before launching Hyprland.
      #
      # start-hyprland looks for a binary named exactly "nixGL" via execvp.
      # We provide it as a thin wrapper around nixGLIntel.
      home.packages =
        let
          nixGLIntel = inputs.nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixGLIntel;
          nixGL = pkgs.writeShellScriptBin "nixGL" ''
            exec ${nixGLIntel}/bin/nixGLIntel "$@"
          '';
        in [ pkgs.hyprland nixGL ];
    })
  ];

}
