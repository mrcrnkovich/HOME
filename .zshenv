# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64" 
export XDG_XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_TEMPLATES_DIR="$HOME/templates"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_VIDEOS_DIR="$HOME/videos"
export XDG_CONFIG_HOME="${HOME}/.config"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

export GTK_BACKEND=wayland
export CLUTTER_BACKEND=wayland

export EDITOR=nvim
export VISUAL=nvim
export PAGER='less -r'

export HISTFILE="${ZDOTDIR}/.zhistory"    # History filepath
export HISTSIZE=10000                     # Maximum events for internal history
export SAVEHIST=10000                     # Maximum events in history file

export PYENV_ROOT="${HOME}/.pyenv"

# export MANPATH="/usr/local/man:$MANPATH"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Enable prompt to check for git status info
# Set to 0 to turn off, this may be expensive in large directories
export GIT_PROMPT_CHANGES=1

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

export PATH="$PATH:$HOME/.local/texlive/2023/bin/x86_64-linux"

export PATH="$HOME/.local/bin:$PATH"

export PATH="/home/mike/perl5/bin${PATH:+:${PATH}}";
export PERL5LIB="/home/mike/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}";
export PERL_LOCAL_LIB_ROOT="/home/mike/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}";
export PERL_MB_OPT="--install_base \"/home/mike/perl5\"";
export PERL_MM_OPT="INSTALL_BASE=/home/mike/perl5";
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

export PATH="${HOME}/bin:$PATH"

# Just making sure bin is somewhere in the path
export PATH="$PATH:/bin"
export MANPAGER='nvim +Man!'

# is a WSD Brother MFC-L2750DW series ip=192.168.1.6, 2600:4040:7594:1200:32c9:abff:fe27:8b24
SANE_DEFAULT_DEVICE="airscan:w0:Brother MFC-L2750DW"
