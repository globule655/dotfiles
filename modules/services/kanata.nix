{inputs, outputs, lib, config, pkgs, ... }: {

  options = {
    kanata-service = {
      enable = lib.mkEnableOption "Enable kanata service";
    };
  };

  config = lib.mkIf config.kanata-service.enable {
    services.kanata = { 
      enable = true;
      keyboards = { 
        laptop = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          extraDefCfg = ''
            process-unmapped-keys yes
          '';
          config = ''
            (defsrc
              caps a   s   d   f   j   k   l   ;
            )
            (defvar
              ;; Note: consider using different time values for your different fingers.
              ;; For example, your pinkies might be slower to release keys and index
              ;; fingers faster.
              tap-time 200
              hold-time 150
            )
            (defalias
              a (tap-hold $tap-time $hold-time a lmet)
              s (tap-hold $tap-time $hold-time s lalt)
              d (tap-hold $tap-time $hold-time d lctl)
              f (tap-hold $tap-time $hold-time f lsft)
              j (tap-hold $tap-time $hold-time j rsft)
              k (tap-hold $tap-time $hold-time k rctl)
              l (tap-hold $tap-time $hold-time l ralt)
              ; (tap-hold $tap-time $hold-time ; rmet)
            )
            (deflayer base
              esc @a  @s  @d  @f  @j  @k  @l  @;
            )
          '';
        };
      }; 
    };
  };
}
