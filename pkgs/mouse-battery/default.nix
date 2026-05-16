{ lib, python3Packages }:

python3Packages.buildPythonApplication {
  pname = "mouse-battery";
  version = "0.1.0";

  src = ./.;

  format = "other";

  propagatedBuildInputs = with python3Packages; [
    hid
  ];

  installPhase = ''
    install -Dm755 mouse-battery.py $out/bin/mouse-battery
  '';

  meta = {
    description = "Waybar battery monitor for supported wireless mice";
    license = lib.licenses.mit;
    maintainers = [];
    platforms = lib.platforms.linux;
    mainProgram = "mouse-battery";
  };
}
