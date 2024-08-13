{inputs, outputs, lib, config, pkgs, ... }: {

  options = {
    strongswan-service = {
      enable = lib.mkEnableOption "Enable strongswan service";
    };
  };

  config = lib.mkIf config.strongswan-service.enable {
    services.strongswan = {
      enable = true;
      connections = {
        setup = {
          uniqueids = "yes";
        };
        secrets = [
          "/etc/ipsec.secrets"
        ];
        default = {
          fragmentation = "yes";
          keyexchange = "ikev2";
          reauth = "no";
          forceencaps = "yes";
          compress = "no";
          mobike = "no";
          rekey = "yes";
          installpolicy = "yes";
          type = "tunnel";
          dpdaction = "restart";
          dpddelay = "90s";
          dpdtimeout = "540s";
          closeaction = "restart";
          margintime = "10m";
          auto = "add";
        };
        home_remote = {
          also = "default";
          ikelifetime = "8400s";
          lifetime = "3600s";
          leftauth = "eap-tls";
          leftcert = "/etc/ipsec.d/certs/globule.crt";
          right = "78.193.216.210";
          rightid = "82.67.241.60";
          rightauth = "pubkey";
          rightca = "/CN=ipsec-CA/C=FR/ST=IDF/L=Paris/O=firehack/OU=firehack";
          rightsubnet = "10.30.0.0/28,10.29.100.0/28";
          eap_identity = "%identity";
        };
      };
    };
  };

}

