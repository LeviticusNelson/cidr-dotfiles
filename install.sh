#!/usr/bin/env bash
set -euo pipefail

if ! command -v nix >/dev/null 2>&1; then
  printf 'Error: nix is not installed.\n' >&2
  printf 'Install nix first: https://nixos.org/download\n' >&2
  exit 1
fi

if ! command -v nix-shell >/dev/null 2>&1; then
  printf 'Error: nix-shell is not available in PATH.\n' >&2
  printf 'Install nix with nixpkgs support or enable nix-shell command.\n' >&2
  exit 1
fi

mkdir -p "$HOME/.config"

printf 'Bootstrapping with packages from shell.nix...\n'
nix-shell "$SHELL_NIX" --run "nvim --headless '+Lazy! sync' +qa || true"

printf 'Running Neovim health check in shell.nix environment...\n'
nix-shell "$SHELL_NIX" --run "nvim --headless '+checkhealth' +qa || true"

printf 'Done.\n'
