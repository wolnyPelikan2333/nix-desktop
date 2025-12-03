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
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.michal.home.stateVersion = "25.05";
          }

          # NH — z nixpkgs (działa, nie kompiluje)
          {
            environment.systemPackages = [
              nixpkgs.pkgs.nh
            ];
          }
        ];
      };

      # Fix for nh (required for flake-only systems)
      packages.${system}.default =
        self.nixosConfigurations.desktop.config.system.build.toplevel;
    };
}

