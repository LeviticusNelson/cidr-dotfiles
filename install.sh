#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_SRC="$REPO_DIR/.config/nvim"
NVIM_DEST="$HOME/.config/nvim"
FISH_SRC="$REPO_DIR/.config/fish"
FISH_DEST="$HOME/.config/fish"
SHELL_NIX="$REPO_DIR/shell.nix"

configure_startup_shell() {
	local fish_bin=""

	if command -v fish >/dev/null 2>&1; then
		fish_bin="$(command -v fish)"
	elif [ -x "$HOME/.nix-profile/bin/fish" ]; then
		fish_bin="$HOME/.nix-profile/bin/fish"
	fi

	if [ -z "$fish_bin" ]; then
		printf 'fish binary not found outside nix-shell; skipping login shell change.\n'
		return 0
	fi

	if [ "${SHELL:-}" != "$fish_bin" ]; then
		if grep -qx "$fish_bin" /etc/shells 2>/dev/null; then
			if chsh -s "$fish_bin" "$USER"; then
				printf 'Default login shell updated to fish: %s\n' "$fish_bin"
			else
				printf 'Unable to change login shell automatically.\n' >&2
			fi
		else
			printf 'fish is not listed in /etc/shells; cannot set it as login shell automatically.\n'
		fi
	else
		printf 'Login shell already set to fish.\n'
	fi

	if [ -f "$HOME/.zshrc" ] && ! grep -q "dotfiles-fish-autostart" "$HOME/.zshrc"; then
		cat >>"$HOME/.zshrc" <<'EOF'
# dotfiles-fish-autostart
if [ -z "$FISH_VERSION" ] && command -v fish >/dev/null 2>&1; then
  exec fish
fi
EOF
		printf 'Enabled fish autostart in ~/.zshrc\n'
	fi

	if [ -f "$HOME/.bashrc" ] && ! grep -q "dotfiles-fish-autostart" "$HOME/.bashrc"; then
		cat >>"$HOME/.bashrc" <<'EOF'
# dotfiles-fish-autostart
if [ -z "$FISH_VERSION" ] && command -v fish >/dev/null 2>&1; then
  exec fish
fi
EOF
		printf 'Enabled fish autostart in ~/.bashrc\n'
	fi
}

if ! command -v nix >/dev/null 2>&1; then
	printf 'Error: nix is not installed.\n' >&2
	printf 'Install nix first: https://nixos.org/download\n' >&2
	exit 1
fi

if [ ! -f "$SHELL_NIX" ]; then
	printf 'Error: shell.nix not found at %s\n' "$SHELL_NIX" >&2
	exit 1
fi

if ! command -v nix-shell >/dev/null 2>&1; then
	printf 'Error: nix-shell is not available in PATH.\n' >&2
	printf 'Install nix with nixpkgs support or enable nix-shell command.\n' >&2
	exit 1
fi

mkdir -p "$HOME/.config"

if [ -e "$NVIM_DEST" ] && [ ! -L "$NVIM_DEST" ]; then
	BACKUP_PATH="$HOME/.config/nvim.backup.$(date +%Y%m%d%H%M%S)"
	printf 'Backing up existing nvim config to %s\n' "$BACKUP_PATH"
	mv "$NVIM_DEST" "$BACKUP_PATH"
fi

if [ ! -d "$NVIM_SRC" ]; then
	printf 'Error: source nvim config not found at %s\n' "$NVIM_SRC" >&2
	exit 1
fi

ln -sfn "$NVIM_SRC" "$NVIM_DEST"
printf 'Linked %s -> %s\n' "$NVIM_DEST" "$NVIM_SRC"

if [ -d "$FISH_SRC" ]; then
	if [ -e "$FISH_DEST" ] && [ ! -L "$FISH_DEST" ]; then
		BACKUP_PATH="$HOME/.config/fish.backup.$(date +%Y%m%d%H%M%S)"
		printf 'Backing up existing fish config to %s\n' "$BACKUP_PATH"
		mv "$FISH_DEST" "$BACKUP_PATH"
	fi
	ln -sfn "$FISH_SRC" "$FISH_DEST"
	printf 'Linked %s -> %s\n' "$FISH_DEST" "$FISH_SRC"
fi

printf 'Bootstrapping with packages from shell.nix...\n'
nix-shell "$SHELL_NIX" --run "nvim --headless '+Lazy! sync' +qa || true"

printf 'Running Neovim health check in shell.nix environment...\n'
nix-shell "$SHELL_NIX" --run "nvim --headless '+checkhealth' +qa || true"

printf 'fish version in shell.nix environment: '
nix-shell "$SHELL_NIX" --run "fish --version || true"

configure_startup_shell

printf 'Done.\n'
