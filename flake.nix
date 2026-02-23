{
  description = "MISA 68000 dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
        maybePkg = name: if lib.hasAttr name pkgs then [ pkgs.${name} ] else [ ];
        maybePath = path: if lib.hasAttrByPath path pkgs then [ lib.getAttrFromPath path pkgs ] else [ ];
        crossBinutils = maybePath [ "pkgsCross" "m68k-elf" "buildPackages" "binutils" ];
        python = pkgs.python3.withPackages (ps: with ps; [ pip virtualenv ]);
      in {
        devShells.default = pkgs.mkShell {
          packages =
            [
              python
              pkgs.git
              pkgs.gnumake
              pkgs.gdb
            ]
            ++ maybePkg "vasm"
            ++ maybePkg "vlink"
            ++ crossBinutils;

          shellHook = ''
            export PIP_DISABLE_PIP_VERSION_CHECK=1
            export PIP_NO_PYTHON_VERSION_WARNING=1
            if [ ! -d .venv ]; then
              ${python.interpreter} -m venv .venv
            fi
            . .venv/bin/activate
            python -m pip -q install --upgrade pip >/dev/null
            if ! python - <<'PY'
import importlib.util, sys
sys.exit(0 if importlib.util.find_spec("machine68k") else 1)
PY
            then
              python -m pip install machine68k
            fi
            echo "machine68k ready (python -m machine68k or import machine68k)"
          '';
        };
      });
}
