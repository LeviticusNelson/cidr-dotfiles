#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")" || exit 1

export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$HOME/.local/bin"

ln -sfn "$PWD/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sfn "$PWD/.bashrc" "$HOME/.bashrc"
ln -sfn "$PWD/fish" "$XDG_CONFIG_HOME/fish"
ln -sfn "$PWD/jj" "$XDG_CONFIG_HOME/jj"
ln -sfn "$PWD/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$PWD/atuin" "$XDG_CONFIG_HOME/atuin"

packages=(
  neovim
  fish
  git
  curl
  wget
  unzip
  tar
  gzip
  ripgrep
  fd-find
  fzf
  lazygit
  make
  gcc
  nodejs
  npm
  python3
  python3-pynvim
  xclip
  luarocks
  lua-language-server
  starship
  atuin
  eza
  jujutsu
  hub
  gh
)

if ! command -v go >/dev/null; then
  packages+=(golang gopls golangci-lint delve)
fi

if ! command -v docker >/dev/null; then
  packages+=(docker.io docker-compose)
fi

sudo apt-get update

install=()
for pkg in "${packages[@]}"; do
  if dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q 'install ok installed'; then
    continue
  fi
  if apt-cache show "$pkg" >/dev/null 2>&1; then
    install+=("$pkg")
  fi
done

if [ "${#install[@]}" -gt 0 ]; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "${install[@]}"
fi

if command -v fdfind >/dev/null && ! command -v fd >/dev/null; then
  ln -sfn "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

rm "$HOME/.config/atuin/config.toml" || true

FISH="$(command -v fish)"
CURRENT_USER="$(whoami)"

if ! grep -qxF "$FISH" /etc/shells; then
  echo "$FISH" | sudo tee -a /etc/shells >/dev/null
fi

sudo chsh --shell "$FISH" "$CURRENT_USER"

exit 0
