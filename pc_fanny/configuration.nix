# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disko.nix
      # <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "fannixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  programs.openvpn3.enable = true;
  programs.steam.enable = true;
  virtualisation.docker.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "fanny";
    xkb.layout = "fr,fr";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Enables usb disks automount
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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

#  programs.sway.enable = true;
  security.polkit.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt
    ];
  };

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # audio
  # sound.enable = true;
  # Enable sound with pipewire.
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
#  services.pipewire = {
#    enable = false;
#    alsa.enable = true;
#    alsa.support32Bit = true;
#    pulse.enable = true;
#    # If you want to use JACK applications, uncomment this
#    #jack.enable = true;
#
#    # use the example session manager (no others are packaged yet so this is enabled by default,
#    # no need to redefine it in your config for now)
#    #media-session.enable = true;
#  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fanny = {
    isNormalUser = true;
    description = "fanny";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    hashedPassword = "$6$jp.msLbMOZsIcqG8$IOoAMV3QWj6.ZJ4PmvusObUHjelAS3IURZMJhp4//XhoTmF6fWSAzkcRnfjqjR1gujBp.WgL4Qn1viOyUDOnW.";
  };

  security.sudo.extraRules= [
  {  users = [ "fanny" ];
    commands = [
       { command = "ALL" ;
         options= [ "SETENV" "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
      }
    ];
  }
];

  # home-manager.users.fanny = { config, pkgs, ... }:{
  #   imports = [
  #     ./home.nix
  #   ];
  # };

  users.defaultUserShell = pkgs.zsh;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  programs = {
    firefox = {
      enable = true;
    };
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
    nerd-fonts.jetbrains-mono
    curl
    file
    git
    iftop
    iotop
    ncdu
    openssl
    pavucontrol
    pciutils # lspci
    python3
    sway
    xdg-desktop-portal-hyprland
    tmux
    tree
    unzip
    usbutils # lsusb
    vim
    wget
    which
    wl-clipboard
    xz
    zip
    zsh
    gnomeExtensions.appindicator
    adwaita-icon-theme

    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

  ];

  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
