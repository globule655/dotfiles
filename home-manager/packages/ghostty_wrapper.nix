{ config, pkgs, inputs ? {}, ... }:

let
  # Utiliser directement pkgs.nixgl si disponible, sinon essayer de l'obtenir depuis inputs
  nixglPackage = if pkgs ? nixgl then pkgs.nixgl else
                 if inputs ? nixgl then inputs.nixgl.packages.${pkgs.system} else
                 throw "nixgl package not found. Please make sure it's available in pkgs or inputs.";
                 
  ghosttyWrapper = pkgs.writeShellScriptBin "ghostty" ''
    # Détecter si nous sommes sur NixOS ou non
    if [ -f /etc/os-release ] && grep -q "ID=nixos" /etc/os-release; then
      # Sur NixOS, exécuter ghostty directement
      exec ${pkgs.ghostty}/bin/ghostty "$@"
    else
      # Sur d'autres systèmes (comme Fedora), utiliser nixGL
      exec ${nixglPackage.nixGLIntel}/bin/nixGLIntel ${pkgs.ghostty}/bin/ghostty "$@"
    fi
  '';
in {
  home.packages = [
    ghosttyWrapper
  ];
}

