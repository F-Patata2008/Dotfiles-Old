#!/bin/bash

cd lua

mkdir -p core
mv vim-options.lua core/options.lua

mkdir -p core
mv plugins/keymaps.lua core/keymaps.lua

mkdir -p plugins
mv plugins/complete.lua plugins/cmp.lua

mkdir -p plugins
mv plugins/lsp-config.lua plugins/lsp.lua

mkdir -p plugins
mv plugins/none-ls.lua plugins/null-ls.lua

mkdir -p plugins
mv plugins/pairs.lua plugins/autopairs.lua

mkdir -p plugins
mv plugins/treessiter.lua plugins/treesitter.lua

mv custom/snippets snippets

