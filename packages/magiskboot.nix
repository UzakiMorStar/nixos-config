{ lib, stdenv, fetchurl, unzip, autoPatchelfHook }:

stdenv.mkDerivation {
  pname = "magiskboot";
  version = "30.7";

  src = fetchurl {
    url = "https://github.com/topjohnwu/Magisk/releases/download/v30.7/Magisk-v30.7.apk";
    hash = "sha256-4NMtISNTKGD5cSPZJ7G7hsTgjm/YpIv8a1vuCvrp69U=";
  };

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    unzip -p $src lib/x86_64/libmagiskboot.so > $out/bin/magiskboot
    chmod +x $out/bin/magiskboot
  '';

  meta = with lib; {
    description = "MagiskBoot - Manipulate Android boot images";
    homepage = "https://github.com/topjohnwu/Magisk";
    license = licenses.gpl3Plus;
    platforms = [ "x86_64-linux" ];
    maintainers = [];
  };
}
