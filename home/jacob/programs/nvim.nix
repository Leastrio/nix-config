{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    withRuby = false;
    withPython3 = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      lualine-nvim
      catppuccin-nvim
      which-key-nvim
      hop-nvim
      bufferline-nvim
      telescope-nvim
      nvim-treesitter.withAllGrammars
      nvim-cmp
      nvim-autopairs
      nvim-lspconfig
      cmp-nvim-lsp
      lspkind-nvim
      rainbow-delimiters-nvim
      nvim-web-devicons
      nvim-tree-lua
      gitsigns-nvim
      transparent-nvim

      # Required for telescope
      plenary-nvim

      (pkgs.callPackage ../../../packages/nest-nvim.nix {})
    ];
    extraConfig = ''
      lua <<
        vim.opt.expandtab = true
        vim.opt.incsearch = true
        vim.opt.mouse = "a"
        vim.opt.number = true
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.splitright = true
        vim.opt.relativenumber = true
        vim.opt.termguicolors = true
        vim.wo.wrap = false
        vim.opt.completeopt = "menu,menuone,noselect"
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        vim.g.mapleader = " "
        vim.g.python_recommended_style = 0
        vim.g.rust_recommended_style = 0
        vim.g.elixir_recommended_style = 0

        vim.cmd "syntax on"

        require("nvim-autopairs").setup {}
        require("nvim-tree").setup()
        require("gitsigns").setup()

        require("lualine").setup {
          options = {
            theme = "catppuccin-nvim",
            component_separators = "",
            section_separators = { left = "", right = "" },
          },
          sections = {
            lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
            lualine_b = { "filename", "branch", "diagnostics" },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { "filetype", "progress" },
            lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
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
        }

        require("catppuccin").setup({
          flavour = "mocha",
          transparent_background = true,
          integrations = {
            cmp = true,
            treesitter = true,
            hop = true,
            rainbow_delimiters = true,
            telescope = {
              enabled = true
            },
            which_key = true,
            nvimtree = true,
            gitsigns = true
          }
        })
        vim.cmd.colorscheme "catppuccin-nvim"

        require("which-key").setup()

        local transparent = require("transparent")
        transparent.clear_prefix("BufferLine")
        transparent.setup({
          extra_groups = {
            "NormalFloat",
          }
        })

        require("hop").setup()
        require("bufferline").setup()

        vim.api.nvim_create_autocmd('FileType', {
          pattern = '*',
          callback = function()
            local ok = pcall(vim.treesitter.start)
            if not ok then
              -- Parser not available for this filetype
            end
          end,
        })

        require("nest").applyKeymaps {
          {"<c-c>", [["+y]], mode = "v"},
          {"<c-b>", "<cmd>NvimTreeToggle<cr>"},
          {"<leader>", {
            {"h", "<cmd>HopWord<cr>"},
            {"c", "<cmd>bdelete!<cr>"},
            {"f", "<cmd>Telescope find_files<cr>"},
            {"g", "<cmd>Telescope live_grep<cr>"},
            {"qf", "<cmd>lua vim.lsp.buf.code_action()<cr>"}
          }},
          {"J", "<cmd>lua vim.diagnostic.open_float()<cr>"},
          {"K", "<cmd>lua vim.lsp.buf.hover()<cr>"}
        }

        local cmp = require("cmp")
        local lspkind = require("lspkind")
        cmp.setup {
          mapping = {
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-e>"] = cmp.mapping.close(),

            ["<Down>"] = cmp.mapping.select_next_item(),
            ["<Up>"] = cmp.mapping.select_prev_item(),

            ["<CR>"] = cmp.mapping(function(fallback)
              if cmp.visible() and cmp.get_selected_entry() then
                cmp.confirm({ select = false })
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.confirm({ select = true })
              else
                fallback()
              end
            end
          },
          formatting = {
            format = lspkind.cmp_format {
              with_text = false,
              maxwidth = 50,
              before = function(entry, vim_item)
                return vim_item
              end
            }
          },
          sources = cmp.config.sources {
            { name = "nvim_lsp" },
          },
          window = {
            completion = {
              max_height = 10,
              scrollbar = true,
            },
            documentation = {
              max_height = 8,
            },
          },
        }

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

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local servers = { "clangd", "gopls", "rust_analyzer", "gleam", "tailwindcss", "expert" }
        for _, server in ipairs(servers) do
          vim.lsp.config(server, {
            capabilities = capabilities
          })
          vim.lsp.enable(server)
        end
    '';
  };
}
