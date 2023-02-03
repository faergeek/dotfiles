local keymap = require('faergeek.utils').keymap
local ls = require 'luasnip'

ls.config.set_config {
  history = true,
}

keymap('LuaSnip: Expand snippet', { 'i', 's' }, '<C-y>', function()
  if ls.expandable() then
    ls.expand {}
  end
end)

keymap('LuaSnip: Jump forward', { 'i', 's' }, '<C-f>', function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end)

keymap('LuaSnip: Jump backward', { 'i', 's' }, '<C-b>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

keymap('LuaSnip: Choise forward', 'i', '<C-n>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

keymap('LuaSnip: Choise backward', 'i', '<C-p>', function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)
