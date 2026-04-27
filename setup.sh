#!/bin/bash
# Installs system-level prerequisites for this Neovim config.
# Mason handles LSP servers automatically; this script handles what Mason cannot.
set -e

echo "==> Installing Homebrew packages..."
brew install node ansible shellcheck go

echo "==> Installing npm global packages..."
npm install -g neovim

echo "==> Installing ansible-lint..."
pip3 install --user ansible-lint

echo "==> Setting up Python provider venv..."
python3 -m venv ~/.venvs/neovim
~/.venvs/neovim/bin/pip install pynvim

echo ""
echo "Done. Open Neovim and run :checkhealth config to verify."
echo "Mason will auto-install LSP servers on first launch."
