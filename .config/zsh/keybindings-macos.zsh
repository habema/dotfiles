backward-kill-path-component() {
    local WORDCHARS="${WORDCHARS/\/}"
    zle backward-kill-word
}
zle -N backward-kill-path-component
bindkey '\e\b' backward-kill-path-component
