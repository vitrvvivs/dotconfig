local M = {}
M.opts = {}
vim.g.mapleader = '\\'

--------------------------------------------------------------------------------
-- Packages
--------------------------------------------------------------------------------
-- Install lazy.nvim (package manager)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Done.')
end
vim.opt.rtp:prepend(lazypath)

-- Install Packages
require('lazy').setup({
    -- Aesthetics
    {
        'freddiehaddad/base16-nvim',
        opts = {
            hot_reload = {
                enabled = true,
                base16_theme_file = "~/.config/tinted-theming/theme_name",
            },
        },
    },
    {
        'freddiehaddad/feline.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {'nvim-tree/nvim-web-devicons'},
    {'lewis6991/gitsigns.nvim'},
    -- Autocompletion
    {'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'onsails/lspkind.nvim'},
            {'L3MON4D3/LuaSnip'},
            -- Mason (autoinstall LSPs)
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'},
        }
    },
    { "folke/neodev.nvim", opts = {} },
    {'zbirenbaum/copilot-cmp',
        dependencies = {'zbirenbaum/copilot.lua'}
    },
    {'saadparwaiz1/cmp_luasnip',
        dependencies = {'L3MON4D3/LuaSnip',
            build = 'make install_jsregexp',
            dependencies = {'rafamadriz/friendly-snippets'},
        }
    },
    -- Languages
    {'towolf/vim-helm'},
    --Utilities
    {
        "nvim-telescope/telescope.nvim",
        branch = '0.1.x',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && ' ..
                        'cmake --build build --config Release && ' ..
                        'cmake --install build --prefix build',
            },
        },
    },
    {
        'folke/trouble.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
})

--------------------------------------------------------------------------------
-- Filetypes, Indentation
--------------------------------------------------------------------------------
vim.opt.number = true
vim.opt.foldmethod = "indent"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.fileencoding = "utf-8"
vim.opt.smartindent = true


vim.api.nvim_create_autocmd('FileType', {
    pattern = "html,htmldjango,css,json,yaml,javascript,hcl,markdown,helm",
    callback = function (_)
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = "sh,zsh,python,coffee,php,dockerfile,java,nginx",
    callback = function (_)
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = true
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = "go,terraform",
    callback = function (_)
        vim.opt_local.foldmethod = "syntax"
    end
})

--------------------------------------------------------------------------------
-- Utilities
--------------------------------------------------------------------------------
-- Save folds
vim.api.nvim_create_autocmd('BufWinLeave', {
    pattern = '*',
    callback = function ()
        vim.cmd('silent! mkview')
    end
})
vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*',
    callback = function ()
        vim.cmd('silent! loadview')
    end
})

--------------------------------------------------------------------------------
-- Aesthetics
--------------------------------------------------------------------------------
vim.opt.termguicolors = true

-- Icons
M.icons = {
    diagnostics = {
        Error = "",
        Warn = "",
        Hint = "",
        Info = "",
    },
    lsp = {
        virtual_text = "●",
    },
    git = {
        added = "",
        changed = "",
        removed = "",
    },
    dap = {
        DapBreakpoint = "",
        DapBreakpointCondition = "",
        DapLogPoint = "",
        DapStopped = "",
        DapBreakpointRejected = "",
    },
    tree = {
        collapsed = "",
        expanded = "",
    },
    kinds = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = " ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
    },
}

-- Colors
local update_theme = function()
    local theme = {
        fg = "#" .. vim.g.base16_gui05,
        bg = "#" .. vim.g.base16_gui00,
        base00 = "#" .. vim.g.base16_gui00, -- black
        base01 = "#" .. vim.g.base16_gui01,
        base02 = "#" .. vim.g.base16_gui02,
        base03 = "#" .. vim.g.base16_gui03,
        base04 = "#" .. vim.g.base16_gui04,
        base05 = "#" .. vim.g.base16_gui05, -- white
        base06 = "#" .. vim.g.base16_gui06,
        base07 = "#" .. vim.g.base16_gui07, -- bright white
        base08 = "#" .. vim.g.base16_gui08, -- red
        base09 = "#" .. vim.g.base16_gui09,
        base0A = "#" .. vim.g.base16_gui0A, -- yellow
        base0B = "#" .. vim.g.base16_gui0B, -- green
        base0C = "#" .. vim.g.base16_gui0C, -- cyan
        base0D = "#" .. vim.g.base16_gui0D, -- blue
        base0E = "#" .. vim.g.base16_gui0E, -- magenta
        base0F = "#" .. vim.g.base16_gui0F,
        black = "#" .. vim.g.base16_gui00,
        skyblue = "#" .. vim.g.base16_gui0D,
        cyan = "#" .. vim.g.base16_gui0C,
        green = "#" .. vim.g.base16_gui0B,
        oceanblue = "#" .. vim.g.base16_gui0D,
        magenta = "#" .. vim.g.base16_gui0E,
        orange = "#" .. vim.g.base16_gui0A,
        red = "#" .. vim.g.base16_gui08,
        violet = "#" .. vim.g.base16_gui0E,
        white = "#" .. vim.g.base16_gui05,
        yellow = "#" .. vim.g.base16_gui0A,
    }

    -- overwrite the base16-nvim theme
    vim.cmd("highlight Normal guibg=none")
    vim.cmd("highlight Folded guibg=none")
    vim.cmd("highlight SignColumn guibg=none")
    vim.cmd("highlight LineNr guibg=none")

    -- apply theme to feline statusbar
    require("feline").use_theme(theme)
end
require("base16-nvim").listen(update_theme)


-- Statusline
function M.git_diff(type)
    local gsd = vim.b.gitsigns_status_dict
    if gsd and gsd[type] and gsd[type] > 0 then return tostring(gsd[type]) end
    return nil
end

local separators = require("feline.defaults").statusline.separators.default_value
local git_bg = "base02"
local lsp_bg = "base02"
local file_bg = "base01"
local fc = { -- feline components
    lazy_status = {
        provider = function()
            if require("lazy.status").has_updates() then
                return " " .. require("lazy.status").updates() .. " "
            end
            return "  "
        end,
        hl = { fg = "base0A", bg = "base00" },
    },

    vi_mode_left = {
        provider = function() return " " .. require("feline.providers.vi_mode").get_vim_mode() .. " " end,
        hl = function() return { fg = "base00", bg = require("feline.providers.vi_mode").get_mode_color() } end,
        right_sep = {
            str = separators.right_filled,
            hl = function() return { bg = git_bg, fg = require("feline.providers.vi_mode").get_mode_color() } end,
        },
    },

    git_branch = {
        provider = function()
            local git = require("feline.providers.git")
            local branch, icon = git.git_branch()
            if #branch > 0 then return " " .. icon .. branch .. " " end
            return ""
        end,
        hl = { fg = "base04", bg = git_bg },
    },

    git_diff_added = {
        provider = function()
            local status = M.git_diff("added")
            if status then return " " .. M.icons.git.added .. status end
            return ""
        end,
        hl = { fg = "green", bg = git_bg },
    },

    git_diff_changed = {
        provider = function()
            local status = M.git_diff("changed")
            if status then return " " .. M.icons.git.changed .. status end
            return ""
        end,
        hl = { fg = "yellow", bg = git_bg },
    },

    git_diff_removed = {
        provider = function()
            local status = M.git_diff("removed")
            if status then return " " .. M.icons.git.removed .. status end
            return ""
        end,
        hl = { fg = "red", bg = git_bg },
    },

    git_sep = {
        provider = separators.right_filled,
        hl = { fg = git_bg, bg = file_bg },
        always_visible = true,
    },

    file_path = {
        provider = {
            name = "file_info",
            opts = { type = "relative" },
        },
        hl = function() return { fg = vim.bo.modified and "orange" or "green", bg = file_bg } end,
        left_sep = {
            str = " ",
            hl = { fg = "base04", bg = file_bg },
        }
    },

    --right
    file_type = {
        provider = {
            name = "file_type",
            opts = { case = "lowercase" },
        },
        hl = { fg = "base04", bg = file_bg },
        right_sep = {
            str = " ",
            hl = { fg = "base04", bg = file_bg },
        }
    },

    lsp_sep = {
        provider = separators.left_filled,
        hl = { fg = lsp_bg, bg = file_bg },
        always_visible = true,
    },

    lsp = {
        provider = function()
            local lsp = require("feline.providers.lsp")
            if lsp.is_lsp_attached() then return " " .. lsp.lsp_client_names() .. " " end
            return ""
        end,
        hl = { fg = "base04", bg = lsp_bg },
    },

    lsp_errors = {
        provider = function()
            local count = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
            if count > 0 then return M.icons.diagnostics.Error .. count .. " " end
            return ""
        end,
        hl = { fg = "red", bg = lsp_bg },
    },

    lsp_warnings = {
        provider = function()
            local count = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }))
            if count > 0 then return M.icons.diagnostics.Warn .. count .. " " end
            return ""
        end,
        hl = { fg = "yellow", bg = lsp_bg },
    },

    lsp_info = {
        provider = function()
            local count = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }))
            if count > 0 then return M.icons.diagnostics.Info .. count .. " " end
            return ""
        end,
        hl = { fg = "blue", bg = lsp_bg },
    },

    lsp_hints = {
        provider = function()
            local count = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }))
            if count > 0 then return M.icons.diagnostics.Hint .. count .. " " end
            return ""
        end,
        hl = { fg = "magenta", bg = lsp_bg },
    },

    vi_mode_right = {
        provider = function() return " " .. require("feline.providers.vi_mode").get_vim_mode() .. " " end,
        hl = function() return { fg = "base00", bg = require("feline.providers.vi_mode").get_mode_color() } end,
        left_sep = {
            str = separators.slant_right_2,
            hl = function() return { fg = "base01", bg = require("feline.providers.vi_mode").get_mode_color() } end,
        },
    },

    position = {
        provider = {
            name = "position",
            opts = { padding = false },
        },
        hl = { fg = "base00", bg = "base0A" },
        left_sep = {
            {
                str = separators.left_filled,
                hl = { fg = "base0A", bg = lsp_bg },
            },
            {
                str = " ",
                hl = { fg = lsp_bg, bg = "base0A" },
            }
        },
        right_sep = {
            str = " ",
            hl = { fg = "base00", bg = "base0A" },
        },
    },

    scroll_bar = {
        provider = {
            name = "scroll_bar",
            opts = { reverse = true },
        },
        hl = { fg = "base09", bg = "base0A" },
    },
}

M.opts.feline = {
    components = {
        active = {
            {
                fc.vi_mode_left,
                fc.git_diff_added,
                fc.git_diff_changed,
                fc.git_diff_removed,
                fc.git_branch,
                fc.git_sep,
                fc.file_path,
            },
            {
                fc.file_type,
                fc.lsp_sep,
                fc.lsp,
                fc.lsp_errors,
                fc.lsp_warnings,
                fc.lsp_info,
                fc.lsp_hints,
                fc.position,
                fc.scroll_bar,
            },
        }
    }
}


--------------------------------------------------------------------------------
-- Language Support, Autocomplete
--------------------------------------------------------------------------------
-- Setup LSP
local lsp = require('lsp-zero').preset({})

-- Install language servers and linters
local mason_packages = {
    -- BASH
    "bash-language-server",
    "shellcheck",
    "shfmt",

    -- Lua
    "stylua",
    "lua-language-server",

    -- Go
    "delve",
    "goimports",
    "gopls",

    -- JSON
    "json-lsp",
    "jq-lsp",

    -- Markdown
    --"marksman",
    --"markdownlint",

    -- Python
    "autopep8",
    "pyright",

    -- Terraform
    "terraform-ls",
    "tflint",

    -- YAML
    "yamlfmt",
    "yaml-language-server",

    -- javascript, typescript, css, json, markdown, yaml, ...
    --"prettierd",
}
local function install_mason_packaged()
    local mr = require("mason-registry")
    local function ensure_installed()
        for _, package_name in ipairs(mason_packages) do
            local p = mr.get_package(package_name)
            if not p:is_installed() then p:install() end
        end
    end

    if mr.refresh then
        mr.refresh(ensure_installed)
    else
        ensure_installed()
    end
end

-- disable yaml lsp for helm files
lsp.configure('yamlls', {
    on_attach = function(client, bufnr)
        if vim.bo.filetype == "helm" then
            vim.lsp.stop_client(bufnr, client.id)
        end
    end
})

-- fuzzy search
M.opts.telescope = {
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
        }
    }
}

-- detailed error pane
M.opts.trouble = {
    use_diagnostic_signs = true
}

-- copilot
M.opts.copilot = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
        helm = true,
        yaml = true,
    }
}

-- completion
M.opts.cmp = {
    sources = {
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
    },
    formatting = {
        fields = {'abbr', 'kind', 'menu'},
        format = require('lspkind').cmp_format({
            maxwidth = 50,
            ellipsis_char = '...',
        })
    },
}


--------------------------------------------------------------------------------
-- Keybinds
--------------------------------------------------------------------------------
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

vim.g.copilot_no_mappings = true
M.opts.cmp.mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
}

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({buffer = bufnr})

    vim.keymap.set('n', '#', '<cmd>lua vim.lsp.buf.definition()<cr>', {buffer = true})
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {buffer = true})
end)


-- Git line changes
M.opts.gitsigns = {
    on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
}

M.opts.telescope.defaults = {
    mappings = {
        i = {
            ["<c-t>"] = function(...) return require("trouble.providers.telescope").open_with_trouble(...) end,
            ["<a-t>"] = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<a-i>"] = function() M.telescope("find_files", { no_ignore = true })() end,
            ["<a-h>"] = function() M.telescope("find_files", { hidden = true })() end,
            ["<C-Down>"] = function(...) return require("telescope.actions").cycle_history_next(...) end,
            ["<C-Up>"] = function(...) return require("telescope.actions").cycle_history_prev(...) end,
            ["<C-f>"] = function(...) return require("telescope.actions").preview_scrolling_down(...) end,
            ["<C-b>"] = function(...) return require("telescope.actions").preview_scrolling_up(...) end,
        },
        n = {
            ["q"] = function(...) return require("telescope.actions").close(...) end,
            ["<C-p>"] = function() M.telescope("find_files", { no_ignore = true })() end,
        },
    },
}

local trouble = require('trouble')
M.opts.trouble.defaults = {
    mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
    },
}


--------------------------------------------------------------------------------
-- Call Setup
--------------------------------------------------------------------------------

require('feline').setup(M.opts.feline)
update_theme()

require('lsp-zero').setup()
require("luasnip.loaders.from_vscode").lazy_load()
require('mason').setup()
install_mason_packaged()
require('copilot').setup(M.opts.copilot)
require('copilot_cmp').setup()
require('cmp').setup(M.opts.cmp)

require('telescope').setup(M.opts.telescope)
require("telescope").load_extension("fzf")
require('gitsigns').setup(M.opts.gitsigns)
require('trouble').setup(M.opts.trouble)
