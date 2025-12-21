{
  description = "NixOS + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      # 👇 teraz inputs i self ISTNIEJĄ
      specialArgs = {
        inherit inputs self;
      };

      modules = [
        ./nixos/configuration.nix
        ./plasma.nix

        # Home Manager jako moduł systemowy
        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # 👇 przekazanie inputs/self do Home-Managera
          home-manager.extraSpecialArgs = {
            inherit inputs self;
          };

          home-manager.users.michal = import ./home/michal.nix;
        }
      ];
    };
  };
}

