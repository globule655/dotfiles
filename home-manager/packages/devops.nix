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
    dotenvx
    jujutsu
    kubectl
    k9s
    kubernetes-helm
    lima
    terraform
    rustup
    ];
  };

}

