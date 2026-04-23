#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")" || exit 1

export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME/nixpkgs"
mkdir -p "$XDG_CONFIG_HOME/jj"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME/nixpkgs/config.nix"
ln -sf "$PWD/.bashrc" "$HOME/.bashrc"
ln -sf "$PWD/fish" "$XDG_CONFIG_HOME/fish"
ln -sf "$PWD/jj" "$XDG_CONFIG_HOME/jj"

nix-env -iA nixpkgs.myPackages --priority 10

nvim --headless "+Lazy! sync" +qa
nvim --headless "+TSUpdateSync" +qa
nvim --headless "+MasonInstallAll" +qa 2>/dev/null || true # ignore if command missing

source "$HOME"/.bashrc
