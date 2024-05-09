{
  stdenv,
  lib,
  kernel,
}:

let
  modPath = "drivers/net/ethernet/atheros/alx";
  modDestDir = "$out/lib/modules/${kernel.modDirVersion}/kernel/${modPath}";
in
stdenv.mkDerivation rec {
  name = "alx-${kernel.version}";

  inherit (kernel) src version;

  postPatch = ''
    cd ${modPath}
  '';

  patches = [ ./linux-6.1.patch ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernel.makeFlags ++ [
    "-C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(PWD)"
    "modules"
  ];

  enableParallelBuilding = true;

  installPhase = ''
    runHook preInstall

    mkdir -p ${modDestDir}
    find . -name '*.ko' -exec cp --parents '{}' ${modDestDir} \;
    find ${modDestDir} -name '*.ko' -exec xz -f '{}' \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "Alx wake-on-lan ethernet drivers";
    inherit (kernel.meta) license platforms;
    broken = kernel.kernelOlder "6.0.3" || kernel.kernelAtLeast "6.3";
  };
}
