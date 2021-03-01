require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  -- preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = false;
    buffer = false;
    calc = false;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = false;
    spell = false;
    tags = false;
    snippets_nvim = false;
    treesitter = false;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local opts = {
    silent = true,
    expr = true,
}
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', opts)
--[[
vim.api.nvim_set_keymap('i', '<C-e>', "compe#close('<C-e>')", opts)
vim.api.nvim_set_keymap('i', '<C-f>', "compe#scroll({ 'delta': +4 })", opts)
vim.api.nvim_set_keymap('i', '<C-d>', "compe#scroll({ 'delta': -4 })", opts)
]]--
function _G.confirm_completion()
    if vim.fn.pumvisible() == 0 then
        return t '<Plug>delimitMateCR'
    elseif vim.fn.complete_info()["selected"] ~= -1 then
        return vim.fn['compe#confirm']({ keys = t '<Plug>delimitMateCR', mode = '' })
    else
        return t '<C-e><Plug>delimitMateCR'
    end
end

vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.confirm_completion()', opts)
vim.api.nvim_set_keymap('i', '<C-y>', [[compe#confirm('<C-e>')]], opts)

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
