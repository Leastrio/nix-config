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
      url = "github:noctalia-dev/noctalia";
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
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-darwin"];

    hmCommon = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs;};
      };
    };
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/desktop
          home-manager.nixosModules.home-manager
          hmCommon
          {home-manager.users.jacob.imports = [./home/jacob ./home/jacob/linux.nix];}
          {
            nixpkgs.config = {
              allowUnfree = true;
              permittedInsecurePackages = [
                "electron-40.10.5"
              ];
            };
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

      #mediaServer = nixpkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  modules = [
      #    ./hosts/media_server
      #  ];
      #};
    };

    darwinConfigurations."Jacobs-MacBook-Air" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit self inputs;};
      modules = [
        ./hosts/laptop
        home-manager.darwinModules.home-manager
        hmCommon
        {home-manager.users.jacob = import ./home/jacob;}
      ];
    };
  };
}
