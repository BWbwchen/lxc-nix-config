{ config, lib, pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = { default-cache-ttl = 86400; };
  };
  programs.direnv.enable = true;
}
