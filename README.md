# Neovim Config

Lua-based config using [lazy.nvim](https://github.com/folke/lazy.nvim). Migrated from Dein + VimScript.

## First-time Setup

Run these once after cloning / on a new machine, then open Neovim (plugins install automatically).

### 1. Nerd Font (required for icons in lualine and Telescope)

```bash
brew install --cask font-meslo-lg-nerd-font
```

Then set your terminal font to **MesloLGS Nerd Font** (iTerm2: Preferences → Profiles → Text → Font).

### 2. Go (required for gopls LSP)

```bash
brew install go
```

After installing Go, open Neovim and run `:MasonInstall gopls`.

### 3. Neovim providers (optional — silences `:checkhealth` warnings)

```bash
# Python provider
pip install --break-system-packages pynvim

# Node provider
npm install -g neovim
```

> **Note on pip:** macOS Homebrew Python blocks global `pip install` by default.
> The `--break-system-packages` flag bypasses that restriction for this one package.

### 4. tmux (if you use tmux)

Add to `~/.tmux.conf` to enable focus-events (makes `autoread` work correctly):

```
set-option -g focus-events on
```

---

## File Structure

```
~/.config/nvim/
  init.lua              ← entry point: loads config/ then plugins/
  lua/
    config/
      options.lua       ← vim settings (vim.opt.*)
      keymaps.lua       ← all key mappings
      autocmds.lua      ← autocommands and filetype rules
    plugins/
      init.lua          ← lazy.nvim bootstrap + plugin list
      ui.lua            ← colorscheme (kanagawa), lualine
      editor.lua        ← telescope, oil, which-key, conform, toggleterm, render-markdown
      git.lua           ← gitsigns, fugitive
      treesitter.lua    ← syntax trees + text objects
      syntax.lua        ← ansible-vim, Jinja2 (non-Treesitter)
      lsp.lua           ← mason, nvim-lspconfig, nvim-cmp
      lang/             ← per-language LSP + tool configs
```

## Plugin Manager

| Command | Action |
|---------|--------|
| `<F2>` | Update all plugins (`:Lazy update`) |
| `:Lazy` | Open plugin manager UI |
| `:Lazy sync` | Install + update + clean |
| `:Mason` | Open LSP/tool installer UI |

**Adding a new plugin:** Create or edit a file in `lua/plugins/`. Return a table (or list of tables) following the [lazy.nvim spec](https://github.com/folke/lazy.nvim#-plugin-spec). Restart or run `:Lazy sync`.

---

## Keybindings

### Navigation

| Key | Action |
|-----|--------|
| `H` / `L` | Previous / next tab |
| `<C-h/j/k/l>` | Move between splits |
| `<C-e>` | Rotate window layout |
| `↑ ↓ ← →` | Reposition current split (K/J/H/L) |
| `-` | Open file browser (oil.nvim) in parent dir |

### File Finding (Telescope)

| Key | Action |
|-----|--------|
| `<Leader>f` | Find files (fuzzy, respects .gitignore) |
| `<Leader>b` | Switch buffers |
| `<Leader>g` | Live grep (search file contents) |

Inside Telescope: `<C-t>` open in tab, `<C-u>` horizontal split, `<C-h>` vertical split.

### LSP

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gr` | List references |
| `<Leader>lr` | Rename symbol |
| `<Leader>la` | Code actions (quick fixes, imports, etc.) |
| `<Leader>lf` | Format current file |
| `<Leader>lv` | Select Python virtualenv |
| `<C-p>` | Jump to previous diagnostic |
| `<C-n>` | Jump to next diagnostic |

### Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `<Tab>` | Next item / expand snippet / jump snippet stop |
| `<S-Tab>` | Previous item / jump back in snippet |
| `<CR>` | Confirm selection (only if explicitly selected) |
| `<C-Space>` | Force-open completion menu |
| `<C-e>` | Close menu without confirming |
| `<C-d>` / `<C-u>` | Scroll docs down / up |

### Git (gitsigns + fugitive)

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous git hunk |
| `<Leader>gp` | Preview hunk diff inline |
| `<Leader>gb` | Git blame current line |
| `:Git` | Open fugitive (full git UI) |
| `:Gblame` | Blame buffer |
| `:Gdiffsplit` | Diff against HEAD |

### Terminal (toggleterm)

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle persistent horizontal terminal |
| `<Leader>cc` | Open Claude Code in floating terminal |

Inside the terminal, press `<C-\><C-n>` to exit terminal mode back to normal mode.

### File Utilities

| Key | Action |
|-----|--------|
| `<F2>` | Update plugins |
| `<F3>` | `cd` to current file's directory |
| `<F5>` | Strip trailing whitespace |
| `<F6>` | Toggle search highlight |
| `<F7>` | Format current file (conform.nvim) |
| `<F10>` | Toggle visible whitespace |
| `cp` | Copy current file's full path to clipboard |

---

## Treesitter Text Objects

These work in visual (`v`) and operator-pending mode (e.g., `d`, `c`, `y`):

| Key | Selects |
|-----|---------|
| `af` | Around function (including signature) |
| `if` | Inside function (body only) |
| `ac` | Around class |
| `ic` | Inside class |
| `aa` | Around argument |
| `ia` | Inside argument |

**Jump motions:**

| Key | Jumps to |
|-----|----------|
| `]m` / `[m` | Next / previous function start |
| `]c` / `[c` | Next / previous class start |

**Example:** `daf` deletes the entire function under the cursor, including its signature.

---

## Language Support

### Python
- **LSP:** pyright (type checking, completion, hover)
- **Lint + Format:** ruff (replaces black + flake8 + isort in one pass)
- **Virtualenvs:** `<Leader>lv` → pick a venv → pyright reloads automatically
- **Format on save:** yes (via conform)

### Go
- **LSP:** gopls (completion, diagnostics, go-to-def)
- **Commands:** `:GoRun`, `:GoTest`, `:GoBuild`, `:GoDebug` (vim-go)
- **Format on save:** yes (`gofmt` via conform)

### Bash / Shell
- **LSP:** bashls (completion, hover, function definitions)
- **Lint:** shellcheck (unbound vars, quoting bugs, portability warnings)
- **Format on save:** yes (`shfmt` via conform)

### TypeScript / JavaScript
- **LSP:** ts_ls (completion, types, go-to-def, refactors)
- **Lint:** eslint (auto-fix on save)
- **Format on save:** yes (prettier via conform)
- **JSX/TSX:** nvim-ts-autotag auto-closes and renames tags

### Ansible
- **LSP:** ansiblels (task/module completion, hover docs)
- **Lint:** ansible-lint (best practices, deprecated syntax)
- **Syntax:** ansible-vim (richer than Treesitter YAML for playbooks)

### Markdown
- **LSP:** marksman (link completion, `[[wiki]]` links, document outline via `gr`)
- **Rendering:** render-markdown.nvim renders headers, code blocks, and bold in-buffer
- **Format on save:** yes (prettier via conform)
- **Toggle rendering:** `:RenderMarkdown toggle`

### C / C++
- **LSP:** clangd (completion, diagnostics, go-to-def, clang-tidy)
- **Format on save:** yes (`clang-format` via conform — reads `.clang-format` from project root)
- **Note:** clangd reads `compile_commands.json` from project root for include paths.
  Generate it with CMake: `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..`

---

## Tips

**which-key:** Press `<Leader>` and wait — a popup shows all available bindings grouped by category.

**oil.nvim:** Press `-` to open the parent directory as a buffer. Edit filenames directly in the buffer and save to rename. `<CR>` opens a file.

**Telescope:** Inside any picker, `<C-/>` shows all available mappings.

**fidget.nvim:** The spinner in the bottom-right shows LSP progress (e.g., "pyright: indexing"). It disappears when servers are ready — if it stays spinning, run `:LspInfo` to debug.

**`:checkhealth`:** Run this after first install to verify all providers (Python, Node, etc.) are found. Fix any `ERROR` lines — `WARN` lines are usually fine.
