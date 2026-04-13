{
  description = "Dev shell for ACE-Step-1.5 (NVIDIA GPU, uv-managed Python deps)";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.cudaSupport = true;
      };
      cuda = pkgs.cudaPackages;
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "ace-step";

        packages = with pkgs; [
          uv
          git
          python311
          ffmpeg
          libsndfile
          stdenv.cc.cc.lib
          zlib
          libGL
        ];

        env = {
          CUDA_PATH = "${cuda.cudatoolkit}";
          CUDA_HOME = "${cuda.cudatoolkit}";
          UV_PYTHON = "${pkgs.python311}/bin/python3";
          UV_PYTHON_PREFERENCE = "only-system";
          # NixOS: uv cannot hardlink from the immutable /nix/store into .venv
          UV_LINK_MODE = "copy";
          # Workaround for CUBLAS_STATUS_INVALID_VALUE with BF16 on CUDA 12.9+
          CUBLAS_WORKSPACE_CONFIG = ":4096:8";
          # NixOS: Triton hardcodes /sbin/ldconfig (FHS) to locate libcuda.so.
          # This env var bypasses that call entirely.
          TRITON_LIBCUDA_PATH = "/run/opengl-driver/lib";
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            "/run/opengl-driver"
            cuda.cudatoolkit
            cuda.cudnn
            pkgs.stdenv.cc.cc.lib
            pkgs.libGL
            pkgs.libsndfile
            pkgs.zlib
          ];
        };

        shellHook = ''
          echo "ACE-Step dev shell ready."
          echo ""
          echo "First time setup:"
          echo "  1. uv sync"
          echo "  2. uv pip install --python .venv/bin/python nvidia-cublas-cu12==12.9.1.4 --force-reinstall --no-deps"
          echo ""
          echo "Launch UI:  uv run acestep"
          echo "Launch API: uv run acestep-api"
        '';
      };
    };
}
