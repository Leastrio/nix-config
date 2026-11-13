vim.o.winborder = "rounded"

vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python_recommended_style = 0
vim.g.rust_recommended_style = 0
vim.g.elixir_recommended_style = 0

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.wrap = false

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  custom_highlights = {
    CursorLine = { bg = "NONE" }
  },
  float = {
    transparent = true,
  },
  integrations = {
    treesitter = true,
    flash = true,
    rainbow_delimiters = true,
    telescope = {
      enabled = true,
    },
    which_key = true,
    nvimtree = true,
    mini = {
      enabled = true,
    },
    fidget = true,
    indent_blankline = { enabled = true }
  },
})
vim.cmd.colorscheme("catppuccin-nvim")

require("lualine").setup({
  options = {
    theme = "catppuccin-nvim",
    component_separators = "",
    section_separators = { left = "\238\130\180", right = "\238\130\182" },
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "\238\130\182" }, right_padding = 2 } },
    lualine_b = { "filename", "branch", "diagnostics" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "filetype", "progress" },
    lualine_z = { { "location", separator = { right = "\238\130\180" }, left_padding = 2 } },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
})

require("bufferline").setup({
  highlights = require("catppuccin.special.bufferline").get_theme(),
})

require("which-key").setup()
require("nvim-autopairs").setup({})
require("nvim-tree").setup()
require("flash").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("ibl").setup({
  scope = { enabled = false }
})
require("todo-comments").setup()
require("fidget").setup({
  notification = {
    window = { winblend = 0 },
  },
})

local telescope = require("telescope")
telescope.setup()
telescope.load_extension("fzf")

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

local map = vim.keymap.set

map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
map("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })

map("n", "<leader>h", function()
  require("flash").jump()
end, { desc = "Jump (flash)" })
map("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Grep in project" })
map("n", "<leader>T", "<cmd>TodoTelescope<cr>", { desc = "List TODOs" })
map("n", "<leader>qf", vim.lsp.buf.code_action, { desc = "Code action" })

map("n", "<leader>tf", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
end, { desc = "Toggle format on save" })

map("n", "J", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    documentation = {
      auto_show = true,
      window = { max_height = 8 },
    },
  },
  signature = { enabled = true },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})

require("conform").setup({
  formatters_by_ft = {
    nix = { "alejandra" },
  },
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = function()
    if vim.g.disable_autoformat then
      return
    end
    return { timeout_ms = 1000 }
  end,
})

-- for some reason tailwind lsp runs on any folder with a .git repo
vim.lsp.config("tailwindcss", {
  root_dir = function(bufnr, on_dir)
    local util = require("lspconfig.util")
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local markers = {
      "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts",
      "postcss.config.js", "postcss.config.cjs", "postcss.config.mjs", "postcss.config.ts",
    }
    markers = util.insert_package_json(markers, "tailwindcss", fname)
    markers = util.root_markers_with_field(markers, { "mix.lock", "Gemfile.lock" }, "tailwind", fname)
    local found = vim.fs.find(markers, { path = fname, upward = true })[1]
    if found then
      on_dir(vim.fs.dirname(found))
    end
  end,
})

vim.lsp.config("nixd", {
  settings = {
    nixd = {
      formatting = {
        command = { "alejandra" },
      },
    },
  },
})

vim.lsp.enable({ "clangd", "gopls", "rust_analyzer", "gleam", "tailwindcss", "expert", "nixd" })
