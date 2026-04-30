local nvim_treesitter = require 'nvim-treesitter'
nvim_treesitter.install { 'diff', 'jsdoc', 'luadoc', 'luap', 'regex' }

local languages = {}
vim.list_extend(languages, nvim_treesitter.get_available(1))
vim.list_extend(languages, nvim_treesitter.get_available(2))

local filetypes = {}
for _, language in ipairs(languages) do
  vim.list_extend(filetypes, vim.treesitter.language.get_filetypes(language))
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function(event)
    local language = vim.treesitter.language.get_lang(event.match)
    if not language then return end

    local function start()
      vim.treesitter.start(event.buf)

      if #vim.treesitter.query.get_files(language, 'folds') ~= 0 then
        for _, winid in ipairs(vim.fn.win_findbuf(event.buf)) do
          vim.wo[winid][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
      end

      if #vim.treesitter.query.get_files(language, 'indents') ~= 0 then
        vim.bo[event.buf].indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    if vim.tbl_contains(nvim_treesitter.get_installed 'parsers', language) then
      start()
    else
      nvim_treesitter.install(language):await(start)
    end
  end,
})

require('treesitter-context').setup {
  max_lines = 8,
  min_window_height = 20,
  mode = 'topline',
}
