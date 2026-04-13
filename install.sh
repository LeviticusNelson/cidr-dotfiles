#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")" || exit 1

export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME/home-manager"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/fish" "$XDG_CONFIG_HOME/fish"
ln -sf "$PWD/home.nix" "$XDG_CONFIG_HOME/home-manager/home.nix"

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install || true

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" 2>/dev/null || true

home-manager switch
