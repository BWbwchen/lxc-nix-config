{
  description = "Tim's NixOS config for LXC server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, # .
    nixpkgs, # stable pkgs
    nixpkgs-unstable, # unstable pkgs
    home-manager, # hm
    ... }:
    let
      user = "bw";
      system = "x86_64-linux";
      version = "23.11";
      pkgs-config = {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs pkgs-config;
    in {
      nixosConfigurations = {
        lxc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable pkgs-config;
            inherit user version pkgs;
          };
          modules = [
            ./hosts/lxc/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./hosts/lxc/home.nix;
                extraSpecialArgs = { inherit user version pkgs; };
              };
            }
          ];
        };
      };
    };
}
