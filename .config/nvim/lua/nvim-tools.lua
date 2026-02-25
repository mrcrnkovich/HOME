local doc    = require "nvim-tools.docs"
local test   = require "nvim-tools.testing"
local snips  = require "nvim-tools.snippets"

local M = {}

function M.Setup()
  doc.Setup()
  test.Setup()
end

return M
