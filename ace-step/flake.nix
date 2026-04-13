{
  description = "Dev shell for ACE-Step-1.5 (NVIDIA GPU, uv-managed Python deps)";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
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
          UV_PYTHON = "${pkgs.python311}/bin/python3";
          UV_PYTHON_PREFERENCE = "only-system";
          # NixOS: uv cannot hardlink from the immutable /nix/store into .venv
          UV_LINK_MODE = "copy";
          # Workaround for CUBLAS_STATUS_INVALID_VALUE with BF16 on CUDA 12.9+
          CUBLAS_WORKSPACE_CONFIG = ":4096:8";
          # NixOS: Triton hardcodes /sbin/ldconfig (FHS) to locate libcuda.so.
          # This env var bypasses that call entirely.
          TRITON_LIBCUDA_PATH = "/run/opengl-driver/lib";
          # Only system libs and the driver stub; PyTorch pip wheels bundle
          # their own CUDA runtime (cublas, cudnn, etc.) and find them via
          # Python's import mechanism -- do NOT add Nix cudatoolkit/cudnn here
          # or it will shadow the bundled versions and cause version mismatches.
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            "/run/opengl-driver"
            (pkgs.lib.getLib pkgs.ffmpeg)
            pkgs.stdenv.cc.cc.lib
            pkgs.libGL
            pkgs.libsndfile
            pkgs.zlib
          ];
        };

        shellHook = ''
          ace_step_project_dir() {
            if [ -f "$PWD/ACE-Step-1.5/pyproject.toml" ]; then
              printf '%s\n' "$PWD/ACE-Step-1.5"
              return 0
            fi

            if [ -f "$PWD/pyproject.toml" ] && [ -d "$PWD/acestep" ]; then
              printf '%s\n' "$PWD"
              return 0
            fi

            return 1
          }

          ace_step_torchcodec_version() {
            local project_dir
            project_dir="$1"

            "$project_dir/.venv/bin/python" - <<'PY'
import importlib.metadata as metadata

try:
    print(metadata.version("torchcodec"))
except metadata.PackageNotFoundError:
    print("")
PY
          }

          ace_step_fix_torchcodec() {
            local project_dir current_version

            project_dir="$(ace_step_project_dir)" || {
              printf 'ace-step-fix-torchcodec: run from the flake root or ACE-Step-1.5 directory.\n' >&2
              return 1
            }

            if [ ! -x "$project_dir/.venv/bin/python" ]; then
              printf 'ace-step-fix-torchcodec: missing .venv; run ace-step-sync first.\n' >&2
              return 1
            fi

            current_version="$(ace_step_torchcodec_version "$project_dir")"
            case "$current_version" in
              0.10.*)
                return 0
                ;;
            esac

            (
              cd "$project_dir" && \
              uv pip install --python .venv/bin/python --force-reinstall --no-deps "torchcodec==0.10.*" --index-url https://download.pytorch.org/whl/cpu
            )
          }

          ace_step_sync() {
            local project_dir

            project_dir="$(ace_step_project_dir)" || {
              printf 'ace-step-sync: run from the flake root or ACE-Step-1.5 directory.\n' >&2
              return 1
            }

            (
              cd "$project_dir" && \
              uv sync
            ) && ace_step_fix_torchcodec
          }

          ace_step_ui() {
            local project_dir

            project_dir="$(ace_step_project_dir)" || {
              printf 'ace-step-ui: run from the flake root or ACE-Step-1.5 directory.\n' >&2
              return 1
            }

            ace_step_fix_torchcodec || return 1
            (
              cd "$project_dir" && \
              .venv/bin/acestep "$@"
            )
          }

          ace_step_api() {
            local project_dir

            project_dir="$(ace_step_project_dir)" || {
              printf 'ace-step-api: run from the flake root or ACE-Step-1.5 directory.\n' >&2
              return 1
            }

            ace_step_fix_torchcodec || return 1
            (
              cd "$project_dir" && \
              .venv/bin/acestep-api "$@"
            )
          }

          alias ace-step-fix-torchcodec=ace_step_fix_torchcodec
          alias ace-step-sync=ace_step_sync
          alias ace-step-ui=ace_step_ui
          alias ace-step-api=ace_step_api

          echo "ACE-Step dev shell ready."
          echo ""
          if project_dir="$(ace_step_project_dir 2>/dev/null)"; then
            if [ -x "$project_dir/.venv/bin/python" ]; then
              current_version="$(ace_step_torchcodec_version "$project_dir")"
              case "$current_version" in
                0.10.*)
                  ;;
                *)
                  echo "Repairing torchcodec to the PyTorch 2.10-compatible build..."
                  if ace_step_fix_torchcodec; then
                    echo "torchcodec repair complete."
                  else
                    echo "torchcodec repair failed; run: cd $project_dir && ace-step-fix-torchcodec"
                  fi
                  echo ""
                  ;;
              esac
            fi
          fi

          echo "First time setup:  ace-step-sync"
          echo ""
          echo "Launch UI:  ace-step-ui"
          echo "Launch API: ace-step-api"
        '';
      };
    };
}
