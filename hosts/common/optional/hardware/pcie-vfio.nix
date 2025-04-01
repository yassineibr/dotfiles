{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  environment.systemPackages = with pkgs; [ looking-glass-client ];
  systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0660 yassine qemu-libvirtd -" ];

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      # "vfio_virqfd"

      "kvmfr"

      # "nvidia"
      # "nvidia_modeset"
      # "nvidia_uvm"
      # "nvidia_drm"
    ];

    kernelParams =
      let
        gpuIDs = [
          "8086:1901"
          "10de:1aec"
          "10de:1aed"
          "10de:2191" # Graphics
          "10de:1aeb" # Graphics
        ];
      in
      [
        # enable IOMMU
        # "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
        "intel_iommu=on"
        # "amd_iommu=on"
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
      ];
  };
}
