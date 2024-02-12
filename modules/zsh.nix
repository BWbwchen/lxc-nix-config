{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      enableCompletion = true;

      oh-my-zsh = { # Extra plugins for zsh
        enable = true;
        theme = "af-magic";
        plugins = [ "git" "fzf" ];
      };

      shellAliases = {
        # vim = "lvim";
        df = "duf";
      };
    };

    fzf = { enable = true; };
  };
}
