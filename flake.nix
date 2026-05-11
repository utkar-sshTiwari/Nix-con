{
  description = "Archon's Grid";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
	url = "github:youwen5/zen-browser-flake";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zen-browser, home-manager, ...}: {
     nixosConfigurations.Abraxas = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
	   ./configuration.nix
#	   ./modules/nix_services/webstack.nix
#	   ./modules/nix_services/sqlish.nix
		
	   # Home-manager here is a module but zen is an application	
	   home-manager.nixosModules.home-manager

	   {
		environment.systemPackages = [
		   zen-browser.packages.x86_64-linux.default
		];
	   }
	];
     };
   
  };
}
