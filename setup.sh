#!/bin/bash
# Installs system-level prerequisites for this Neovim config.
# Mason handles LSP servers automatically; this script handles what Mason cannot.
set -e

echo "==> Installing Homebrew packages..."
if command -v nvm &>/dev/null || [ -d "$HOME/.nvm" ]; then
  echo "    NVM detected — skipping brew node (use nvm to manage Node)"
  brew install ansible shellcheck go
else
  brew install node ansible shellcheck go
fi

echo "==> Installing npm global packages..."
npm install -g neovim tree-sitter-cli

echo "==> Installing ansible-lint..."
pip3 install --user ansible-lint

echo "==> Setting up Python provider venv..."
python3 -m venv ~/.venvs/neovim
~/.venvs/neovim/bin/pip install pynvim

echo ""
echo "Done. Open Neovim and run :checkhealth config to verify."
echo "Mason will auto-install LSP servers on first launch."
