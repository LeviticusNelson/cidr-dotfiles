#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")" || exit 1

export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME/nixpkgs"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME/nixpkgs/config.nix"
ln -sf "$PWD/.bashrc" "$HOME/.bashrc"

nix-env -iA nixpkgs.myPackages --priority 10

rm -rf "$XDG_CONFIG_HOME/fish"

ln -sf "$PWD/fish" "$XDG_CONFIG_HOME/fish"

source "$HOME"/.bashrc
