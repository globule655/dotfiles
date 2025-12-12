# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disko.nix
      ../modules/services
      # <home-manager/nixos>
    ];

  # greetd-service.enable = true;

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.useOSProber = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      efiSysMountPoint = "/boot";
    };
    timeout = 10;
    grub = {
      # despite what the configuration.nix manpage seems to indicate,
      # as of release 17.09, setting device to "nodev" will still call
      # `grub-install` if efiSupport is true
      # (the devices list is not used by the EFI grub install,
      # but must be set to some value in order to pass an assert in grub.nix)
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      useOSProber = true;
      # set $FS_UUID to the UUID of the EFI partition
      # extraEntries = ''
      #   menuentry "Windows" {
      #     insmod part_gpt
      #     insmod fat
      #     insmod search_fs_uuid
      #     insmod chain
      #     search --fs-uuid --set=root fcca9390-acea-4d5c-9eb1-84a56c84da61
      #     chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      #   }
      # '';
    };
  };

  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixospc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  virtualisation.docker.enable = true;

  services = {
    xserver.enable = true;
    xserver.xkb.layout = "fr,fr";
    displayManager.gdm.enable = true;
    desktopManager = {
      # gnome.enable = true;
      plasma6.enable = true;
    };
  };

#   services.xserver = {
#     monitorSection = ''
# Modeline "2560x1440_360.00"  2349.61  2560 2808 3096 3632  1440 1441 1444 1797  -HSync +Vsync
# Modeline "1920x1080_360.00"  1319.96  1920 2104 2320 2720  1080 1081 1084 1348  -HSync +Vsync
# Modeline "1280x1024_360.00"  831.82  1280 1400 1544 1808  1024 1025 1028 1278  -HSync +Vsync
#     '';
#     deviceSection = ''
# Option "ModeValidation" "AllowNonEdidModes"
#     '';
#     resolutions = [
#       {
#         x = 2560;
#         y = 1440;
#       }
#       {
#         x = 1920;
#         y = 1080;
#       }
#       {
#         x = 1280;
#         y = 1024;
#       }
#     ];
#   };

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

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

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
      ubuntu-classic
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
  services.pulseaudio.enable = false;
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
  users.users.globule = {
    isNormalUser = true;
    description = "globule";
    extraGroups = [ "networkmanager" "wheel" "docker" "ydotool" ];
    hashedPassword = "$6$Oz1YWT6ImCyDEtyE$SCrBzrUx/VlN8maxqezwdNH3HF6ZA4r19WZbpVeZjqaFn8Lnyf1bQx.7igjhPv/HkzW0bnInIWMBN7/B7lgXu1";
  };

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
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  programs = {
    firefox = {
      enable = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode = {
      enable = true;
    };
    ydotool = {
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
    adwaita-icon-theme
    curl
    file
    gamescope
    git
    gnomeExtensions.appindicator
    gnome-tweaks
    iftop
    iotop
    mangohud
    ncdu
    openssl
    pavucontrol
    pciutils # lspci
    protonup-ng
    python3
    sway
    tmux
    tree
    unzip
    usbutils # lsusb
    vim
    wget
    which
    wl-clipboard
    xdg-desktop-portal-hyprland
    xz
    zip
    zsh

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
