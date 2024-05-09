{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  dbus,
  pkg-config,
}:
stdenv.mkDerivation rec {
  pname = "iio-hyprland";
  version = "unstable-2023-09-27";

  src = fetchFromGitHub {
    owner = "JeanSchoeller";
    repo = "iio-hyprland";
    rev = "f31ee4109379ad7c3a82b1a0aef982769e482faf";
    hash = "sha256-P+m2OIVS8QSQmeVYVIgt2A6Q/I3zZX3bK9UNLyQtNOg=";
  };

  nativeBuildInputs = [
    pkg-config
    dbus
    meson
    ninja
  ];

  meta = with lib; {
    description = "Listen iio-sensor-proxy and auto change Hyprland output orientation";
    homepage = "https://github.com/JeanSchoeller/iio-hyprland";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "iio-hyprland";
    platforms = platforms.all;
  };
}
