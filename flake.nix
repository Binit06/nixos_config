{
    description = "zenit's nix config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        noctalia = {
            url = "github:noctalia-dev/noctalia/cachix";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        antigravity-nix = {
            url = "github:jacopone/antigravity-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };


    outputs = {self, nixpkgs, home-manager, ...}@inputs: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [ 
                ./hosts/nixos/configuration.nix 
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
