# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64" 
export XDG_CONFIG_HOME="${HOME}/.config"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

export GTK_BACKEND=wayland
export CLUTTER_BACKEND=wayland

export EDITOR=nvim
export VISUAL=nvim

export HISTFILE="${ZDOTDIR}/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export PATH="/home/mike/perl5/bin${PATH:+:${PATH}}";
export PERL5LIB="/home/mike/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}";
export PERL_LOCAL_LIB_ROOT="/home/mike/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}";
export PERL_MB_OPT="--install_base \"/home/mike/perl5\"";
export PERL_MM_OPT="INSTALL_BASE=/home/mike/perl5";

export PATH=$PATH:$HOME/go/bin

# export MANPATH="/usr/local/man:$MANPATH"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Enable prompt to check for git status info
# Set to 0 to turn off, this may be expensive in large directories
export GIT_PROMPT_CHANGES=1

export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOENV_ROOT/shims:$PATH"
export GOBIN="$HOME/go/bin"


export PATH="$PATH:$HOME/.local/texlive/2023/bin/x86_64-linux"

eval "$(goenv init -)"
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

export PATH="${HOME}/bin:$PATH"
