{
    description = "zenit's nix config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        noctalia = {
            url = "github:noctalia-dev/noctalia/cachix";
        };
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        antigravity-nix = {
            url = "github:jacopone/antigravity-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };


    outputs = {self, nixpkgs, home-manager, nix-index-database, ...}@inputs: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [ 
                ./hosts/nixos/configuration.nix 
                nix-index-database.nixosModules.default
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit inputs; };
                    home-manager.backupFileExtension = "backup";
                    home-manager.users.zenit = import ./home/zenit.nix;
                }
            ];
        };
    };
}
