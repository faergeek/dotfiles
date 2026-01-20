---@type vim.lsp.Config
return {
  on_init = function(client)
    if not client.workspace_folders then return end

    local path = client.workspace_folders[1].name
    if
      path ~= vim.fn.stdpath 'config'
      and (
        vim.uv.fs_stat(path .. '/.luarc.json')
        or vim.uv.fs_stat(path .. '/.luarc.jsonc')
      )
    then
      return
    end

    local Lua = client.config.settings.Lua
    if type(Lua) ~= 'table' then return end

    client.config.settings.Lua = vim.tbl_deep_extend('force', Lua, {
      runtime = {
        path = { 'lua/?.lua', 'lua/?/init.lua' },
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    })
  end,
  settings = {
    Lua = {},
  },
}
