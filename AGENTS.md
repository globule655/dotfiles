# AGENTS.md

## Purpose
This repository is a Nix flake-based dotfiles and machine-configuration setup.
Use this guide when making automated edits so changes stay safe, consistent, and reviewable.

## Repository Shape
- Primary language: Nix (`*.nix`).
- Secondary languages: shell scripts (`*.sh`, `zsh`) and Lua under `nvim/`.
- Flake entry point: `flake.nix`.
- Host configs include:
  - `home-laptop/configuration.nix`
  - `nixospc/configuration.nix`
  - `oldnix/configuration.nix`
  - `pc_fanny/configuration.nix`
  - `nix-lab/kube-01.nix` through `nix-lab/kube-04.nix`
- Home Manager profiles are in `home-manager/`.
- Reusable service modules are in `modules/services/`.

## Source of Truth
- `flake.nix` outputs are authoritative for:
  - `nixosConfigurations`
  - `homeConfigurations`
  - `devShells`
  - exported modules and overlays
- Prefer flake-native commands over legacy channel-based workflows.

## Setup and Environment Commands
- Enter dev shell:
  - `nix develop`
- Legacy shell (if needed):
  - `nix-shell`
- Inspect available outputs:
  - `nix flake show`

## Build Commands (Primary)
- Build one NixOS host (no switch/apply):
  - `nix build .#nixosConfigurations.nixps13.config.system.build.toplevel`
  - `nix build .#nixosConfigurations.nixospc.config.system.build.toplevel`
  - `nix build .#nixosConfigurations.oldnix.config.system.build.toplevel`
  - `nix build .#nixosConfigurations.fannixos.config.system.build.toplevel`
  - `nix build .#nixosConfigurations.kube-01.config.system.build.toplevel`
  - `nix build .#nixosConfigurations.kube-02.config.system.build.toplevel`
  - `nix build .#nixosConfigurations.kube-03.config.system.build.toplevel`
  - `nix build .#nixosConfigurations.kube-04.config.system.build.toplevel`
- Build one Home Manager profile:
  - `nix build .#homeConfigurations.dz_laptop.activationPackage`
  - `nix build .#homeConfigurations.wsl.activationPackage`
- Build package outputs (if/when defined):
  - `nix build .#<package-name>`

## Lint, Format, and Static Checks
This repo does not currently define a centralized lint/format target in flake outputs.
Use these practical checks unless a subdirectory explicitly defines stricter tooling.

- Flake-level checks:
  - `nix flake check`
- Parse/eval-check affected Nix configs by building their outputs.
- Shell syntax checks:
  - `bash -n custom_scripts/tsh_login.sh`
  - `sh -n custom_scripts/tsh_hosts.sh`
  - `zsh -n custom_scripts/new_note.sh`
- Optional shell lint if available:
  - `shellcheck custom_scripts/*.sh`

## Test Commands
No conventional unit/integration suite was discovered (no pytest/jest/go/cargo test harness in root).
For this repository, treat targeted Nix builds as the practical test strategy.

- Full practical validation:
  - Build each affected host/profile output.
- Single-test equivalent (important for focused changes):
  - Build only one impacted target, for example:
    - `nix build .#nixosConfigurations.nixospc.config.system.build.toplevel`
    - `nix build .#homeConfigurations.dz_laptop.activationPackage`
- Fast option sanity probe example:
  - `nix eval .#nixosConfigurations.nixospc.config.services.avahi.enable`

## Apply or Deploy Commands (Mutating)
Run these only when explicitly requested by the user.

- Apply Home Manager profile:
  - `home-manager switch --flake .#dz_laptop`
  - `home-manager switch --flake .#wsl`
- Apply NixOS host:
  - `sudo nixos-rebuild switch --flake .#nixospc`
  - `sudo nixos-rebuild switch --flake .#nixps13`
  - `sudo nixos-rebuild switch --flake .#oldnix`
  - `sudo nixos-rebuild switch --flake .#fannixos`

## Code Style Guidelines (Nix)
- Indentation: 2 spaces, never tabs.
- Keep module argument headers explicit, usually:
  - `{ inputs, outputs, lib, config, pkgs, ... }:`
- End attribute assignments with semicolons.
- Keep `imports = [ ... ];` with one path per line.
- Preserve existing style/comments unless the edited block requires change.
- Prefer `lib.mkDefault` for defaults in reusable modules.
- Gate optional config with `lib.mkIf config.<feature>.enable`.
- Define feature toggles with `lib.mkEnableOption`.
- Keep module structure in this order:
  1) arguments/header
  2) `options`
  3) `config`
- Do not add large commented blocks unless needed for migration context.
- Keep host-specific values in host files, reusable logic in modules.

## Imports and Dependency Conventions
- Keep imports relative and explicit.
- Avoid implicit cross-file assumptions.
- In aggregators (for example `modules/services/default.nix`), wire both:
  - module path in `imports`
  - corresponding default enable/disable toggle
- Avoid circular import patterns.

## Types and Option Definitions
- For booleans, use `lib.mkEnableOption`.
- For non-boolean options, declare explicit option types when introducing new options.
- Prefer explicit defaults with `lib.mkDefault` when overrides are expected.

## Naming Conventions
- Files/modules: kebab-case, matching existing names.
- Service toggle keys follow `<name>-service.enable` in `modules/services/`.
- Keep host names aligned with flake output keys (`nixospc`, `nixps13`, etc).
- Avoid renaming established option keys without explicit migration handling.

## Error Handling and Safety
- Never commit secrets, credentials, tokens, or private keys.
- Treat placeholder secrets (for example `<randomized common secret>`) as unresolved.
- For shell scripts:
  - quote variable expansions
  - check command failures
  - return non-zero on errors
  - print actionable error messages
- For mutating commands (`switch`, rebuild), require explicit user intent.

## Shell Script Conventions
- Use shebang intentionally: `#!/usr/bin/env bash` or `#!/bin/sh` as appropriate.
- Keep scripts idempotent where practical.
- Prefer explicit variables and paths over hidden assumptions.
- If adding a new script with required args, include basic usage guidance.

## Agent Change-Scope Rules
- Make minimal, targeted edits.
- Do not reformat unrelated files.
- Do not update `flake.lock` unless dependency updates are requested.
- Preserve unrelated user changes in a dirty tree.
- If adding modules/config files, wire imports in the correct entry point.

## Validation Checklist Before Finishing
For Nix changes:
1. Build at least one affected output.
2. If multiple hosts/profiles are touched, build each touched output.
3. Report exactly what was built and the result.

For shell changes:
1. Run syntax checks on each modified script.
2. Run `shellcheck` when available.
3. Report warnings that were not fixed.

## Commit Message Guidance
- Keep messages short and intent-first.
- Recommended patterns:
  - `nix: add <feature> module and defaults`
  - `home-manager: update <profile> configuration`
  - `scripts: harden <script> error handling`

## Cursor and Copilot Rules Audit
Checked locations:
- `.cursor/rules/`
- `.cursorrules`
- `.github/copilot-instructions.md`

Result at time of writing:
- No Cursor rules or Copilot instruction files were found in this repository.

## Maintenance Notes
- If lint/test tooling is added, update this document with exact commands.
- If Cursor/Copilot rules are added, mirror key constraints in this file.
