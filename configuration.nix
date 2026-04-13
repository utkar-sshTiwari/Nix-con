# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
	

  nix.settings.auto-optimise-store = true;



  # ----------------------------------------- HOME-MANAGER -----------------------------------------
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.archon = import ./home.nix;
	

  networking.networkmanager.wifi.powersave = false;


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "Abraxas"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = ["nix-command" "flakes"];
 

  # ------------------------- NVIDIA (Prime Offloading mode) + AMD GPU (Primary Display) -----------------------------------------------------------------------------------------------------------
  boot.initrd.kernelModules = [ "nvidia" ];

  boot.kernelParams = [
     "nvidia_drm.modeset=1"
     "nvidia_drm.fbdev=1"
  ];

  hardware.graphics = {
     enable = true;
     enable32Bit = true;
     extraPackages = with pkgs; [
        libva-vdpau-driver # Video Acceleration (More NVIDIA aligned, SELF NOTE TO CHECK)
        libvdpau-va-gl
       # libva-mesa-driver
       # mesa-vdpau
     ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
     modesetting.enable = true;
     powerManagement.enable = true; # help suspend-resume (Battery benefit)
     powerManagement.finegrained = false; # comepletely power-offs GPU when idle (can cause wake-up issues)
     open = false;
     nvidiaSettings = true;
     package = config.boot.kernelPackages.nvidiaPackages.stable;



     # PRIME OFFLOADING
     prime = {
       offload = {
           enable = true;
           enableOffloadCmd = true;
       };
       amdgpuBusId = "PCI:5:0:0";
       nvidiaBusId = "PCI:1:0:0";  
     };
  };
 




  # --------------------------------- HYPRLAND ---------------------------------------------------------------------------------------------------------------------------------------
  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };

  # ----------------------------------- ENV VARS ---------------------------------------
  environment.sessionVariables = {
     NIXOS_OZONE_WL = "1";
     WLR_NO_HARDWARE_CURSORS = "1";
     WLR_RENDERER_ALLOW_SOFTWARE = "1";
    # CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";        ------------------------------------------------CUDA STUFF
    # LD_LIBRARY_PATH = "${pkgs.cudaPackages.cudatoolkit}/lib:${pkgs.cudaPackages.cudnn}/lib";  ----------------------CUDA STUFF
  };

  xdg.portal = {
     enable = true;
     extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

 

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  security.rtkit.enable = true; # Daemon that allow for real-time cpu request 
  services.pipewire = {
     enable = true;
     pulse.enable = true;
     alsa.enable = true;
     wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.archon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # programs.firefox.enable = true;


  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    #Basics
    vim 
    wget
    curl
    lshw
    keepassxc
    playerctl
    brightnessctl
    pavucontrol

    #Hyprland
    kitty
    wofi

    
    #Vulkan/Gaming
    vulkan-tools
    vulkan-loader
    nvidia-vaapi-driver



    #CUDA/AI
    # cudatoolkit
    # cudnn
    python3
  ];


  # ---------------------------- THUNAR --------------------------------------------------------------
  programs.xfconf.enable = true;

  # services.udisks2.enable = true;  # Device management
  services.gvfs.enable = true;  # Mount, trash + other functionalities
  # services.devmon.enable = true;  # req for automount + permissions
  services.tumbler.enable = true; # Thumbnail support for images

  programs.thunar.enable = true; # enable thunar + plugins



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

