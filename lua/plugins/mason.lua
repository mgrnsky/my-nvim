return
{
	{
		"williamboman/mason.nvim",
		opts={}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "jdtls","clangd"}, -- 确保这些语言服务器已安装
            })
        end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")

            -- 配置 jdtls
            lspconfig.jdtls.setup({
                on_attach = function(client, bufnr)
                    -- 定义 LSP 的附加行为，例如按键映射
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
                end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(), -- 与 nvim-cmp 集成
            })

			--配置lua
			lspconfig.lua_ls.setup({
                on_attach = function(client, bufnr)
                    -- 定义 LSP 的附加行为，例如按键映射
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
                end,
			  settings = {
				Lua = {
				  runtime = {
					version = "LuaJIT", -- 使用 LuaJIT
				  },
				  diagnostics = {
					globals = { "vim" }, -- 忽略全局变量 vim 的警告
				  },
				  workspace = {
					library = vim.api.nvim_get_runtime_file("", true), -- 包含 Neovim 的运行时文件
					checkThirdParty = false, -- 不检查第三方库
				  },
				  telemetry = {
					enable = false, -- 禁用遥测
				  },
				},
			  },
				capabilities = require("cmp_nvim_lsp").default_capabilities(), -- 与 nvim-cmp 集成
			})

			--配置C/C++
			lspconfig.clangd.setup({
			  capabilities = require("cmp_nvim_lsp").default_capabilities(), -- 启用自动补全
			  cmd = { "clangd", "--background-index", "--clang-tidy" },     -- 启动参数
			  filetypes = { "c", "cpp", "objc", "objcpp" },                 -- 支持的文件类型
			  single_file_support = true,                                   -- 支持单个文件
			  root_dir = lspconfig.util.root_pattern("compile_commands.json", "CMakeLists.txt", ".git"), -- 项目根目录标志
			})


			-- 自定义错误和警告的图标
			local signs = {
			  Error = "", -- 错误图标
			  Warn = "", -- 警告图标
			  Hint = "󰴓", -- 提示图标
			  Info = "󰙎", -- 信息图标
			}

			for type, icon in pairs(signs) do
			  local hl = "DiagnosticSign" .. type
			  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- 配置诊断行为
			vim.diagnostic.config({
			  virtual_text = {
				prefix = " ◆", -- 虚拟文本的前缀
			  },
			  signs = true, -- 启用行号旁边的符号
			  underline = true, -- 启用下划线
			  update_in_insert = true, -- 在插入模式下不更新诊断
			  severity_sort = true, -- 按严重性排序
			})
        end,
    },
}
