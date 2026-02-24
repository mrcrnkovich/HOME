-- This started off as a port of
-- the Base16 package, Tomorrow-Night
-- https://github.com/chriskempson/tomorrow-theme/blob/master/vim/colors/Tomorrow-Night.vim
function Base16_Colorscheme(settings)
    vim.g.colors_name = "tomorrow"

    -- Going down a rabbit hole of syntax highlighting
    local highlight = function(name, val)
        -- where 0 is the global setting for all buffers
        -- https://neovim.io/doc/user/api.html#nvim_set_hl()
        vim.api.nvim_set_hl(0, name, val)
    end

	-- Vim Highlighting
  -- If you want to set the background to transparent use bg=none for "Normal"
  -- and "NonText" otherwise use settings.background
  if settings.transparent then
      highlight("Normal",       { fg=settings.foreground, bg=none })
      highlight("NonText",      { fg=settings.selection,  bg=none }) 
  else
      highlight("Normal",       { fg=settings.foreground, bg=settings.background })
      highlight("NonText",      { fg=settings.selection,  bg=settings.background }) 
  end
	highlight("LineNr",       { fg=settings.selection }) 
	highlight("SpecialKey",   { fg=settings.selection }) 
	highlight("Search",       { fg=settings.background, bg=settings.yellow })
	highlight("TabLine",      { fg=settings.window, bg=settings.foreground, reverse=true })
	highlight("TabLineFill",  { fg=settings.window, bg=settings.foreground, reverse=true })
	highlight("StatusLine",   { fg=settings.window, bg=settings.yellow,     reverse=true })
	highlight("StatusLineNC", { fg=settings.window, bg=settings.foreground, reverse=true })
	highlight("VertSplit",    { fg=settings.window, bg=settings.window })
	highlight("Visual",       { bg=settings.selection })
	highlight("Directory",    { fg=settings.blue  })
	highlight("ModeMsg",      { fg=settings.green })
	highlight("MoreMsg",      { fg=settings.green })
	highlight("Question",     { fg=settings.green })
	highlight("WarningMsg",   { fg=settings.red   })
	highlight("MatchParen",   { bg=settings.selection })
	highlight("Folded",       { fg=settings.comment, bg=settings.background })
	highlight("FoldColumn",   { bg=settings.background  })
  highlight("CursorLine",   { bg=settings.line })
  highlight("CursorColumn", { bg=settings.line })
  highlight("PMenu",        { fg=settings.foreground, bg=settings.selection })
  highlight("PMenuSel",     { fg=settings.foreground, bg=settings.selection, reverse=true })
  highlight("SignColumn",   { bg=settings.background })
  highlight("ColorColumn",  { bg=settings.line })
  highlight("vimCommand",   { fg=settings.red })

    -- Standard Highlighting
 	highlight("Comment",     { fg=settings.comment })
	highlight("Todo",        { fg=settings.foreground, bg=settings.background, bold=true })
	highlight("Title",       { fg=settings.comment })
	highlight("Identifier",  { fg=settings.red })
	highlight("Statement",   { fg=settings.foreground })
	highlight("Conditional", { fg=settings.foreground })
	highlight("Repeat",      { fg=settings.foreground })
	highlight("Structure",   { fg=settings.purple })
	highlight("Function",    { fg=settings.blue   })
	highlight("Constant",    { fg=settings.orange })
	highlight("Keyword",     { fg=settings.orange })
	highlight("String",      { fg=settings.green })
	highlight("Special",     { fg=settings.foreground })
	highlight("PreProc",     { fg=settings.purple })
	highlight("Operator",    { fg=settings.aqua })
	highlight("Type",        { fg=settings.blue })
	highlight("Define",      { fg=settings.purple })
	highlight("Include",     { fg=settings.blue })
	highlight("DiagnosticError", { bg=settings.window, fg=settings.red, bold=true })

    -- C Highlighting
  highlight("cType",         { fg=settings.yellow })
	highlight("cStorageClass", { fg=settings.purple })
	highlight("cConditional",  { fg=settings.purple })
	highlight("cRepeat",       { fg=settings.purple })

	-- Go Highlighting
	highlight("goDirective",   { fg=settings.purple })
	highlight("goDeclaration", { fg=settings.purple })
	highlight("goStatement",   { fg=settings.purple, italic=true })
	highlight("goConditional", { fg=settings.purple })
	highlight("goConstants",   { fg=settings.orange })
	highlight("goTodo",        { fg=settings.yellow, bold=true })
	highlight("goDeclType",    { fg=settings.blue   })
	highlight("goBuiltins",    { fg=settings.purple })
	highlight("goRepeat",      { fg=settings.purple })
	highlight("goLabel",       { fg=settings.purple })

	-- Lua Highlighting
   	highlight("luaStatement",  { fg=settings.purple })
   	highlight("luaRepeat",     { fg=settings.purple })
   	highlight("luaCondStart",  { fg=settings.purple })
   	highlight("luaCondElseif", { fg=settings.purple })
   	highlight("luaCond",       { fg=settings.purple })
   	highlight("luaCondEnd",    { fg=settings.purple })

    -- Perl Highlighting
	highlight("perlStatement",   { fg=settings.purple })
	highlight("perlConditional", { fg=settings.purple })
	highlight("perlTodo",        { fg=settings.yellow, bold=true })
end

local dark_mode = {
    foreground = "#cccccc",
    background = "#2d2d2d",
    selection  = "#515151",
    line       = "#393939",
    comment    = "#999999",
    red        = "#f2777a",
    orange     = "#f99157",
    yellow     = "#ffcc66",
    green      = "#99cc99",
    aqua       = "#66cccc",
    blue       = "#6699cc",
    purple     = "#cc99cc",
    window     = "#4d5057",
    transparent = false,
}

local light_mode = {
    foreground = "#4d4d4c",
    background = "#ffffff",
    selection = "#d6d6d6",
    line = "#efefef",
    comment = "#8e908c",
    red = "#c82829",
    orange = "#f5871f",
    yellow = "#eab700",
    green = "#718c00",
    aqua = "#3e999f",
    blue = "#4271ae",
    purple = "#8959a8",
    window = "#efefef",
    transparent = false,
}

vim.opt.background = 'light'
Base16_Colorscheme(light_mode)
