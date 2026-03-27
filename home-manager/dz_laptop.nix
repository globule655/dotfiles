{ inputs, outputs, lib, config, pkgs, ... }:
let
  username = "gdebros";
in
{

  imports = [
    ./windowManager
    ./global
    ./packages
  ];

  sway-wm.enable = true;
  hyprland-wm.enable = true;
  hyprland-wm.nixgl = true;
  work-packages.enable = true;

  home = {
    username = username;
    file = {
      ".config/starship.toml".source = ../starship/starship.toml;
      ".config/sway".source = ../sway;
      ".config/waybar".source = ../hypr-waybar;
      ".config/hypr".source = ../hypr;
      ".config/ghostty".source = ../ghostty;
      ".config/wl-kbptr".source = ../wl-kbptr;
      ".config/wallpaper/wallpaper.jpg".source = ../wallpaper/Fantasy-MountainLake.jpg;
      ".config/wallpaper/screenlock.jpg".source = ../wallpaper/Fantasy-Autumn.jpg;
      ".config/mcphub".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/mcphub";
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/nvim";
      ".config/opencode".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/.dotfiles/opencode";
    };
    sessionVariables = {
      EDITOR = "nvim";
      VAULT_PATH = "$HOME/Documents/git_perso/doc.git/main";
      TSH_LOGIN_SCRIPT = "$HOME/.dotfiles/custom_scripts/tsh_login.sh";
    };

    activation.installHyprlandSession = lib.hm.dag.entryAfter [ "installPackages" ] ''
      # HM installs the .desktop into the nix profile, not ~/.local/share.
      # We copy (not symlink) it into /usr/share/wayland-sessions/ so GDM can
      # read it — GDM runs as the gdm user who cannot traverse ~/. 
      DESKTOP_SRC="$HOME/.nix-profile/share/wayland-sessions/hyprland.desktop"
      DESKTOP_DST="/usr/share/wayland-sessions/nix-hyprland.desktop"
      # Resolve symlinks to get the /nix/store/... path (world-readable).
      DESKTOP_REAL="$(readlink -f "$DESKTOP_SRC")"
      if [ -f "$DESKTOP_REAL" ]; then
        /usr/bin/sudo rm -f "$DESKTOP_DST"
        /usr/bin/sudo cp "$DESKTOP_REAL" "$DESKTOP_DST" \
          && echo "Hyprland session installed to $DESKTOP_DST" \
          || echo "WARNING: Could not copy to $DESKTOP_DST — run: sudo cp $DESKTOP_REAL $DESKTOP_DST"
      else
        echo "WARNING: $DESKTOP_SRC not found, skipping session symlink"
      fi

      # The running systemd --user instance does not include
      # ~/.nix-profile/share/systemd/user/ in its UnitPath on non-NixOS.
      # Copy the portal unit into ~/.config/systemd/user/ which IS scanned.
      PORTAL_SRC="$(readlink -f "$HOME/.nix-profile/share/systemd/user/xdg-desktop-portal-hyprland.service")"
      PORTAL_DST="$HOME/.config/systemd/user/xdg-desktop-portal-hyprland.service"
      if [ -f "$PORTAL_SRC" ]; then
        mkdir -p "$HOME/.config/systemd/user"
        cp -f "$PORTAL_SRC" "$PORTAL_DST"
        echo "Portal unit installed to $PORTAL_DST"
      fi

      # Reload systemd user daemon so newly installed units are picked up.
      systemctl --user daemon-reload 2>/dev/null || true
    '';
  };

  # https://nixos.wiki/wiki/Home_Manager#Usage_on_non-NixOS_Linux
  targets.genericLinux.enable = true;

  # Configure xdg-desktop-portal to use the hyprland backend for screencast,
  # screenshot, and global shortcuts when running under Hyprland.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.Hyprland.default = [ "hyprland" "gtk" ];
  };

  programs = {
    git = {
      userName = "gdebros";
      userEmail = "guillaume.debros@digeiz.com";
    };
    zsh = {
      shellAliases = {
        ov = "cd $VAULT_PATH && nvim .";
        tsh_login = "/home/${username}/.dotfiles/custom_scripts/tsh_login.sh";
        ssh_config = "/home/${username}/.dotfiles/custom_scripts/tsh_hosts.sh";
        asr = "atuin script run";
        jjf = "jj git fetch";
        jjp = "jj git push";
      };
      initContent = ''
        jjb() {
          if [ $# -eq 0 ]; then
            jj bookmark list
          else
            jj bookmark set "$@"
          fi
        }
        jjd() {
          if [ $# -eq 0 ]; then
            jj describe
          else
            jj describe -m "$@"
          fi
        }
      '';
    };
  };

}

