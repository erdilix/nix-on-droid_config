{
  description = "Advanced example of Nix-on-Droid system config with home-manager.";

  inputs = {
    nixpkgsold.url = "github:NixOS/nixpkgs/nixos-24.05";
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";  #roll-back for nixcats-nvim 
    home-manager = {
      url = "github:nix-community/home-manager";
      #url = "github:nix-community/home-manager/release-25.05";
      
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixcats-nvim-uwu = {
	url = "github:erdilix/nixcats-nvim-uwu";
	inputs.nixpkgs.follows="nixpkgs-stable"; #neovim not working in pkgs 26 ver. because some proot guardrail 
    };
  };
  outputs = { self, nixpkgs, nixpkgsold,  home-manager, nix-on-droid, nixcats-nvim-uwu, ... }@inputs:
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
	  nix-on-droid.overlays.default
	  #add other overlays
        ];
      };
    in {
    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      modules = [
        ./nix-on-droid.nix
	# wrap functionable nix-collect-garbage
	({pkgs, ...}:{
	  environment.packages = [
	    (pkgs.writeShellScriptBin "ngc" ''
	      exec "${nixpkgsold.legacyPackages.${pkgs.system}.nix}/bin/nix-collect-garbage" "$@" 
	    '')
	  ];
	})
        # list of extra modules for Nix-on-Droid system
        # { nix.registry.nixpkgs.flake = nixpkgs; }
        # ./path/to/module.nix

        # or import source out-of-tree modules like:
        # flake.nixOnDroidModules.module
      ];

      # list of extra special args for Nix-on-Droid modules
      extraSpecialArgs = {
        # rootPath = ./.;
	inherit inputs system;
      };

      # set nixpkgs instance, it is recommended to apply `nix-on-droid.overlays.default`
      inherit pkgs;

      # set path to home-manager flake
      home-manager-path = home-manager.outPath;
    };
    
    # standalone home manager confih
      homeConfigurations = {
        erdilix = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./home-manager/home.nix
            nixcats-nvim-uwu.homeModules.default
          ];
          extraSpecialArgs = { inherit inputs system; };
        };
      };

  };
}
