-- Perl LSP
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'perl',
--     callback = function(arg)
--         vim.lsp.start({
--             name = "perl-navigator",
--             cmd = {"node", os.getenv("HOME").."/.local/share/PerlNavigator/server/out/server.js", "--stdio" },
--             root_dir = vim.fs.root(arg.buf, {'cpanfile'}),
--         })
--     end,
-- })

return {
  name = "perl-navigator",
  filetypes = { "perl" },
  cmd = {"node", os.getenv("HOME").."/.local/share/PerlNavigator/server/out/server.js", "--stdio" },
  root_markers = {'cpanfile'},
}
