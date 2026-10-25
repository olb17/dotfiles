# Neovim `olb.lua` Plugin Split Design

## Intent
Make the custom Neovim plugin configuration easier to navigate without changing editor or plugin behavior.

## Goals
- Put every enabled plugin spec currently in `lua/custom/plugins/olb.lua` in its own clearly named file.
- Put the file's non-plugin setup in the existing `lua/config/` modules.
- Keep Lazy's existing `custom.plugins` import mechanism.

## Non-goals
- Change plugin settings, lazy-loading conditions, mappings, dependencies, or enabled plugins.
- Activate or preserve the commented-out plugin experiments.

## Constraints
- Preserve the current behavior exactly.
- Remove the now-redundant `olb.lua` file.

## Approaches
1. One file per plugin: maximizes discoverability and follows Lazy's directory import support.
2. Thematic plugin files: reduces file count but still groups unrelated specifications.
3. An aggregator with separate modules: adds indirection without a benefit for these independent specs.

The selected approach is one file per plugin.

## Design
Create one spec file for Noice, MJML Preview, Emmet, Live Server, Auto Cursorline, Treesitter Textobjects, Herdr Splits, and Indent Blankline. Move window options to `config/options.lua`, global mappings to `config/keymaps.lua`, snippet loading to a focused `config/snippets.lua` module loaded by `init.lua`, and the MJML filetype registration to `config/autocmds.lua`.
