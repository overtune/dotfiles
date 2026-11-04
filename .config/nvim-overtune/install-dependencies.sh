#!/usr/bin/env bash
set -euo pipefail

# Node host provider for nvim (vim.g.loaded_node_provider).
# Not a language server — must live outside Mason.
npm i -g neovim

# System CLIs used by Telescope / general work.
brew install wget fd ripgrep

# Language servers, formatters, and linters are managed by Mason via
# mason-tool-installer.nvim (see lua/plugins/enabled/mason.lua).
# On first nvim launch they install automatically; or run :MasonToolsUpdate.
