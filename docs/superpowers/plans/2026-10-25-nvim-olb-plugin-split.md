# Neovim `olb.lua` Plugin Split Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Split the custom plugin and editor setup in `olb.lua` into focused Neovim configuration files with unchanged behavior.

**Architecture:** Lazy.nvim already imports all modules beneath `lua/custom/plugins`, so each plugin table will become an independently returned module there. Editor-wide settings and mappings will live in the established `config` modules; snippet loading gets a dedicated module required by `init.lua`.

**Tech Stack:** Lua, Neovim, lazy.nvim

**Spec:** `docs/superpowers/specs/2026-10-25-nvim-olb-plugin-split-design.md`

## Global Constraints

- Preserve all enabled plugin settings, lazy-loading conditions, dependencies, mappings, and behavior.
- Do not activate the commented-out plugin experiments.
- Delete `lua/custom/plugins/olb.lua`.

## Review Focus

- Headless Lua compilation must succeed for every created configuration module.
- Lazy import discovery must receive a plugin-spec table from every plugin file.
- Global mappings (`<leader>y`, `<leader>go`, `<leader>gt`, `J`) must remain defined during startup.
- Herdr splits must remain gated by `HERDR_ENV == "1"`.
- MJML filetype detection and LuaSnip loading must remain startup configuration, not plugin specs.

---

### Task 1: Extract editor-wide startup configuration

**Files:**
- Modify: `nvim/.config/nvim/lua/config/options.lua`
- Modify: `nvim/.config/nvim/lua/config/keymaps.lua`
- Modify: `nvim/.config/nvim/lua/config/autocmds.lua`
- Create: `nvim/.config/nvim/lua/config/snippets.lua`
- Modify: `nvim/.config/nvim/init.lua`

**Interfaces:**
- Consumes: Neovim's `vim` Lua API.
- Produces: `require("config.snippets")`, which loads LuaSnip snippets from `~/.config/nvim/snippets`.

- [ ] **Step 1: Add startup configuration to its established modules**

Move `relativenumber` and `scrolloff` to `config/options.lua`; move all four global mappings to `config/keymaps.lua`; add the MJML extension registration to `config/autocmds.lua`; create `config/snippets.lua` containing the existing LuaSnip loader; require it after the other config modules in `init.lua`.

- [ ] **Step 2: Compile startup modules**

Run: `for f in nvim/.config/nvim/lua/config/{options,keymaps,autocmds,snippets}.lua; do nvim --headless -u NONE "+lua assert(loadfile('$f'))" +qa; done`
Expected: every file exits 0.

### Task 2: Extract one Lazy plugin spec per file

**Files:**
- Create: `nvim/.config/nvim/lua/custom/plugins/noice.lua`
- Create: `nvim/.config/nvim/lua/custom/plugins/mjml-preview.lua`
- Create: `nvim/.config/nvim/lua/custom/plugins/emmet.lua`
- Create: `nvim/.config/nvim/lua/custom/plugins/live-server.lua`
- Create: `nvim/.config/nvim/lua/custom/plugins/auto-cursorline.lua`
- Create: `nvim/.config/nvim/lua/custom/plugins/treesitter-textobjects.lua`
- Create: `nvim/.config/nvim/lua/custom/plugins/herdr-splits.lua`
- Create: `nvim/.config/nvim/lua/custom/plugins/indent-blankline.lua`
- Delete: `nvim/.config/nvim/lua/custom/plugins/olb.lua`

**Interfaces:**
- Consumes: Lazy.nvim's `custom.plugins` directory import convention.
- Produces: one valid Lazy plugin-spec table from each created module.

- [ ] **Step 1: Create each plugin module**

Copy each enabled plugin spec unchanged from `olb.lua` into the correspondingly named file and return that individual spec table. Omit the commented-out `vim-tmux-navigator` and `flash.nvim` examples.

- [ ] **Step 2: Remove the legacy aggregate module**

Delete `lua/custom/plugins/olb.lua` after every enabled spec and all non-plugin setup have been relocated.

- [ ] **Step 3: Compile each plugin module**

Run: `for f in nvim/.config/nvim/lua/custom/plugins/{noice,mjml-preview,emmet,live-server,auto-cursorline,treesitter-textobjects,herdr-splits,indent-blankline}.lua; do nvim --headless -u NONE "+lua assert(loadfile('$f'))" +qa; done`
Expected: every file exits 0.

### Task 3: Validate configuration integrity

**Files:**
- Verify: `nvim/.config/nvim/init.lua`
- Verify: `nvim/.config/nvim/lua/config/*.lua`
- Verify: `nvim/.config/nvim/lua/custom/plugins/*.lua`

**Interfaces:**
- Consumes: the complete refactored Neovim configuration.
- Produces: successful syntax validation and a diff showing only the intended structural split.

- [ ] **Step 1: Syntax-check all configuration Lua files**

Run: `find nvim/.config/nvim -name '*.lua' -print0 | xargs -0 -n1 nvim --headless -u NONE '+lua assert(loadfile(vim.fn.argv(0)))' +qa --`
Expected: exit 0.

- [ ] **Step 2: Review the refactor diff**

Run: `git diff --check && git diff -- nvim/.config/nvim`
Expected: no whitespace errors; all enabled plugin configuration and startup setup are preserved in their new files.

- [ ] **Step 3: Commit**

```bash
git add nvim/.config/nvim docs/superpowers/specs/2026-10-25-nvim-olb-plugin-split-design.md docs/superpowers/plans/2026-10-25-nvim-olb-plugin-split.md
git commit -m "refactor(nvim): split custom plugin configuration"
```
