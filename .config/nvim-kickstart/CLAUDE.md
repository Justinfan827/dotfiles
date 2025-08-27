# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a customized Neovim configuration based on kickstart.nvim, evolved into a highly modular and organized setup. It supports cross-platform development with primary focus on Go, TypeScript/JavaScript, Python, and Lua.

## Architecture

### Core Structure

- `init.lua` - Main entry point that requires all jfan modules
- `lua/jfan/` - Core configuration modules (options, keymaps, autocmds, diagnostics, health)
- `lua/plugins/` - Modular plugin system where each plugin has its own file
- `lua/plugins/registry.lua` - Central plugin registry using require statements

### Plugin Management Philosophy

Uses a "require-based" approach where:

- Each complex plugin has its own dedicated file in `lua/plugins/`
- Each plugin file returns a complete plugin specification table
- `registry.lua` imports all plugins via require statements
- Simple plugins with minimal config remain inline in registry.lua
- Language-specific configurations are in separate modules (`webdev.lua`, `golang.lua`)

### Language Support Architecture

- **Go**: Uses `gopls` LSP, `ray-x/go.nvim`, automatic import organization on save
- **TypeScript/JavaScript**: Dual LSP setup - `ts_ls` for Node.js projects, `denols` for Deno projects
- **Python**: Uses `pylsp` with custom settings and `yapf` formatting
- **Lua**: Uses `lua_ls` with Neovim-specific configurations and `stylua` formatting

## Common Development Commands

### Plugin Management

- `:Lazy` - View and manage plugins
- `:Lazy update` - Update all plugins
- `:Mason` - Manage LSP servers, formatters, and linters

### Health Checks

- `:checkhealth` - Check Neovim and plugin health
- `:checkhealth jfan` - Custom health check for this configuration
- `:LspInfo` - View LSP server status for current buffer

### Configuration Debugging

- `:Noice history` - View all recent messages with their event types and kinds
- `:Telescope find_files cwd=~/.config/nvim-kickstart` - Search configuration files

### Development Workflow

- Use Harpoon (`<leader>a` to add, `<C-e>` to toggle menu) for quick file navigation
- Oil file manager opens with `-` key in floating window
- Trouble.nvim provides unified interface for diagnostics and LSP navigation

## Key Customizations

### Modular Plugin System

Each plugin in `lua/plugins/` follows this pattern:

```lua
return {
  'plugin/name',
  dependencies = { ... },
  opts = { ... },
  config = function() ... end,
}
```

### Language-specific Integrations

- Go files automatically organize imports on save via LSP
- Custom keybindings for quick logging in Go (`fpp`, `fpq`) and JS/TS (`cll`, `clj`)
- TypeScript/JavaScript projects use Biome for formatting and linting
- Context-aware LSP server selection (ts_ls vs denols based on project files)

### UI and UX Enhancements

- Noice.nvim provides enhanced UI for messages, notifications, and cmdline
- Gruvbox Material theme with transparent background
- Global statusline configuration for better plugin compatibility
- Custom diagnostic configurations with modern sign column styling

### Development Tools Integration

- FZF integration for fuzzy searching (`fzf.vim` and native telescope-fzf)
- Git integration via fugitive, gitsigns, and vim-gh-line for GitHub linking
- Debug adapter protocol support via `nvim-dap`
- Formatting on save via Conform.nvim with language-specific formatters

## File Organization Patterns

### Core Configuration Modules

- `lua/jfan/options.lua` - All vim options organized by category
- `lua/jfan/autocmd.lua` - Autocommands for editor behavior and file-specific actions
- `lua/jfan/keymaps.lua` - Global keybindings
- `lua/jfan/diagnostics.lua` - LSP diagnostic configuration

### Plugin File Structure

- One plugin per file for complex configurations (>10 lines)
- Plugin files return complete lazy.nvim specifications
- Simple plugins remain in `registry.lua` for easy management
- Language-specific plugin groupings in dedicated files

### Custom Configurations

- Custom health checker in `lua/jfan/health.lua` verifies setup requirements
- Silent Go import organization on save using modern LSP APIs
- Noice routes configured to suppress common noise (search counts, empty messages)

## External Dependencies

### Required Tools

- `git`, `make`, `unzip`, `rg` (ripgrep), `fzf`, `ag` (the_silver_searcher)
- Language-specific: `gopls`, `node`/`npm`, `python3`, `lua-language-server`
- Formatters: `stylua`, `yapf`, `biome`, `prettierd`

### Optional but Recommended

- Nerd Font for proper icon display (configured via `vim.g.have_nerd_font = true`)
- System clipboard integration for cross-application copy/paste

