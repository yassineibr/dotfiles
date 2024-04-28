{
  description = "DevShell for Python developement";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib-path = with pkgs;
        lib.makeLibraryPath [
          libffi
          openssl
          stdenv.cc.cc
          # If you want to use CUDA, you should uncomment this line.
          # linuxPackages.nvidia_x11
        ];
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (python3.withPackages (p:
            with p; [
              # This list contains tools for Python development.
              # You can also add other tools, like black.
              #
              # Note that even if you add Python packages here like PyTorch or Tensorflow,
              # they will be reinstalled when running `pip -r requirements.txt` because
              # virtualenv is used below in the shellHook.
              ipython
              pip
              setuptools
              virtualenvwrapper
              wheel
            ]))
        ];

        shellHook = ''
          # Allow the use of wheels.
          SOURCE_DATE_EPOCH=$(date +%s)
          # Augment the dynamic linker path
          export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
          # Setup the virtual environment if it doesn't already exist.
          VENV=.venv
          if test ! -d $VENV; then
            virtualenv $VENV
          fi
          source ./$VENV/bin/activate
          export PYTHONPATH=`pwd`/$VENV/${pkgs.python3.sitePackages}/:$PYTHONPATH
        '';
      };
    });
}
