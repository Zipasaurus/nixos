{ config, pkgs, ...}:

{
	home.username = "zip";
	home.homeDirectory = "/home/zip";
	home.stateVersion = "25.11";
	programs.fish = {
        enable = true;
	shellAliases = {
		btw = "echo i use hyprland btw";
	#	nix = "nixos-rebuild switch --sudo --flake /etc/nixos#hyprland-btw"; 
      };
   };

}
