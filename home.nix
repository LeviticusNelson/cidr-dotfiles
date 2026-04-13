{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neovim git curl wget unzip gnutar gzip ripgrep fd fzf lazygit
    go gopls golangci-lint delve gotools gofumpt gnumake gcc nodejs
    python3 python3Packages.pynvim docker-client docker-compose xclip
    luarocks lua-language-server stylua nil nixd starship atuin execline
  ];

  programs.fish.enable = true;
}
