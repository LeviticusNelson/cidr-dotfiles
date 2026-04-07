#!/bin/bash
export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME/nixpkgs"

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME/nixpkgs/config.nix"
ln -sf "$PWD/fish" "$XDG_CONFIG_HOME/fish"

nix-env -iA nixpkgs.myPackages

fish_path="$(command -v fish || true)"

if [ -n "$fish_path" ]; then
  if ! grep -qx "$fish_path" /etc/shells 2>/dev/null; then
    if [ -w /etc/shells ]; then
      printf '%s\n' "$fish_path" >>/etc/shells
    else
      printf '%s\n' "$fish_path" | sudo tee -a /etc/shells >/dev/null
    fi
  fi

  if [ "$SHELL" != "$fish_path" ]; then
    chsh -s "$fish_path"
  fi
fi
