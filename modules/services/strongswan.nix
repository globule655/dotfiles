{inputs, outputs, lib, config, pkgs, ... }: {

  options = {
    strongswan-service = {
      enable = lib.mkEnableOption "Enable strongswan service";
    };
  };

  config = lib.mkIf config.strongswan-service.enable {
    services.strongswan = {
      enable = true;
      managePlugins = true;
      enabledPlugins = [
        "acert"
        "aes"
        "aesni"
        "agent"
        "attr"
        "bypass-lan"
        "certexpire"
        "cmac"
        "constraints"
        "counters"
        "curl"
        "curve25519"
        "des"
        "dhcp"
        "dnskey"
        "drbg"
        "duplicheck"
        "eap-aka"
        "eap-dynamic"
        "eap-identity"
        "eap-mschapv2"
        "eap-tls"
        "fips-prf"
        "gcrypt"
        "gmp"
        "hmac"
        "kdf"
        "kernel-libipsec"
        "kernel-netlink"
        "kernel-pfkey"
        "kernel-pfroute"
        "lookip"
        "nonce"
        "openssl"
        "pem"
        "pgp"
        "random"
        "rc2"
        "resolve"
        "revocation"
        "sha2"
        "sha3"
        "socket-default"
        "socket-dynamic"
        "sshkey"
        "stroke"
        "updown"
        "vici"
        "whitelist"
        "x509"
        "xauth-eap"
        "xauth-generic"
        "xauth-pam"
        "xcbc"
      ];
      secrets = [
        "/etc/ipsec.d/secrets"
      ];
      ca = {
        firehack = {
          auto = "add";
          cacert = "/etc/ipsec.d/cacerts/ipsec-CA.crt";
        };
      };
      connections = {
        setup = {
          uniqueids = "yes";
        };
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
          rightca = "\"/CN=ipsec-CA/C=FR/ST=IDF/L=Paris/O=firehack/OU=firehack\"";
          rightsubnet = "10.30.0.0/28,10.29.100.0/28";
          eap_identity = "%identity";
        };
      };
    };
  };

}

