{ config, pkgs, lib, ... }:

{
  programs.yazi = {
    enable                = true;
    enableBashIntegration = true;
  };

  # Writes directly to ~/.config/yazi/theme.toml
  # Keys verified against yazi 26.1.22 official docs
  xdg.configFile."yazi/theme.toml".text = ''
    "$schema" = "https://yazi-rs.github.io/schemas/theme.json"

    # ── App ──────────────────────────────────────────────────────────────────
    [app]
    overall = { bg = "#0d0d0f" }

    # ── Manager ───────────────────────────────────────────────────────────────
    [mgr]
    cwd            = { fg = "#00e5a0", bold = true }
    find_keyword   = { fg = "#ffcc00", bold = true, underline = true }
    find_position  = { fg = "#ff6e3a", bold = true }
    symlink_target = { fg = "#00e5e5", italic = true }

    marker_selected = { fg = "#ffcc00", bg = "#ffcc00" }
    marker_copied   = { fg = "#00e5a0", bg = "#00e5a0" }
    marker_cut      = { fg = "#ff3366", bg = "#ff3366" }
    marker_marked   = { fg = "#cc55ff", bg = "#cc55ff" }

    count_selected  = { fg = "#0d0d0f", bg = "#ffcc00", bold = true }
    count_copied    = { fg = "#0d0d0f", bg = "#00e5a0", bold = true }
    count_cut       = { fg = "#ffffff", bg = "#ff3366", bold = true }

    border_symbol   = "│"
    border_style    = { fg = "#1e1e24" }

    # ── Tabs ──────────────────────────────────────────────────────────────────
    [tabs]
    active   = { fg = "#0d0d0f", bg = "#cc55ff", bold = true }
    inactive = { fg = "#2e2e38", bg = "#0d0d0f" }
    sep_inner = { open = "", close = "" }
    sep_outer = { open = "", close = "" }

    # ── Mode pills (bottom left) ───────────────────────────────────────────────
    [mode]
    normal_main = { fg = "#0d0d0f", bg = "#ff3366",  bold = true }
    normal_alt  = { fg = "#ff3366", bg = "#1a0a0f" }
    select_main = { fg = "#0d0d0f", bg = "#ffcc00",  bold = true }
    select_alt  = { fg = "#ffcc00", bg = "#1a1500" }
    unset_main  = { fg = "#0d0d0f", bg = "#00e5a0",  bold = true }
    unset_alt   = { fg = "#00e5a0", bg = "#001a10" }

    # ── Status bar ────────────────────────────────────────────────────────────
    [status]
    overall   = { bg = "#0d0d0f", fg = "#c0c0cc" }
    sep_left  = { open = " ", close = " " }
    sep_right = { open = " ", close = " " }

    perm_type  = { fg = "#cc55ff", bold = true }
    perm_read  = { fg = "#22d4ff" }
    perm_write = { fg = "#ff3366" }
    perm_exec  = { fg = "#00e5a0", bold = true }
    perm_sep   = { fg = "#2e2e38" }

    progress_label  = { fg = "#ffffff", bold = true }
    progress_normal = { fg = "#00e5a0" }
    progress_error  = { fg = "#ff3366" }

    # ── Indicator bars (pane scrollbar) ───────────────────────────────────────
    [indicator]
    parent  = { fg = "#2e2e38" }
    current = { fg = "#cc55ff" }
    preview = { fg = "#2e2e38" }

    # ── Input bar ─────────────────────────────────────────────────────────────
    [input]
    border   = { fg = "#cc55ff" }
    title    = { fg = "#cc55ff", bold = true }
    value    = { fg = "#e0e0e0" }
    selected = { fg = "#ffffff", bg = "#22253a" }

    # ── Pick popup ────────────────────────────────────────────────────────────
    [pick]
    border   = { fg = "#1e1e24" }
    active   = { fg = "#ffcc00", bold = true }
    inactive = { fg = "#2e2e38" }

    # ── Completion popup ──────────────────────────────────────────────────────
    [cmp]
    border      = { fg = "#1e1e24" }
    active      = { fg = "#ffcc00", bg = "#111116", bold = true }
    inactive    = { fg = "#2e2e38" }
    icon_file   = ""
    icon_folder = ""
    icon_command = ""

    # ── Confirm dialog ────────────────────────────────────────────────────────
    [confirm]
    border  = { fg = "#cc55ff" }
    title   = { fg = "#cc55ff", bold = true }
    body    = { fg = "#e0e0e0" }
    list    = { fg = "#c0c0cc" }
    btn_yes = { fg = "#0d0d0f", bg = "#ff3366", bold = true }
    btn_no  = { fg = "#0d0d0f", bg = "#2e2e38" }
    btn_labels = ["  Yes  ", "  No  "]

    # ── Spot (file metadata popup) ────────────────────────────────────────────
    [spot]
    border   = { fg = "#1e1e24" }
    title    = { fg = "#cc55ff", bold = true }
    tbl_col  = { fg = "#22d4ff", bold = true }
    tbl_cell = { bg = "#111116" }

    # ── Tasks panel ───────────────────────────────────────────────────────────
    [tasks]
    border  = { fg = "#1e1e24" }
    title   = { fg = "#cc55ff", bold = true }
    hovered = { fg = "#ffcc00", underline = true }

    # ── Which-key popup ───────────────────────────────────────────────────────
    [which]
    mask            = { bg = "#0d0d0f" }
    cand            = { fg = "#ffcc00", bold = true }
    rest            = { fg = "#2e2e38" }
    desc            = { fg = "#c0c0cc" }
    separator       = "  │  "
    separator_style = { fg = "#1e1e24" }

    # ── Help overlay ──────────────────────────────────────────────────────────
    [help]
    on      = { fg = "#ffcc00", bold = true }
    run     = { fg = "#00e5a0" }
    desc    = { fg = "#c0c0cc" }
    hovered = { bg = "#111116", bold = true }
    footer  = { fg = "#2e2e38", bg = "#0d0d0f" }

    # ── Notify toasts ─────────────────────────────────────────────────────────
    [notify]
    title_info  = { fg = "#22d4ff" }
    title_warn  = { fg = "#ffcc00" }
    title_error = { fg = "#ff3366" }

    # ── File colours ──────────────────────────────────────────────────────────
    [filetype]
    rules = [
      # directories — gold, loud, unmissable
      { url = "*/",                                    fg = "#ffcc00", bold = true },

      # images / video / audio — violet
      { mime = "image/*",                              fg = "#cc55ff" },
      { mime = "{audio,video}/*",                      fg = "#cc55ff" },

      # archives — raspberry
      { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma}", fg = "#ff3366" },

      # executables — mint green bold
      { url = "*", is = "exec",                        fg = "#00e5a0", bold = true },

      # symlinks — teal
      { url = "*", is = "link",                        fg = "#00e5e5" },

      # orphan symlinks — red
      { url = "*", is = "orphan",                      fg = "#ff3366", underline = true },

      # dotfiles / hidden — dim
      { url = "*", is = "hidden",                      fg = "#2e2e38" },

      # fallback
      { url = "*",                                     fg = "#c0c0cc" },
    ]
  '';

}
