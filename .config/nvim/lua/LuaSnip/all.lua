local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  require("luasnip").snippet(
    { trig = "hi" },
    {
        t({"Hello, world!", "",}),
        i(1, {"<FIRST_NAME>",}),
        t({",", ""}),
        i(2, {"<LAST_NAME>"}),
        t({"", "goodbye!", "",}),
    }
  ),

  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  require("luasnip").snippet(
    { trig = "err" },
    { c(1, {
        t({"if e != nil {", "    return e", "}", ""}),
        t({"if err != nil {", "    return err", "}", ""}),
        t({"if err != nil {", "    return nil, err", "}", ""}),
    })}
  ),
}
