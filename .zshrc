### Influenced by [Dreams Of Autonomy](https://www.youtube.com/@dreamsofautonomy).

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you have brew on macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]] then
  # If you have brew on Linux, you'll want this enabled
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Docker completions
if command -v docker &> /dev/null; then
  local docker_completion_file="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/completions/_docker"
  local docker_version_file="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/completions/.docker_version"
  
  mkdir -p "${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/completions"
  
  # Only regenerate if completion file doesn't exist or docker version changed
  local current_version=$(docker version --format '{{.Server.Version}}' 2>/dev/null || docker version --format '{{.Client.Version}}' 2>/dev/null || echo "")
  local cached_version=$(cat "$docker_version_file" 2>/dev/null || echo "")
  
  if [[ ! -f "$docker_completion_file" ]] || [[ "$current_version" != "$cached_version" ]]; then
    docker completion zsh > "$docker_completion_file" 2>/dev/null && echo "$current_version" > "$docker_version_file" || true
  fi
  
  fpath=("${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/completions" $fpath)
fi

# Add in snippets
zinit snippet OMZP::command-not-found
zinit snippet OMZP::extract
zinit snippet OMZP::colored-man-pages

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Load oh-my-posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias cls='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Python environment management with uv
# Ensure ~/.local/bin is in PATH for uv-managed Python
export PATH="$HOME/.local/bin:$PATH"


# Warn when using python/pip outside a virtual environment
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
