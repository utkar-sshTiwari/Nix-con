{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    viAlias       = true;
    vimAlias      = true;

    plugins = with pkgs.vimPlugins; [

      # ── Colourscheme — config block runs after plugin is sourced ─────────────
      {
        plugin = tokyonight-nvim;
        type   = "lua";
        config = ''
          require("tokyonight").setup({
            style       = "night",
            transparent = true,
            styles = {
              comments  = { italic = true },
              keywords  = { italic = false },
              functions = { bold   = true },
            },
          })
          vim.cmd("colorscheme tokyonight-night")

          local hl = vim.api.nvim_set_hl

          hl(0, "Normal",       { bg = "NONE",    fg = "#e0e0e0" })
          hl(0, "NormalNC",     { bg = "NONE" })
          hl(0, "NormalFloat",  { bg = "#111116", fg = "#e0e0e0" })
          hl(0, "FloatBorder",  { bg = "#111116", fg = "#1e1e24" })
          hl(0, "SignColumn",   { bg = "NONE" })
          hl(0, "EndOfBuffer",  { fg = "#1a1a1f" })

          hl(0, "CursorLine",   { bg = "#111116" })
          hl(0, "CursorLineNr", { fg = "#22d4ff", bold = true })
          hl(0, "LineNr",       { fg = "#2e2e38" })

          hl(0, "Visual",       { bg = "#22253a" })
          hl(0, "Search",       { bg = "#cc55ff", fg = "#0d0d0f" })
          hl(0, "IncSearch",    { bg = "#22d4ff", fg = "#0d0d0f" })
          hl(0, "MatchParen",   { fg = "#ff3366", bold = true, underline = true })

          hl(0, "Comment",      { fg = "#2e2e38", italic = true })
          hl(0, "ErrorMsg",     { fg = "#ff3366" })
          hl(0, "WarningMsg",   { fg = "#ffcc00" })
          hl(0, "MoreMsg",      { fg = "#00e5a0" })

          hl(0, "WinSeparator", { fg = "#1e1e24" })
          hl(0, "VertSplit",    { fg = "#1e1e24" })
          hl(0, "StatusLine",   { bg = "#0d0d0f", fg = "#2e2e38" })
          hl(0, "StatusLineNC", { bg = "#0d0d0f", fg = "#1a1a1f" })

          hl(0, "TabLine",      { bg = "#0d0d0f", fg = "#2e2e38" })
          hl(0, "TabLineSel",   { bg = "#0d0d0f", fg = "#22d4ff", bold = true })
          hl(0, "TabLineFill",  { bg = "#0d0d0f" })

          hl(0, "Pmenu",        { bg = "#111116", fg = "#c0c0cc" })
          hl(0, "PmenuSel",     { bg = "#22253a", fg = "#22d4ff", bold = true })
          hl(0, "PmenuSbar",    { bg = "#1a1a1f" })
          hl(0, "PmenuThumb",   { bg = "#2e2e38" })
        '';
      }


    ];

    # extraLuaConfig runs last, after every plugin is in the runtimepath
    extraLuaConfig = ''
      local o = vim.opt

      -- true colour
      o.termguicolors  = true

      -- line numbers (hybrid mode)
      o.number         = true
      o.relativenumber = true

      -- cursor line
      o.cursorline     = true
      o.signcolumn     = "yes"

      -- no mode text
      o.showmode       = false



    '';
  };
}
