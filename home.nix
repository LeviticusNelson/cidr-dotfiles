{ config, pkgs, ... }:

{
  home.username = "vscode";
  home.homeDirectory = "/home/vscode";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neovim git curl wget unzip gnutar gzip ripgrep fd fzf lazygit
    go gopls golangci-lint delve gotools gofumpt gnumake gcc nodejs
    python3 python3Packages.pynvim docker-client docker-compose xclip
    luarocks lua-language-server stylua nil nixd starship atuin execline
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      atuin init fish | source
      starship init fish | source
      set -gx EDITOR nvim
      set -U fish_greeting
      set -U fish_key_bindings fish_default_key_bindings
      set -U fish_cursor_default line
      fish_add_path "$HOME/.local/bin"
    '';
  };
  programs.home-manager.enable = true;
}
