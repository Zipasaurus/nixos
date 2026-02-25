{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  
 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/London";
   
  services.getty.autologinUser = "zip";

  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
   }; 
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zip = {
    isNormalUser = true;
    description = "zipasaurus";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };


  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
  #-----Game-Launchers/Utilities-----#   
  steam
  prismlauncher
  beammp-launcher
  heroic
  gamescope
  gamemode
  mangohud

  #-----Apps-----#
  kdePackages.dolphin
  mission-center
  btop rocmPackages.mpi
  wofi
  discord
  firefox
  unityhub
  vscode
  spotify
  #-----HyprLand-Essentials-----#
  slurp grim
  waybar
  hypridle
  hyprlock
  unzip
  blueman
  #-----Shell-----#
  kitty fish fzf starship
  #-----Python-----#
  #python311
  #python310
  #-----Audio-Related-----#
  pavucontrol 
  helvum
  easyeffects

  #-----Random-Stuff-----#
  cifs-utils
  gvfs 
 #----Below-Is-For-UnrealEngine-----#

#inputs.unreal.packages.x86_64-linux.default



 #-----OBS-Related-----#
   (wrapOBS {
    plugins = with obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vaapi
      obs-vkcapture
      obs-websocket
      obs-shaderfilter
      obs-composite-blur
      obs-scale-to-sound
      obs-move-transition
    ];
  })
 


 ];

  #-----Below-Is-Steam-Related-----#
       programs.steam = {
	enable = true;
	remotePlay.openFirewall = true; 
	dedicatedServer.openFirewall = true;
	};

 
	 

  #-----Below-Is-Audio-Related-----#
  services.pipewire = {
	enable = true;
 	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
	wireplumber.enable = true;
    };
  #-----Below-Is-Graphics-Related-----#
 	hardware.graphics = {
	enable = true;
	enable32Bit = true;	
	extraPackages = with pkgs; [
	mesa
       ];
     };
  #-----Below-Is-Random-Important-Services-----#  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
  powerManagement.enable = true;
  boot.kernelModules = ["amd_pstate""amdgpu"];
   boot.kernelParams = ["amd_pstate=active"];
  services.xserver.videoDrivers = [ "amdgpu" ];

  #-----Below-Is-My-Drives-----#
   boot.supportedFilesystems = [ "ntfs" "ntfs3" ];
  fileSystems = {
    "/mnt/hardrive" = {
      device = "/dev/disk/by-uuid/FAFE38F3FE38A9B1";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "gid=100" "umask=022" "nofail" "x-gvfs-show" ];
    };
    "/mnt/gamessd" = {
      device = "/dev/disk/by-uuid/CA8E3E958E3E7A51";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "gid=100" "umask=022" "nofail" "x-gvfs-show" ];
    };
    "/mnt/samba" = {
      device = "//192.168.4.100/Shared";
      fsType = "cifs";
      options = [
        "username=zip"
        "password=277353"
        "uid=1000"
        "gid=1000"
        "iocharset=utf8"
        "noperm"
        "nofail"
      ];
    };
  };


  #-----FireWall-Settings-----#

   networking.firewall.allowedTCPPorts = [4444];
   networking.firewall.allowedUDPPorts = [4444];
   networking.firewall.enable = true;

  system.stateVersion = "25.11"; 
 }
