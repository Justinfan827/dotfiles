# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a customized Neovim configuration based on kickstart.nvim. It's a single-file Neovim configuration that serves as a starting point for development across multiple languages including Go, TypeScript/JavaScript, Python, and Lua.

## Architecture

### Core Structure
- `init.lua` - Main configuration file containing all plugin definitions and LSP setup
- `lua/custom/` - Custom configurations and plugins
  - `lua/custom/plugins/` - Custom plugin configurations organized by language/purpose
  - `lua/custom/mappings.lua` - Custom keybindings and quality-of-life improvements
  - `lua/custom/diagnostics.lua` - Custom diagnostic configurations
- `lua/kickstart/` - Kickstart.nvim base plugins
- `custom-snippets/` - Custom VSCode-style snippets for various languages

### Plugin Management
Uses Lazy.nvim as the plugin manager. All plugins are defined in `init.lua` with additional custom plugins loaded from `lua/custom/plugins/`.

### Language Support
- **Go**: Uses `gopls` LSP server, `ray-x/go.nvim` plugin, and custom formatting/import organization
- **TypeScript/JavaScript**: Uses `ts_ls` and `denols` (context-dependent), `biome` for formatting
- **Python**: Uses `pylsp` with custom settings
- **Lua**: Uses `lua_ls` with Neovim-specific configurations

## Common Development Commands

### Plugin Management
- `:Lazy` - View plugin status and manage plugins
- `:Lazy update` - Update all plugins
- `:Mason` - Manage LSP servers and tools

### LSP and Diagnostics
- `:checkhealth` - Check Neovim health and plugin status
- `:LspInfo` - View LSP server information for current buffer

### Language-Specific Tools
- Go files automatically organize imports on save via LSP
- Conform.nvim handles formatting on save for most file types
- Custom snippets available for Go, Lua, and general use

## Key Customizations

### Custom Keybindings (from `lua/custom/mappings.lua`)
- `kj` - Exit insert mode
- `,w` - Quick save
- `ss` / `sv` - Split windows horizontally/vertically
- `-` - Open Oil file explorer in floating window
- Various Git operations with `<leader>g` prefix
- Language-specific shortcuts (e.g., `fpp` for Go `fmt.Println()`)

### Development Workflow Features
- **Harpoon** for quick file navigation
- **Telescope** for fuzzy finding with FZF integration
- **Trouble.nvim** for diagnostics and LSP reference management
- **Oil.nvim** as file manager
- **Auto-session** capabilities (currently commented out)
- **No-neck-pain** for centered editing experience

### Formatting and Linting
- Uses Conform.nvim for formatting with language-specific formatters:
  - Go: `gopls`
  - TypeScript/JavaScript: `biome-check`
  - Python: `yapf`
  - Lua: `stylua`
  - Markdown: `prettierd`

### Theme and UI
- Uses `gruvbox-material` colorscheme with transparent background
- Mini.nvim statusline with custom configuration
- Barbecue winbar for VSCode-like breadcrumbs
- Alpha.nvim start screen

## Language-Specific Notes

### Go Development
- Automatic import organization on save
- Custom keybindings for `fmt.Println()` variations
- Uses `ray-x/go.nvim` for enhanced Go tooling
- Treesitter highlighting explicitly enabled for Go files

### TypeScript/JavaScript
- Supports both Node.js projects (ts_ls) and Deno projects (denols) based on configuration files
- Custom console.log shortcuts and JSON.stringify helpers
- Biome for formatting and linting

### Python
- Uses pylsp with custom settings (ignoring W391, 100 char line length)
- YAPF for formatting

This configuration is designed for cross-platform development with a focus on Go and web technologies while maintaining the educational and readable nature of kickstart.nvim.