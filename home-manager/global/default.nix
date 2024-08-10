{ inputs, outputs, lib, config, pkgs, ... }:
{
  # You can import other home-manager modules here
  imports = [
    ./nixpkgs_config.nix
    ./programs.nix
    ./fontconfig.nix
  ];

  nixpkgs_conf.enable = lib.mkDefault true;

  home = {
    username = lib.mkDefault "guillaume";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = lib.mkDefault "24.05";

    enableNixpkgsReleaseCheck = true;
  };

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
