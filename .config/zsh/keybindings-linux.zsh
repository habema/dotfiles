backward-kill-path-component() {
    local WORDCHARS="${WORDCHARS/\/}"
    zle backward-kill-word
}
zle -N backward-kill-path-component
bindkey '^[^?' backward-kill-path-component
