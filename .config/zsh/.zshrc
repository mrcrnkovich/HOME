autoload -U compinit && compinit

setopt AUTO_CD
setopt CDABLE_VARS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

setopt CORRECT
setopt PROMPT_SUBST

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_SAVE_NO_DUPS

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' complete-options true

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^y' accept-line
bindkey -M menuselect '^xi' vi-insert

# enable VI mode, makesure the ESC key triggers w/o delay
bindkey -v; export KEYTIMEOUT=1

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'e' edit-command-line

# Autocompletion using arrow keys ( based on history )
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

#GPG-AGENT recommendation
GPG_TTY=$(tty)
export GPG_TTY

# Load aliases
alias ls='ls --color'
alias tree='tree -C'
alias :q='exit'
alias :wq='exit'
alias vi='$EDITOR'
alias e='$EDITOR'
alias :e='$EDITOR'
alias open='xdg-open'

# computer specific aliases ( not git sync'd )
[ -e "${ZDOTDIR}/aliases" ] && source "${ZDOTDIR}/aliases"

function cursor_mode {

    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    function zle-line-init {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

function prompt_git_branch {
    autoload -Uz vcs_info
    precmd() { vcs_info }

    zstyle ':vcs_info:*' enable git
    if [[ $GIT_PROMPT_CHANGES -ne 0 ]]; then
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:git:*' unstagedstr '*'
        zstyle ':vcs_info:git:*' stagedstr '*'
        zstyle ':vcs_info:git:*' formats ' %b%u%c'
    else
        zstyle ':vcs_info:git:*' formats '[%b]'
    fi
}

#Set up prompt - Maybe move this
prompt_git_branch
RPROMPT=$''
PROMPT=$'%F{green}${vcs_info_msg_0_}%f%F{white}[%~]%f %B%F{white}[$(tmux list-windows 2>/dev/null | grep "active" | cut -d: -f1 )]%f %F{yellow}\uf120  %f%b'

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec sway
fi
