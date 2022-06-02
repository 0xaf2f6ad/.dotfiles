local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),

		on_attach = function(client, _)
			Nnoremap("<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
			Nnoremap("<leader>gtd", ":lua vim.lsp.buf.type_definition()<CR>")
			Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
			Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
			Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
			Nnoremap("[d", ":lua vim.diagnostic.goto_next()<CR>")
			Nnoremap("]d", ":lua vim.diagnostic.goto_prev()<CR>")
			Nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
			Nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
			Nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
			Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

			capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- these use null-ls for formatting
			if has_value({
				"tsserver",
				"rust_analyzer",
				"sumneko_lua",
				"html",
			}, client.name) then
				client.resolved_capabilities.document_formatting = false
			end

			if client.resolved_capabilities.document_formatting then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
			end
		end,
	}, _config or {})
end

-- Dart

require("lspconfig").dartls.setup(config())
require("flutter-tools").setup(config())

-- python

require("lspconfig").pyright.setup(config())

require("lspconfig").jedi_language_server.setup(config())

-- JS/TS

require("lspconfig").tsserver.setup(config())

local nls = require("null-ls")
local nlsb = require("null-ls").builtins

nls.setup(config({
	sources = {
		-- lua
		nlsb.formatting.stylua,
		-- js/ts
		nlsb.formatting.prettier_d_slim,
		--nlsb.diagnostics.eslint,
		nlsb.diagnostics.tsc,
		-- rust
		nlsb.formatting.rustfmt,
		--dart
		--nlsb.formatting.dart_format,
	},
}))

require("lspconfig").svelte.setup(config())

-- GoLang

require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))

-- Lua

require("lspconfig").sumneko_lua.setup(config({
	-- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
}))

-- who even uses this?

require("lspconfig").rust_analyzer.setup(config({
	-- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "self",
				unimportedPackages = "off",
			},
			cargo = {
				loadOurDirsFromCheck = true,
			},
			procMacro = {
				enable = true,
			},
		},
	},
}))

-- c/c++

require("lspconfig").ccls.setup(config())

-- html/css ls

require("lspconfig").html.setup(config())
require("lspconfig").cssls.setup(config())
require("lspconfig").cssmodules_ls.setup(config())

-- ansible ls

require("lspconfig").ansiblels.setup(config())

-- other LSs

require("lspconfig").solang.setup(config())
