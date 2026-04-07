{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
    name = "levi-tools";
    paths =  [
      neovim
      fish
      git
      curl
      wget
      unzip
      gnutar
      gzip
      ripgrep
      fd
      fzf
      lazygit
      go
      gopls
      golangci-lint
      delve
      gotools
      gofumpt
      gnumake
      gcc
      nodejs
      python3
      python3Packages.pynvim
      docker-client
      docker-compose
      xclip
      luarocks
      lua-language-server
      stylua
      nil
      nixd
    ];
    };
  };
}
