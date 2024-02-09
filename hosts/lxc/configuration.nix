{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/lxc-container.nix>
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = true; # enable password login
    };
    openFirewall = true;
  };

  programs.zsh.enable = true;
  users.users.bw = {
    isNormalUser = true;
    description = "Tim";
    extraGroups = [ "networkmanager" "wheel" ];
    password = "bw";
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.11";
}
