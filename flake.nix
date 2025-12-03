{
  description = "NixOS + Home-Manager configuration for desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      # ---- NixOS configuration ----
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.michal = {
              home.stateVersion = "25.05";
            };
          }
        ];
      };

      # ---- Fix for nh ----
      packages.${system}.desktop =
        self.nixosConfigurations.desktop.config.system.build.toplevel;
    };
}

