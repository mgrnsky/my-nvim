 -- nvim-cmp 插件
return {
        "hrsh7th/nvim-cmp",
		ft={"java","lua","c","cpp","h"},
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP 补全源
            "hrsh7th/cmp-buffer",    -- 缓冲区补全源
            "hrsh7th/cmp-path",      -- 路径补全源
            "hrsh7th/cmp-cmdline",   -- 命令行补全源
            "L3MON4D3/LuaSnip",      -- 代码片段引擎
            "saadparwaiz1/cmp_luasnip", -- LuaSnip 与 nvim-cmp 的集成
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- 使用 LuaSnip 展开代码片段
                    end,
                },
                mapping = {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- 触发补全
                    ["<C-e>"] = cmp.mapping.abort(),       -- 关闭补全
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 确认选择
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP 补全源
                    { name = "luasnip" },  -- LuaSnip 代码片段
                    { name = "buffer" },   -- 缓冲区补全源
                    { name = "path" },     -- 路径补全源
                }),
            })

            -- 命令行补全
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "cmdline" }, -- 命令行补全源
                }),
            })
        end,
    }
