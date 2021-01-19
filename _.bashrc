# Machine specific configurations are at the bottom.
# The very last thing is always alias file loading because aliases may use environmental variables.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

umask 007

export EDITOR=/usr/bin/vim
export LANG='en_US.UTF-8'

export PATH=$HOME/bin:$HOME/scripts:$PATH:$HOME/.local/bin

touch $HOME/._workingDirectoryConfig
export WORKINGDIR=`cat $HOME/._workingDirectoryConfig`

# Language-specific variables.
export CLASSPATH=.:bin:build:lib:lib/*:classes:config
export PATH=$PATH:$HOME/go/bin
export PYTHONDONTWRITEBYTECODE=1

# More autocompletions
complete -G "*.db" sqlite3
complete -G "*.csv" sqlite
complete -G "*.sql" sqlite

# History control
# Don't lose any history! Lest we be doomed to repeat work.
HISTCONTROL=ignoredups:ignorespace
HISTFILESIZE='INFINITE'
HISTSIZE='INFINITE'

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion.d ]; then
    . /etc/bash_completion.d
fi

# Machine Specific

   export LD_LIBRARY_PATH=.:lib:/usr/local/lib:/usr/lib:/usr/lib32
   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.lib
   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/libJMagick.so

   # Wine
   export WINEPREFIX=/media/media/wineSteam64
   export WINEARCH=win64
   #export WINEPREFIX=/media/media/wineSteam32
   #export WINEARCH=win32

   # Both AMI and EC2 tools are installed here.
   #export EC2_HOME="/usr/local/lib/ec2-ami-tools-1.3-66634"
   #export PATH=$PATH:${EC2_HOME}/bin

   export JAVA_HOME=/usr/lib/jvm/default
   export JDK_HOME=/usr/lib/jvm/default

   # Ruby
   export GEM_HOME=$HOME/.gems
   export PATH=$HOME/.gems/bin:$PATH
   export PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin

   # visualvm
   export PATH=$PATH:/usr/lib/visualvm/bin

# Alias definitions.
# Always load aliases last since they might use variables.
if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi
