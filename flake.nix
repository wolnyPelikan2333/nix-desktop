{
  description = "NixOS + Home-Manager configuration for desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NH — najnowsza wersja (5.x)
    nh.url = "github:viperML/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nh, ... }@inputs:
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

          # NH dostępny systemowo
          {
            environment.systemPackages = [
              nh.packages.${system}.default
            ];
          }
        ];
      };

      # ---- Wymagane przez NH ----
      packages.${system}.default =
        self.nixosConfigurations.desktop.config.system.build.toplevel;

      # Dodatkowe aliasy na życzenie
      packages.${system}.desktop =
        self.nixosConfigurations.desktop.config.system.build.toplevel;
    };
}

