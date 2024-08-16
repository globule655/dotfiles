# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, modulesPath, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
      ./hardware-configuration.nix
      ../modules/services/k3s-server.nix
      ./disko.nix
    ];

  k3s-server-service.enable = true;
  services.k3s.tokenFile = /var/lib/rancher/k3s/server/token;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;
  networking.firewall.enable = false;

  # Fixes for longhorn
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
  virtualisation.docker.logDriver = "json-file";

  networking.hostName = "kube-01"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #
  # # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  #
  # # Configure keymap in X11
  # services.xserver = {
  #   layout = "fr";
  #   xkbVariant = "";
  # };

  security.polkit.enable = true;

  #----=[ Fonts ]=----#
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [ 
      ubuntu_font_family
      liberation_ttf
    ];

    fontconfig = {
      defaultFonts = {
        serif = [  "Liberation Serif" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "Ubuntu Mono" ];
      };
    };
  };

  # Configure console keymap
  console = {
    keyMap = "fr";
  };
  # console.keyMap = "fr";

  # audio
  # sound.enable = true;
  # Enable sound with pipewire.
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.globule = {
    isNormalUser = true;
    description = "globule";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1tN280vt1pWu4ilvbJIXgWIHzbmOciZ44YA7gTzJBeblusDfbTDFdabHc//SRFEwXUnj8cCKQ9mgsdH5maLh2nKd3+OUwQxTr+UJUqwj8HFnrFVMEZU9ey6GLt0PlEt5N/tVz60WYpogoWGtxOescGMAKeFoYIPm+zyGNt9f4mvxzwQJAxzBNO9d2XhNggdDjOmwZ01gDtokfrx4ciDomMgspiscgcAeEYsjqTI3nTaBkgUOsOvrB+rq3TykzN4uPSQHVouZJ0L72l1fundjNhciehaJGiaiuF1gfZnPi3BpoZpe0YqSRVh/lYdlS9mwOcLCM+2isDoYV9/VAkwBPb8ELFoSDrt5q1IBRePsSySBy5XqgVyF2eHv1p8wIIA6KEgIwmQONzbEjKR0Nn8bSN0AzsCPMGsYc3vbSYnt3n9ooMv9vQf9tlqlDbahbW48Z414ck+Cb7380YKJ0iR+pXP0pnlYuNQHg+3hC/L3gzGM4PrTN0oLiROmyqkEE5stxDfeDHA8yt6nq500uuALwlUUAsGZr/oEa2ePIZYvY361VNDvo7iUtqzjkqnJjf9UnUdEipiBDWenDM8P79KnrK9295QO+JgVI9COU/KAo2efNFLQn0ps3jNhIes6H0XmpvSRtQfW4E/AKgY1nOj7XDi71mj6Nt/VKI26VFjDvlw== globule@DESKTOP-GKNKPA5"
  ];

  security.sudo.extraRules= [
  {  users = [ "globule" ];
    commands = [
       { command = "ALL" ;
         options= [ "SETENV" "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
      }
    ];
  }
];

  # home-manager.users.globule = { config, pkgs, ... }:{
  #   imports = [
  #     ./home.nix
  #   ];
  # };

  users.defaultUserShell = pkgs.zsh;

  programs = {
    vim = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow nix-command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    file
    git
    iftop
    iotop
    lvm2
    ncdu
    openssl
    pciutils # lspci
    python3
    tmux
    tree
    unzip
    usbutils # lsusb
    vim
    wget
    which
    xz
    zip
    zsh

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

  ];

  environment.variables.EDITOR = "vim";

  system.stateVersion = "24.05"; # Did you read the comment?

}

