{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    mcp-hub.url = "github:ravitemer/mcp-hub";
    winboat.url = "github:TibixDev/winboat";
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, nixgl, ... }: 
  let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        # "aarch64-linux"
        # "i686-linux"
        "x86_64-linux"
        # "aarch64-darwin"
        # "x86_64-darwin"
      ];

    in
    rec {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;

      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        nixps13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./home-laptop/configuration.nix
            ./modules/services
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.globule = import ./home-manager/nixps13.nix;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
        nixospc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixospc/configuration.nix
            # ./modules/services
            home-manager.nixosModules.home-manager
            disko.nixosModules.disko
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.globule = import ./home-manager/nixospc.nix;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
        oldnix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./oldnix/configuration.nix
            # ./modules/services
            home-manager.nixosModules.home-manager
            disko.nixosModules.disko
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.globule = import ./home-manager/oldnix.nix;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
        fannixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./pc_fanny/configuration.nix
            home-manager.nixosModules.home-manager
            disko.nixosModules.disko
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.fanny = import ./home-manager/fannixos.nix;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
            }
          ];
        };
        kube-01 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            disko.nixosModules.disko
            ./nix-lab/kube-01.nix
          ];
        };
        kube-02 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            disko.nixosModules.disko
            ./nix-lab/kube-02.nix
          ];
        };
        kube-03 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            disko.nixosModules.disko
            ./nix-lab/kube-03.nix
          ];
        };
        kube-04 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            disko.nixosModules.disko
            ./nix-lab/kube-04.nix
          ];
        };
      };

      homeConfigurations = {
        dz_laptop = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/dz_laptop.nix
          ];
        };
        wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/wsl.nix
          ];
        };
      };

  };
}
