#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")" || exit 1

export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME/nixpkgs"

ln -sfn "$PWD/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sfn "$PWD/config.nix" "$XDG_CONFIG_HOME/nixpkgs/config.nix"
ln -sfn "$PWD/.bashrc" "$HOME/.bashrc"
ln -sfn "$PWD/fish" "$XDG_CONFIG_HOME/fish"
ln -sfn "$PWD/jj" "$XDG_CONFIG_HOME/jj"
ln -sfn "$PWD/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$PWD/atuin" "$XDG_CONFIG_HOME/atuin"

nix-env -iA nixpkgs.myPackages --priority 10

rm "$HOME/.config/atuin/config.toml" || true

nvim --headless "+Lazy! sync" +qa
nvim --headless "+TSUpdate" +qa
nvim --headless "+MasonUpdate" +qa

source "$HOME"/.bashrc
source "$XDG_CONFIG_HOME/fish/config.fish"
