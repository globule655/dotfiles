{ lib, python3Packages }:

python3Packages.buildPythonApplication {
  pname = "op1w-battery";
  version = "0.1.0";

  src = ./.;

  format = "other";

  propagatedBuildInputs = with python3Packages; [
    hid
  ];

  installPhase = ''
    install -Dm755 op1w-battery.py $out/bin/op1w-battery
  '';

  meta = {
    description = "System tray battery monitor for Endgame Gear OP1w 4k wireless mouse";
    license = lib.licenses.mit;
    maintainers = [];
    platforms = lib.platforms.linux;
    mainProgram = "op1w-battery";
  };
}
