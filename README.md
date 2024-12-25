# habema's dotfiles  
This repository contains my custom `.zshrc` file, and a theme config using [Oh My Posh](https://ohmyposh.dev/).

## Highlights
- Minimalistic [OhMyPosh](https://ohmyposh.dev/) theme.
- [zinit](https://github.com/zdharma-continuum/zinit): zsh plugin manager
- [fzf](https://github.com/junegunn/fzf): Fuzzy finder.
- [zoxide](https://github.com/ajeetdsouza/zoxide): Smarter `cd`.
- [pyenv](https://github.com/pyenv/pyenv) (will switch to [uv](https://github.com/astral-sh/uv) in the future)
- Syntax highlighting, completions, autosuggestions.

## Installation  
1. Ensure that git and curl are installed, and zsh is your default shell.
2. Install [Homebrew](https://brew.sh/).
2. Run this command to install the necessary dependencies:  
```zsh
brew install jandedobbeleer/oh-my-posh/oh-my-posh fzf zoxide 
```
```
# This is optional
brew install pyenv
pyenv install 3.10.16
pyenv global 3.10.16
```
3. Copy the `.zshrc` file into your `$HOME/.zshrc`
4. Copy the your favorite ohmyposh config to your `$HOME/.config/ohmyposh/config.toml` directory.
5. Restart your terminal session, or run `source .zshrc`