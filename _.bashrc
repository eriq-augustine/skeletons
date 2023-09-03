# Machine specific configurations are at the bottom.
# The very last thing is always alias file loading because aliases may use environmental variables.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

umask 007

export EDITOR=/usr/bin/vim
export SYSTEMD_EDITOR=/usr/bin/vim
export LANG='en_US.UTF-8'

export PATH=$HOME/bin:$HOME/scripts:$PATH:$HOME/.local/bin

touch $HOME/._workingDirectoryConfig
export WORKINGDIR=`cat $HOME/._workingDirectoryConfig`

# Language-specific variables.
export CLASSPATH=.:bin:build:lib:lib/*:classes:config
export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin
export PYTHONDONTWRITEBYTECODE=1
export GLOBAL_VENV_PATH="${HOME}/.venv"

# More autocompletions
complete -G "*.db" sqlite3
complete -G "*.csv" sqlite
complete -G "*.sql" sqlite

# History control
# Don't lose any history! Lest we be doomed to repeat work.
HISTCONTROL=ignoredups:ignorespace
HISTFILESIZE='INFINITE'
HISTSIZE='INFINITE'

# Export entries to history right away (actually after the command finishes).
export PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Ignore Software Flow Control (Ctrl-S ctrl-Q).
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /bin/dircolors -o -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion.d ]; then
    . /etc/bash_completion.d
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Alias definitions.
# Always load aliases last since they might use variables.
if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi
