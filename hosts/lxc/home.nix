{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/git
    ../../modules/tmux
    ../../modules/emacs
    ../../modules/zsh.nix
  ];

  home = {
    username = "bw";
    homeDirectory = "/home/bw";
    stateVersion = "23.11";
    sessionPath =
      [ "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.emacs.d/bin" ];
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.emacs.d/bin:$PATH
    '';
  };

  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    neovim

    # misc
    file
    which
    tree
    gnutar
    gnupg

    htop

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring

    python3
    nixfmt
    gnumake
    gdb
    cmake
    clang-tools_15
  ];

}
