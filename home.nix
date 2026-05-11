{config, pkgs, ...}:

{
     home.username = "archon";
     home.homeDirectory = "/home/archon";
     home.stateVersion = "25.11";
	
	

    imports = [
	./fastfetch.nix
	./neovim.nix
	./yazi.nix
    ];
	


     # -------------------------- PKGS  ----------------------------
     home.packages = with pkgs; [
#	neovim
	fastfetch
	btop
	yazi
	waybar
	spotify
#	lutris
	grim
	slurp
	swappy
	wl-clipboard
	# obsidian
	kdePackages.gwenview
	quodlibet
	calibre
	pdfarranger
	# cisco-packet-tracer_8
	mangohud
	bat
	go
	obs-studio
	vlc
	cowsay
	zathura
	rustc
	cargo
	peazip
	zathura
#	phinger-cursors
	discord
	typst
	noto-fonts
	qemu
	gimp
	obsidian
	lutris
	sioyek
     ];


    

    # ----------------------------------- STEAM --------------------------------------------------
#    programs.steam = {
#	enable = true;
#	gamescopeSession.enable = true;
#    };

    #    programs.gamemode.enable = true;


	# ----------------------  
     	home.pointerCursor = {
		name = "phinger-cursors";
		package = pkgs.phinger-cursors;
		size = 24;

		gtk.enable = true;
		x11.enable = true;
	};

	home.sessionVariables = {
  		XCURSOR_THEME = "phinger-cursors";
  		XCURSOR_SIZE = "24";
		SUDO_EDITOR = "nvim";
		EDITOR = "nvim";
	};







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

    # ── Bar layout & modules ──────────────────────────────────────────────────
    settings = [{
      layer   = "top";
      position = "top";
      height  = 20;
      spacing = 0;
      exclusive = true;

      # ── Module placement ───────────────────────────────────────────────────
      modules-left   = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "disk" ];
      modules-right  = [
        "temperature"
        "cpu"
        "memory"
        "network#wifi"
        "network#eth"
        "pulseaudio"
        "backlight"
        "battery"
        "clock"
        "tray"
      ];

      # ── Left ───────────────────────────────────────────────────────────────
      "hyprland/workspaces" = {
        format          = "{id}";
        on-click        = "activate";
        sort-by-number  = true;
        active-only     = false;
        all-outputs     = false;
      };

      "hyprland/window" = {
        format         = "{title}";
        max-length     = 60;
        separate-outputs = true;
      };

      # ── Center ─────────────────────────────────────────────────────────────
      "disk" = {
        interval        = 30;
        path            = "/";
        format          = "Folder: {used} / {total} ({percentage_used}%)";
        # Add more paths if needed:
        # "disk#home" = { path = "/home"; format = "Home: {used}"; };
        tooltip         = true;
        tooltip-format  = "{path}: {used} used of {total} ({free} free)";
      };

      # ── Right ──────────────────────────────────────────────────────────────
      "temperature" = {
        # Adjust hwmon-path to your CPU sensor, e.g.:
        # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        thermal-zone    = 0;
        interval        = 5;
        critical-threshold = 90;
        format          = "Temp: {temperatureC} °C";
        format-critical = "🔥 {temperatureC} °C";
        tooltip         = false;
      };

      "cpu" = {
        interval = 5;
        format   = "CPU Load: {load}";
        tooltip  = true;
        tooltip-format = "Hot Loads: {usage}% | {load} load avg";
      };

      "memory" = {
        interval = 10;
        format   = "RAM: {used:0.1f}G";
        tooltip  = true;
        tooltip-format = "Used: {used:0.1f}G / {total:0.0f}G\nSwap: {swapUsed:0.1f}G";
      };

      "network#wifi" = {
        interface       = "wl*";
        interval        = 5;
        format-wifi     = "W: ({signalStrength}%) {ipaddr}";
        format-disconnected = "W: down";
        format-disabled = "W: off";
        tooltip         = true;
        tooltip-format  = "SSID: {essid}\nIP: {ipaddr}\n↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}";
        on-click        = "nm-connection-editor";
      };

      "network#eth" = {
        interface       = "en*";
        interval        = 5;
        format-ethernet = "E: {ipaddr}";
        format-disconnected = "E: down";
        tooltip         = true;
        tooltip-format  = "IP: {ipaddr}\n↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}";
      };

      "pulseaudio" = {
        format          = "Vol: {volume}%";
        format-muted    = "Vol: mute";
        scroll-step     = 5;
        on-click        = "pavucontrol";
        tooltip         = true;
        tooltip-format  = "{desc} — {volume}%";
      };

      "backlight" = {
        # device = "intel_backlight";   # uncomment & adjust if auto-detect fails
        format          = "Bri: {percent}%";
        scroll-step     = 5;
        on-scroll-up    = "brightnessctl set +5%";
        on-scroll-down  = "brightnessctl set 5%-";
        tooltip         = false;
      };

      "battery" = {
        interval        = 30;
        states          = { warning = 30; critical = 15; };
        format          = "BAT {capacity}%";
        format-charging = "BAT ⚡{capacity}%";
        format-plugged  = "BAT 🔌{capacity}%";
        format-critical = "BAT ⚠ {capacity}%";
        tooltip         = true;
        tooltip-format  = "{timeTo} — {power:.1f}W";
      };

      "clock" = {
        interval       = 1;
        format         = "{:%Y-%m-%d %H:%M:%S}";
        tooltip        = true;
        tooltip-format = "<big>{:%A, %d %B %Y}</big>\n<tt>{calendar}</tt>";
        locale         = "en_US.UTF-8";
      };

      "tray" = {
        icon-size   = 14;
        spacing     = 6;
        show-passive-items = true;
      };
    }];

    # ── Stylesheet — matches the black/monospace/pipe-separated look ──────────
    style = ''
      /* ── Reset ──────────────────────────────────────────────────────────── */
      * {
        font-family: "JetBrains Mono", "Fira Code", monospace;
        font-size:   12px;
        min-height:  0;
        border:      none;
        border-radius: 0;
        padding:     0;
        margin:      0;
      }

      /* ── Bar body ────────────────────────────────────────────────────────── */
      window#waybar {
        background-color: #0a0a0a;
        color:            #c8c8c8;
      }

      /* ── Generic module wrapper ──────────────────────────────────────────── */
      .modules-left,
      .modules-center,
      .modules-right {
        background-color: transparent;
      }

      /* ── Pipe separators via padding + border trick ──────────────────────── */
      #workspaces,
      #window,
      #disk,
      #temperature,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #backlight,
      #battery,
      #clock,
      #tray {
        padding: 0 6px;
        color:   #c8c8c8;
      }

      /* Right-side modules get a left pipe separator */
      #temperature,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #backlight,
      #battery,
      #clock {
        border-left: 1px solid #333333;
      }

      /* ── Workspaces ──────────────────────────────────────────────────────── */
      #workspaces button {
        padding:    0 5px;
        color:      #666666;
        background: transparent;
        border:     none;
      }

      #workspaces button.active {
        color: #ffffff;
      }

      #workspaces button.urgent {
        color: #ff5555;
      }

      /* ── Window title ────────────────────────────────────────────────────── */
      #window {
        color: #888888;
      }

      /* ── Disk (center) ───────────────────────────────────────────────────── */
      #disk {
        color: #c8c8c8;
      }

      /* ── Temperature ─────────────────────────────────────────────────────── */
      #temperature {
        color: #ff8c00;    /* orange — matches "Taa: 100 °C" */
      }

      #temperature.critical {
        color: #ff3333;
      }

      /* ── CPU load ────────────────────────────────────────────────────────── */
      #cpu {
        color: #e5c07b;
      }

      /* ── Memory ──────────────────────────────────────────────────────────── */
      #memory {
        color: #98c379;
      }

      /* ── Network ─────────────────────────────────────────────────────────── */
      #network {
        color: #61afef;    /* blue — matches "W: (85%) Leaked IP:" */
      }

      #network.disconnected,
      #network.disabled {
        color: #555555;
      }

      /* ── Audio ───────────────────────────────────────────────────────────── */
      #pulseaudio {
        color: #c678dd;
      }

      #pulseaudio.muted {
        color: #555555;
      }

      /* ── Brightness ──────────────────────────────────────────────────────── */
      #backlight {
        color: #e5c07b;
      }

      /* ── Battery ─────────────────────────────────────────────────────────── */
      #battery {
        color: #98c379;
      }

      #battery.warning {
        color: #e5c07b;
      }

      #battery.critical {
        color: #ff3333;
        animation-name:     blink;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #battery.charging,
      #battery.plugged {
        color: #56b6c2;
      }

      @keyframes blink {
        to { color: #ffffff; }
      }

      /* ── Clock ───────────────────────────────────────────────────────────── */
      #clock {
        color: #abb2bf;    /* matches the datetime on the far right */
      }

      /* ── Tray ────────────────────────────────────────────────────────────── */
      #tray {
        padding: 0 4px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #ff3333;
      }
    '';
  };





     # ----------------------- HYPRPAPER ---------------------------------
     services.hyprpaper = {
	enable = true;

	settings = {
	splash = false;
	

	preload = ["/home/archon/Abraxas/Wallpaper/Kun.png"];

	wallpaper = [
	  {
	   monitor = "";
	   path = "/home/archon/Abraxas/Wallpaper/Kun.png";
	  }
	];
       };
     };



     # -------------------------- KITTY -------------------------------
     programs.kitty = {
     	enable = true;
	font = {
		name = "JetBrains Mono";
		size = 11;
	};

    	




	    # ── Main settings ─────────────────────────────────────────────────────────
    settings = {

      # ── Colours ─────────────────────────────────────────────────────────────
      #
      #   Base bg/fg stay true to the waybar black, but the 16-colour
      #   palette gets a hard bump in saturation & brightness:
      #
      #   red     #ff3366  — hot raspberry         (errors, critical battery)
      #   green   #00e5a0  — electric mint         (success, memory, bat ok)
      #   yellow  #ffcc00  — vivid gold            (cpu, backlight, warnings)
      #   blue    #22d4ff  — electric sky          (network, URLs, info)
      #   magenta #cc55ff  — vivid violet          (audio, git branch, kw)
      #   cyan    #00e5e5  — neon teal             (battery charging, types)
      #   orange  #ff6e3a  — hot ember             (temperature, numbers)
      #   white   #e0e0e0  — crisp off-white       (foreground prose)
      #
      # ── Background / foreground ──────────────────────────────────────────────
      background            = "#0d0d0f";   # slightly cooler than pure black
      foreground            = "#e0e0e0";
      selection_background  = "#22253a";
      selection_foreground  = "#ffffff";

      # Cursor — electric sky, matches network/link colour
      cursor                = "#22d4ff";
      cursor_text_color     = "#0d0d0f";
      cursor_shape          = "block";
      cursor_blink_interval = "0";

      # ── 16-colour palette ────────────────────────────────────────────────────
      # Black pair
      color0  = "#1a1a1f";               # dark surface
      color8  = "#2e2e38";               # bright black / dim ui

      # Red   — hot raspberry
      color1  = "#ff3366";
      color9  = "#ff6688";

      # Green — electric mint
      color2  = "#00e5a0";
      color10 = "#33ffbb";

      # Yellow — vivid gold
      color3  = "#ffcc00";
      color11 = "#ffe566";

      # Blue — electric sky
      color4  = "#22d4ff";
      color12 = "#66e2ff";

      # Magenta — vivid violet
      color5  = "#cc55ff";
      color13 = "#dd88ff";

      # Cyan — neon teal
      color6  = "#00e5e5";
      color14 = "#33ffff";

      # White
      color7  = "#c0c0cc";
      color15 = "#ffffff";

      # ── Window / padding ────────────────────────────────────────────────────
      window_padding_width         = 8;
      window_margin_width          = 0;
      single_window_margin_width   = 0;
      placement_strategy           = "top-left";
      remember_window_size         = true;

      # ── Borders ─────────────────────────────────────────────────────────────
      draw_minimal_borders         = true;
      window_border_width          = "1px";
      active_border_color          = "#22d4ff";   # electric sky accent
      inactive_border_color        = "#1e1e22";
      bell_border_color            = "#ffcc00";

      # ── Tab bar — pipe-separated, matches waybar style ───────────────────────
      tab_bar_edge                 = "top";
      tab_bar_style                = "separator";
      tab_separator                = " | ";
      tab_title_template           = "{index}: {title}";
      active_tab_title_template    = "{index}: {title}";
      active_tab_foreground        = "#22d4ff";   # blue — pops on black
      active_tab_background        = "#0d0d0f";
      active_tab_font_style        = "bold";
      inactive_tab_foreground      = "#2e2e38";
      inactive_tab_background      = "#0d0d0f";
      inactive_tab_font_style      = "normal";
      tab_bar_background           = "#0d0d0f";
      tab_bar_margin_color         = "#0d0d0f";
      tab_bar_min_tabs             = 1;

      # ── Rendering ───────────────────────────────────────────────────────────
      repaint_delay                = 10;
      input_delay                  = 3;
      sync_to_monitor              = true;

      # ── URL style ───────────────────────────────────────────────────────────
      url_style                    = "single";
      url_color                    = "#22d4ff";
      open_url_with                = "default";

      # ── Bell ────────────────────────────────────────────────────────────────
      enable_audio_bell            = false;
      visual_bell_duration         = "0.0";

      # ── Misc ────────────────────────────────────────────────────────────────
      shell                        = ".";
      editor                       = ".";
      close_on_child_death         = false;
      allow_remote_control         = true;
      listen_on                    = "unix:/tmp/kitty";
      update_check_interval        = 0;
      clipboard_control            = "write-clipboard write-primary read-clipboard-ask read-primary-ask";

      # ── Transparency ────────────────────────────────────────────────────────
      background_opacity           = "1.00";
      dynamic_background_opacity   = true;
    };

};







	#----------------------WOFI---------------------------------------	
	programs.wofi = {
    	enable = true;

    # ── Launch settings ───────────────────────────────────────────────────────
    settings = {
      width              = 600;
      height             = 400;
      location           = "center";
      show               = "drun";
      prompt             = "run:";
      filter_rate        = 100;
      allow_markup       = true;
      no_actions         = true;
      halign             = "fill";
      orientation        = "vertical";
      content_halign     = "fill";
      insensitive        = true;       # case-insensitive search
      allow_images       = true;
      image_size         = 20;
      gtk_dark           = true;
      dynamic_lines      = false;      # fixed height — no jumping
      term               = "kitty";
      hide_scroll        = true;
    };

    # ── Stylesheet ────────────────────────────────────────────────────────────
    style = ''
      /* ── Fonts & reset ─────────────────────────────────────────────────── */
      * {
        font-family:  "JetBrains Mono", "Fira Code", monospace;
        font-size:    13px;
      }

      /* ── Outer window ───────────────────────────────────────────────────── */
      window {
        background-color: #0d0d0f;
        border:           1px solid #1e1e24;
        border-radius:    4px;
      }

      /* ── Inner scroll / list container ─────────────────────────────────── */
      #inner-box {
        background-color: transparent;
        margin:           0;
        padding:          0;
      }

      #outer-box {
        background-color: transparent;
        margin:           0;
        padding:          6px;
      }

      #scroll {
        background-color: transparent;
        margin:           0;
        border:           none;
      }

      /* ── Search input ───────────────────────────────────────────────────── */
      #input {
        background-color: #111116;
        color:            #e0e0e0;
        border:           1px solid #1e1e24;
        border-radius:    2px;
        padding:          8px 12px;
        margin:           6px 6px 4px 6px;
        outline:          none;
        caret-color:      #22d4ff;
      }

      #input:focus {
        border-color:     #22d4ff;    /* electric sky — matches active border */
      }

      /* placeholder text */
      #input placeholder {
        color:            #2e2e38;
      }

      /* ── Individual entries ─────────────────────────────────────────────── */
      #entry {
        background-color: transparent;
        color:            #c0c0cc;
        padding:          6px 10px;
        border-radius:    2px;
        margin:           1px 4px;
        border:           1px solid transparent;
      }

      #entry:hover {
        background-color: #111116;
        color:            #e0e0e0;
        border-color:     #1e1e24;
      }

      /* ── Selected / active entry ────────────────────────────────────────── */
      #entry:selected,
      #entry.activatable:selected {
        background-color: #111116;
        color:            #22d4ff;    /* electric sky */
        border-color:     #22d4ff;
      }

      /* ── App name text ──────────────────────────────────────────────────── */
      #text {
        color:   inherit;
        margin:  0 0 0 8px;
      }

      #text:selected {
        color:   #22d4ff;
      }

      /* ── App description / subtitle ─────────────────────────────────────── */
      #entry > box > #text + label {
        color:       #2e2e38;
        font-size:   11px;
      }

      #entry:selected > box > #text + label {
        color:       #333344;
      }

      /* ── Icon ───────────────────────────────────────────────────────────── */
      #img {
        margin-right: 6px;
      }

      /* ── No results message ─────────────────────────────────────────────── */
      #entry.no-match #text {
        color:   #ff3366;    /* hot raspberry — stands out as an error state */
      }
    '';
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
		   "hyprctl setcursor phinger-cursors-dark 24"
		];
		
		env = [
		   "LIBVA_DRIVER_NAME, nvidia"
		   "GBM_BACKEND, nvidia-drm"
		   "__GLX_VENDOR_LIBRARY_NAME, nvidia"
		   "WLR_NO_HARDWARE_CURSORS,1"
		   "NIXOS_OZONE_WL,1"
		  # "XCURSOR_THEME,phinger-cursors-dark"
		   "XCURSOR_SIZE, 24"
		   # "__GL_GSYNC_" # Literally GSYNC
		   "NVD_BACKEND, direct"

		];


		general = {
		    gaps_in = 6;
		    gaps_out = 16;
		    border_size = 2;
		    layout = "dwindle";

		    "col.active_border" = "rgba(ff6e3aff) rgba(ffcc00ff) rgba(00e5a0ff) 45deg";
		    "col.inactive_border" = "rgba(1e1e24ff)";
		};


		decoration = {
		    rounding = 12;
		    active_opacity = 1.0;
		    inactive_opacity = 1.0;
	            
		 		

	#	shadow = {
	#		enabled = true;
	#		range = 12;
	#		render_power = 3;
	#		color         = "rgba(22d4ff22)";   # blue tint, low alpha
	#		};
		};



		animations = {
			enabled = false;
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


		   "$mod, PRINT, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%s).png"

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
		if [[ $- == *i* ]]; then 	
			fastfetch
		fi
	'';

	shellAliases = {
	   kun = "echo archon-kun with Abraxas-sama";
	};
     };


}
