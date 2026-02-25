{
	description = "Hyprland on Nixos + Flakes + Home-Manager";

	inputs = {
	     nix.url = "nixpkgs/nixos-unstable";
	     home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	     };
 	#	unreal = {
	
	#	url = "path:/home/zip/apps/unreal/";
	#	inputs.nixpkgs.follows = "nixpkgs";
 	 #  };



       };
       
	outputs = { nixpkgs, home-manager, ... }@inputs: {
	    nixosConfigurations.hyprland-btw = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = {
			inherit inputs;
		};
#
		modules = [
		./configuration.nix
                home-manager.nixosModules.home-manager
		{
		     home-manager = {
			useGlobalPkgs = true;
			useUserPackages = true;
			users.zip = import ./home.nix;
  			backupFileExtension = "backup";
	
     		   }; 
   		}
	     ];
	  };
       };
}
