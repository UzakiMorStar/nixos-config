{
  description = "NixOS configuration with Niri and DMS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # 引入 DankMaterialShell 的稳定版 flake
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 引入 Niri 官方 flake (推荐，以获取最新特性)
    niri = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sidra = {
      url = "github:wimpysworld/sidra";
    };
  };

  outputs = { self, nixpkgs, dms, niri, ... }@inputs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # 将 inputs 传递给其他 Nix 文件
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        
        dms.nixosModules.dank-material-shell
      ];
    };
  };
}

