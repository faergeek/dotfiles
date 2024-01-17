local autocmd = require('utils').autocmd

local spell_dir = vim.fn.stdpath 'config' .. '/spell'

vim.cmd('silent mkspell! ' .. spell_dir .. '/words.add')

local function ensure_spellfile(fname)
  local fpath = spell_dir .. '/' .. fname

  if not vim.loop.fs_stat(fpath) then
    vim.notify('Downloading ' .. fname .. '...', vim.log.levels.INFO)

    vim.fn.system {
      'curl',
      '--silent',
      '--output',
      spell_dir .. '/' .. fname,
      'https://ftp.nluug.nl/pub/vim/runtime/spell/' .. fname,
    }

    if vim.v.shell_error == 0 then
      vim.notify('Done', vim.log.levels.INFO)
    else
      vim.notify('Failed to download ' .. fname, vim.log.levels.ERROR)
    end
  end
end

---@param file string
---@param encoding string
---@param ext string
local function spell_fname(file, encoding, ext)
  return table.concat({ file, encoding, ext }, '.')
end

autocmd('Download missing spellfiles', 'SpellFileMissing', function(event)
  local file = event.match
  local encoding = vim.opt.encoding:get()

  local spl_fname = spell_fname(file, encoding, 'spl')
  local sug_fname = spell_fname(file, encoding, 'sug')

  ensure_spellfile(spl_fname)
  ensure_spellfile(sug_fname)
end)
