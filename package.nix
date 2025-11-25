{ pkgs, autoPatchelfHook }:
let
  buildInputs = with pkgs; (with xorg;[
    alsa-lib
    atk
    cairo
    cups
    dbus
    expat
    gdk-pixbuf
    glib
    glibc
    gtk3
    libdrm
    libX11
    libxcb
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXScrnSaver
    libXtst
    mesa
    nss
    nspr
    libgbm
    pango
  ]);
in
pkgs.stdenv.mkDerivation  {
  name = "fightcade";
  src = ./.;  
  buildInputs = buildInputs;
  dontStrip = true;

  nativeBuildInputs = [ 
    autoPatchelfHook
  ];
    buildPhase = ''
      mkdir -p $out/bin
      cp -ra *.sh $out/bin
      cp -ra *.desktop $out/bin
      cp -ra emulator/ $out/bin
      cp -ra fc2-electron/ $out/bin
      cp -ra ROMs/ $out/bin
      cp -ra fcade-upd $out/bin
  '';

  installPhase = ''
  '';

  LD_LIBRARY_PATH = "${pkgs.lib.strings.makeLibraryPath buildInputs}";

}

