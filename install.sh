#!/bin/bash
export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME/nixpkgs"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME/nixpkgs/config.nix"
ln -sf "$PWD/fish" "$XDG_CONFIG_HOME/fish"

nix-env -iA nixpkgs.myPackages

sudo usermod --shell "$(which fish)" "$USER" || true
