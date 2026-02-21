ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

if command -v docker &> /dev/null; then
  local docker_completion_file="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/completions/_docker"
  local docker_version_file="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/completions/.docker_version"

  mkdir -p "${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/completions"

  local current_version=$(docker version --format '{{.Server.Version}}' 2>/dev/null || docker version --format '{{.Client.Version}}' 2>/dev/null || echo "")
  local cached_version=$(cat "$docker_version_file" 2>/dev/null || echo "")

  if [[ ! -f "$docker_completion_file" ]] || [[ "$current_version" != "$cached_version" ]]; then
    docker completion zsh > "$docker_completion_file" 2>/dev/null && echo "$current_version" > "$docker_version_file" || true
  fi

  fpath=("${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/completions" $fpath)
fi

zinit snippet OMZP::command-not-found
zinit snippet OMZP::extract
zinit snippet OMZP::colored-man-pages

autoload -Uz compinit && compinit

zinit cdreplay -q

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi
