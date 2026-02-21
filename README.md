# habema's dotfiles  
This repository contains my custom `.zshrc` file, and a theme config using [Oh My Posh](https://ohmyposh.dev/).

## Highlights
- Minimalistic [OhMyPosh](https://ohmyposh.dev/) theme.
- [zinit](https://github.com/zdharma-continuum/zinit): zsh plugin manager
- [fzf](https://github.com/junegunn/fzf): Fuzzy finder.
- [zoxide](https://github.com/ajeetdsouza/zoxide): Smarter `cd`.
- [uv](https://github.com/astral-sh/uv): Fast Python package and project manager
- Syntax highlighting, completions, autosuggestions.

## Installation  
1. Ensure that git and curl are installed, and zsh is your default shell.
2. Install [Homebrew](https://brew.sh/).
3. Run this command to install the necessary dependencies:  
```zsh
brew tap tobi/try https://github.com/tobi/try
brew install jandedobbeleer/oh-my-posh/oh-my-posh fzf zoxide eza ripgrep fd try
```
4. Install [uv](https://github.com/astral-sh/uv) (Python package and project manager):
```zsh
curl -LsSf https://astral.sh/uv/install.sh | sh
```
5. Install a Python version via uv (optional, but recommended):
```zsh
uv python install 3.13 --default
```
6. Copy the `.zshrc` file into your `$HOME/.zshrc`
7. Copy your favorite ohmyposh config to your `$HOME/.config/ohmyposh/config.toml` directory.
8. Restart your terminal session, or run `source ~/.zshrc`