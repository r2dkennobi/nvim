local h = vim.health

local M = {}

function M.check()
  h.start("Neovim Config: Prerequisites")

  -- Go (required for Mason to install gopls)
  if vim.fn.executable("go") == 1 then
    local ver = vim.fn.system("go version"):gsub("^go version ", ""):gsub("\n", "")
    h.ok("go: " .. ver)
  else
    h.error("go: not found — Mason cannot install gopls without it", {
      "brew install go",
      "Then in Neovim: :MasonInstall gopls",
    })
  end

  -- gopls binary (Mason-managed)
  local gopls = vim.fn.stdpath("data") .. "/mason/bin/gopls"
  if vim.fn.executable(gopls) == 1 then
    h.ok("gopls: installed via Mason")
  else
    h.warn("gopls: not installed", { "In Neovim: :MasonInstall gopls  (requires go above)" })
  end

  -- Python provider venv + pynvim
  local venv_python = vim.fn.expand("~/.venvs/neovim/bin/python")
  if vim.fn.executable(venv_python) == 1 then
    vim.fn.system(venv_python .. " -c 'import pynvim' 2>/dev/null")
    if vim.v.shell_error == 0 then
      h.ok("pynvim: found in ~/.venvs/neovim")
    else
      h.error("pynvim: venv exists but pynvim not installed", {
        "~/.venvs/neovim/bin/pip install pynvim",
      })
    end
  else
    h.error("Python provider venv not found at ~/.venvs/neovim", {
      "python3 -m venv ~/.venvs/neovim",
      "~/.venvs/neovim/bin/pip install pynvim",
    })
  end

  -- Node neovim package
  vim.fn.system("node -e \"require('neovim')\" 2>/dev/null")
  if vim.v.shell_error == 0 then
    h.ok("neovim npm package: found")
  else
    h.warn("neovim npm package: not installed", { "npm install -g neovim" })
  end

  -- tmux focus-events (only checked when running inside tmux)
  if vim.env.TMUX then
    local focus = vim.fn.system("tmux show-options -gv focus-events 2>/dev/null"):gsub("\n", "")
    if focus == "on" then
      h.ok("tmux focus-events: on")
    else
      h.warn("tmux focus-events not enabled — autoread may not fire on file changes outside Neovim", {
        "Add to ~/.tmux.conf:  set-option -g focus-events on",
        "Then reload:          tmux source ~/.tmux.conf",
      })
    end
  else
    h.ok("tmux: not active")
  end

  -- Nerd Font: can't detect from inside Neovim (fonts render in the terminal),
  -- so render a known glyph and let the user judge + report the install path.
  local term = vim.env.TERM_PROGRAM or vim.env.TERM or ""
  local likely = term:match("iTerm") or term:match("WezTerm") or vim.env.KITTY_WINDOW_ID
  if likely then
    h.info("Nerd Font: terminal looks compatible (" .. term .. ") — verify '' renders as a branch icon")
  else
    h.warn("Nerd Font: cannot confirm (terminal: " .. (term ~= "" and term or "unknown") .. ")", {
      "brew install --cask font-meslo-lg-nerd-font",
      "Then set terminal font to MesloLGS Nerd Font",
      "If '' above looks like a box/?, the font is missing",
    })
  end
end

return M
