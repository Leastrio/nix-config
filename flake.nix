{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote.url = "github:nix-community/lanzaboote";

    # Programs
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    hytale-launcher.url = "github:TNAZEP/HytaleLauncherFlake";

    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jellynav.url = "github:Leastrio/jellynav";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    lanzaboote,
    nix-flatpak,
    ...
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      nest-nvim = pkgs.callPackage ./packages/nest-nvim.nix {};
      transparent-nvim = pkgs.callPackage ./packages/transparent-nvim.nix {};
    };

    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/desktop
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jacob = import ./home/jacob;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [
              (final: prev: {
                wf-config = prev.wf-config.overrideAttrs (old: {
                  mesonFlags =
                    (old.mesonFlags or [])
                    ++ [ "-Dtests=disabled" ];
                });

                wayfire = prev.wayfire.overrideAttrs (old: {
                  mesonFlags = 
                    (old.mesonFlags or [])
                    ++ [ 
                      "-Dtests=disabled"
                      "-Dwf-touch:tests=disabled"
                    ];
                });
              })
            ];
          }
          lanzaboote.nixosModules.lanzaboote
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server
        ];
      };

      mediaServer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/media_server
        ];
      };
    };

    darwinConfigurations."Jacobs-MacBook-Air" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        ./hosts/laptop
      ];
    };
  };
}
