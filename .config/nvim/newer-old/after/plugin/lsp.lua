local lsp = require('lsp-zero').preset({
	manage_nvim_cmp = {
    		set_sources = 'recommended',
		set_basic_mappings = true,
		set_extra_mappings = true,
		use_luasnip = true,
		set_format = true,
		documentation_window = true,
  	}
})
---local cmp = require('cmp')
---local cmp_action = require('lsp-zero').cmp_action()

---cmp.setup({
	---mapping = {
	---	['<Tab>'] = cmp_action.luasnip_supertab(),
	---	['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
---	}
---})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.setup()
vim.diagnostic.config({
    virtual_text = true,
})
