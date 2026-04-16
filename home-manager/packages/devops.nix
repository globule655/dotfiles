{ config, lib, pkgs, ... }: {

  options = {
    devops-packages = {
      enable = lib.mkEnableOption "install devops packages";
    };
    config.devops-packages.enable = lib.mkDefault true;
  };

  config = lib.mkIf config.devops-packages.enable {
    home.packages = with pkgs; [
    ansible
    direnv
    dotenv-cli
    jjui
    jujutsu
    kubectl
    k9s
    kubernetes-helm
    lima
    opencode
    opencode-desktop
    terraform
    rustup
    ];
  };

}

