-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

local nvim_lsp = require("lspconfig")
nvim_lsp.denols.setup({
  -- on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
  single_file_support = false,
})

-- A wrapper of the TS extension from VSCode: https://github.com/yioneko/nvim-vtsls
-- There was an issue that was causing me a bit of a headache when setting up Deno projs in nvim until
-- I realized I was configuring tsserver, not vtsls. So after going through :LspInfo, we got it.
nvim_lsp.vtsls.setup({
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  single_file_support = false,
})

nvim_lsp.biome.setup({})

-- Use Biome if it exists else use other formatters
local web = function(bufnr)
  if require("conform").get_formatter_info("biome", bufnr).available then
    return { "biome", lsp_format = "never" }
  else
    return { "vtsls", "prettier" }
  end
end

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    typescript = web,
    javascript = web,
    javascriptreact = web,
    typescriptreact = web,
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    graphql = { "prettier" },
  },
})

local renderMarkdown = require("render-markdown")
renderMarkdown.setup({
  heading = {
    enabled = false,
  },
})

-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "basedpyright"

local telescope = require("telescope")
telescope.setup({ pickers = { find_files = { hidden = true } } })
