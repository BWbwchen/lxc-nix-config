{
  description = "Tim's NixOS config for LXC server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      lxc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # specialArgs = {...};  # pass custom arguments into all submodules.
        modules = [
          ./hosts/lxc/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bw = import ./hosts/lxc/home.nix;
          }
        ];
      };
    };
  };
}
