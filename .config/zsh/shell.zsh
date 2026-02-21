HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

alias cls='clear'
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(try init)"

python() {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        echo "⚠️  Warning: python is being run outside a virtual environment!"
        echo "   Consider creating a venv with: uv venv"
    fi
    command python "$@"
}

python3() {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        echo "⚠️  Warning: python3 is being run outside a virtual environment!"
        echo "   Consider creating a venv with: uv venv"
    fi
    command python3 "$@"
}

pip() {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        echo "⚠️  Warning: pip is being run outside a virtual environment!"
        echo "   Consider creating a venv with: uv venv"
    fi
    command pip "$@"
}

pip3() {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        echo "⚠️  Warning: pip3 is being run outside a virtual environment!"
        echo "   Consider creating a venv with: uv venv"
    fi
    command pip3 "$@"
}
