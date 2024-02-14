{ config, lib, pkgs, ... }:

{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  environment.systemPackages = with pkgs; [ vim curl wget ];
  environment.variables.EDITOR = "vim";

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };
}
