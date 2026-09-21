{
  description = "NixOS configuration for MorStar";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sidra = {
      url = "github:wimpysworld/sidra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    concat = {
      url = "github:jub0t/Concat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sidra,
    sops-nix,
    concat,
    ...
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.morstar = import ./home.nix;
        }
      ];
    };
  };
}
