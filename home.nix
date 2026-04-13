{config, pkgs, ...}:

{
     home.username = "archon";
     home.homeDirectory = "/home/archon";
     home.stateVersion = "25.11";


     # -------------------------- PKGS  ----------------------------
     home.packages = with pkgs; [
	neovim
	fastfetch
	btop
	yazi
	waybar
	spotify
#	wl-clipboard
	# obsidian
     ];


 #------------------------------------------------------- GIT ---------------------------------------

	programs.git = {
	  enable = true;
	  settings = {
	      user = {
		  name = "utkar-sshTiwari";
		  email = "akh_utkarsh@proton.me";
	       };
	   init.defaultBranch = "main";
	   
	   };

	};




     
     # ---------------------------- WAYBAR ---------------------------

     programs.waybar = {
  enable = true;
  
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      spacing = 4;

      modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" "tray" ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };

      "clock" = {
        format = "{:%H:%M   %d/%m/%Y}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
      };

      "cpu" = {
        format = " {usage}%";
        tooltip = false;
      };

      "memory" = {
        format = " {}%";
      };

      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-icons = ["" "" "" "" ""];
      };

      "network" = {
        format-wifi = " {signalStrength}%";
        format-ethernet = " {ipaddr}";
        format-disconnected = "⚠ Disconnected";
      };

      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-muted = " muted";
        format-icons = {
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };

	      "tray" = {
		spacing = 10;
	      };
	    };
	  };

	  style = ''
	    * {
	      font-family: "JetBrainsMono Nerd Font";
	      font-size: 13px;
	    }

	    window#waybar {
	      background-color: rgba(26, 27, 38, 0.9);
	      color: #cdd6f4;
	      border-bottom: 2px solid #89b4fa;
	    }

	    #clock, #cpu, #memory, #battery, #network, #pulseaudio, #tray {
	      padding: 0 10px;
	      color: #cdd6f4;
	    }

	    #battery.warning { color: #f9e2af; }
	    #battery.critical { color: #f38ba8; }
	  '';
	};




     # ----------------------- HYPRPAPER ---------------------------------
     services.hyprpaper = {
	enable = true;

	settings = {
	splash = false;
	

	preload = ["/home/archon/Abraxas/Wallpaper/Nix-ium.png"];

	wallpaper = [
	  {
	   monitor = "";
	   path = "/home/archon/Abraxas/Wallpaper/Nix-ium.png";
	  }
	];
       };
     };



     # -------------------------- KITTY -------------------------------
     programs.kitty = {
	settings = {
	   confirm_os_window_close = 0; 
	};
     };



 #     #----------------------------- NVIM ----------------------------
 #     programs.neovim = {
 #	enable = true;
 #	extraLuaConfig = ''
 #		vim.opt.clipboard = "unnamedplus"
 #	'';
 #     };


     # --------------------------HYPRLAND ------------------------------
     wayland.windowManager.hyprland = {
	enable = true;
	settings = {
		
		monitor = ",preferred,auto,1";
		
		exec-once = [
		   "waybar"
		   "hyprpaper"
		];
		
		env = [
		   "LIBVA_DRIVER_NAME, nvidia"
		   "GBM_BACKEND, nvidia-drm"
		   "__GLX_VENDOR_LIBRARY_NAME, nvidia"
		   "WLR_NO_HARDWARE_CURSORS,1"
		   "NIXOS_OZONE_WL,1"
		   # "__GL_GSYNC_" # Literally GSYNC
		   "NVD_BACKEND, direct"

		];


		general = {
		    gaps_in = 6;
		    gaps_out = 15;
		    border_size = 2;
		    layout = "dwindle";
		};


		decoration = {
		    rounding = 10;
	            
		    #drop_shadow = true;
		    #shadow_range = 3;
		    #shadow_render_power = 3;
		};

		

     

     		"$mod" = "SUPER";
		"$terminal" = "kitty";
		"$fileManager" = "thunar";
		"$menu" = "wofi --show drun";
		"$browser" = "zen";
     
     		bind = [
		   "$mod, Q, exec, $terminal"
		   "$mod_SHIFT, C, killactive"
		   "$mod_SHIFT, L, exit"
		   "$mod, E, exec, $fileManager"
		   "$mod, R, exec, $menu"
		   "$mod, B, exec, $browser"
		   "$mod, V, togglefloating"
		   "$mod, J, layoutmsg, togglesplit" #dwindle
		   "$mod SHIFT, J, layoutmsg, swapsplit "
		   "$mod, P, pseudo" #dwindle 
		   "$mod, M, fullscreen, 1"
		   "$mod_SHIFT, M, fullscreen"

		   # Move focus 
		   "$mod, left, movefocus, l"
		   "$mod, right, movefocus, r"
		   "$mod, up, movefocus, u"
		   "$mod, down, movefocus, d"

		   
		   # Switch Workspaces
		   "$mod, 1, workspace, 1"
		   "$mod, 2, workspace, 2"
		   "$mod, 3, workspace, 3"
		   "$mod, 4, workspace, 4"
		   "$mod, 5, workspace, 5"
		   "$mod, 6, workspace, 6"
		   "$mod, 7, workspace, 7"
		   "$mod, 8, workspace, 8"
		   "$mod, 9, workspace, 9"


		   # Move active window to a workspace
		   "$mod SHIFT, 1, movetoworkspace, 1"
		   "$mod SHIFT, 2, movetoworkspace, 2"
		   "$mod SHIFT, 3, movetoworkspace, 3"
		   "$mod SHIFT, 4, movetoworkspace, 4"
		   "$mod SHIFT, 5, movetoworkspace, 5"
		   "$mod SHIFT, 6, movetoworkspace, 6"
		   "$mod SHIFT, 7, movetoworkspace, 7"
		   "$mod SHIFT, 8, movetoworkspace, 8"
		   "$mod SHIFT, 9, movetoworkspace, 9"
		   "$mod SHIFT, 0, movetoworkspace, 10"


		   # Speical workspace (scratchpad)
		   "$mod, S, togglespecialworkspace, magic"
		   "$mod SHIFT, S, movetoworkspace, special:magic"
		  

		   # Mouse wheel through workspace
		   "$mod, mouse_down, workspace, e+1"
		   "$mod, mouse_up, workspace, e-1"
		];


		bindm = [
		   # Move/resize windows
		   "$mod, mouse:272, movewindow"
		   "$mod, mouse:273, resizewindow"
     		];

		bindel = [
			   # Laptop multimedia Keys for volume and LCS brightness
			",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+"
			",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"
			",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
			",XF86MonBrightnessUp, exec, brightnessctl s 3%+"
			",XF86MonBrightnessDown, exec, brightnessctl s 3%-"

			# Requires playerctl
			", XF86AudioNext, exec, playerctl next"
			", XF86AudioPause, exec, playerctl play-pause"
			", XF86AudioPlay, exec, playerctl play-pause"
			", XF86AudioPrev, exec, playerctl previous"
		];
	
     	    };
	};



    # --------------------------- BASH --------------------------	
     programs.bash = {
	enable = true;
	
	bashrcExtra = ''
		fastfetch
	'';

	shellAliases = {
	   kun = "echo archon-kun with Abraxas-sama";
	};
     };


}
