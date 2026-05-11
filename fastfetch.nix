{ config, pkgs, lib, ... }:

{
  # ─── Fastfetch ───────────────────────────────────────────────────────────────
  programs.fastfetch = {
    enable = true;

    settings = {

      # ── Logo ────────────────────────────────────────────────────────────────
      logo = {
        source  = "linux";          # built-in Tux penguin
      #  color = {
      #    "1" = "38;2;34;212;255";  # electric sky   #22d4ff
      #    "2" = "38;2;204;85;255";  # vivid violet   #cc55ff
      #  };
        padding = {
          top   = 1;
          left  = 1;
          right = 2;
        };
      };

      # ── Display / key-value separator ───────────────────────────────────────
      display = {
        separator     = " │ ";          # pipe separator — matches waybar style
        color = {
          # key colour  → electric sky  (matches network segment in waybar)
          keys   = "38;2;34;212;255";
          # separator   → near-invisible dark line
          separator = "38;2;30;30;36";
          # title colour → vivid violet (matches audio segment in waybar)
          title  = "38;2;204;85;255";
        };
       # keyWidth      = 14;
        bar = {
          char.Elapsed = "━";
          char.Total   = "─";
          border.Left  = "";
          border.Right = "";
          width       = 12;
        };
      };

      # ── Modules (ordered top to bottom) ─────────────────────────────────────
      modules = [

        # ── Header: user@host ─────────────────────────────────────────────────
        {
          type       = "title";
          color = {
            user   = "38;2;34;212;255";   # electric sky
            at     = "38;2;30;30;36";     # invisible @
            host   = "38;2;204;85;255";   # vivid violet
          };
          fqdn       = false;
        }

        # thin divider
        { type = "separator"; string = "────────────────────────────"; }

        # ── System ────────────────────────────────────────────────────────────
        { type = "os";       key = "OS"; }
        { type = "kernel";   key = "Kernel"; }
        { type = "uptime";   key = "Uptime"; }
        {
          type = "packages";
          key  = "Packages";
          # show nix-system and nix-user counts
          separate = true;
        }
        { type = "shell"; key = "Shell"; showVersion = true; }

        #{ type = "separator"; string = "━━──────────────────────────"; } 

        # ── Desktop ───────────────────────────────────────────────────────────
       # {
       #   type  = "wm";
       #   key   = "WM";
          # colour the value itself — vivid violet
       #    keyColor = "38;2;204;85;255";
       # }
        {
          type  = "terminal";
          key   = "Terminal";
          keyColor = "38;2;34;212;255";   # electric sky
        }
        { type = "terminalfont"; key = "Font"; }
        #{ type = "cursor";       key = "Cursor"; }
        #{ type = "icons";        key = "Icons"; }
        #{ type = "theme";        key = "Theme"; }

        #{ type = "separator"; string = ""; }

        # ── Hardware ──────────────────────────────────────────────────────────
        {
          type         = "cpu";
          key          = "CPU";
          keyColor     = "38;2;255;110;58";   # hot ember — matches temperature in waybar
          showPeCoreCount = true;
          temp         = true;
          tempColor    = "38;2;255;110;58";
        }
        {
          type     = "gpu";
          key      = "GPU";
          keyColor = "38;2;255;110;58";
          temp     = true;
        }
        {
          type     = "memory";
          key      = "Memory";
          keyColor = "38;2;0;229;160";   # electric mint — matches memory in waybar
        }
        {
          type   = "swap";
          key    = "Swap";
        }
        {
          type   = "disk";
          key    = "Disk (/)";
          folders = "/";
        }

        #{ type = "separator"; string = ""; }

        # ── Network / power ───────────────────────────────────────────────────
        {
          type     = "localip";
          key      = "Local IP";
          keyColor = "38;2;34;212;255";   # electric sky — matches wifi in waybar
          ipv6     = false;
          showLoop = false;
        }
        {
          type  = "wifi";
          key   = "Wi-Fi";
        }
        {
          type          = "battery";
          key           = "Battery";
          keyColor      = "38;2;0;229;160";
          temperatureColor = "38;2;255;110;58";
        }
        {
          type = "brightness";
          key  = "Brightness";
        }

        #{ type = "separator"; string = ""; }

        # ── Colour palette swatches (bottom strip) ────────────────────────────
        { type = "colors"; paddingLeft = 1; symbol = "circle"; }
      ];
    };
  };
}
