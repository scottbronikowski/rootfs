# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -lhA'

alias xtg='xterm -bg black -fg green2 &'
alias xtw='xterm -bg black -fg white &'
alias xty='xterm -bg black -fg yellow2 &'
alias xto='xterm -bg black -fg orange2 &'
alias xtr='xterm -bg black -fg red2 &'
alias xtm='xterm -bg black -fg magenta2 &'

alias sshksu='ssh scottb77@cislinux.cis.ksu.edu -p 22 -D 8080'
alias sshhome='ssh scott@scottbronikowski-2.yourhda.com -p 2222'
alias sshqobi='ssh -Y sbroniko@upplysingaoflun.ecn.purdue.edu'
alias sshece13='ssh -Y sbroniko@ecelinux13.ecn.purdue.edu'
alias sshmin='ssh -Y sbroniko@min.ecn.purdue.edu'
alias sshece17='ssh -Y sbroniko@ecelinux17.ecn.purdue.edu'
alias sshseykhl='ssh -Y sbroniko@seykhl.ecn.purdue.edu'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


###
#    # See if we can use extended characters to look nicer.
#    
#    typeset -A altchar
#    set -A altchar ${(s..)terminfo[acsc]}
#    PR_SET_CHARSET="%{$terminfo[enacs]%}"
#    PR_SHIFT_IN="%{$terminfo[smacs]%}"
#    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
#    PR_HBAR=${altchar[q]:--}
#    PR_ULCORNER=${altchar[l]:--}
#    PR_LLCORNER=${altchar[m]:--}
#    PR_LRCORNER=${altchar[j]:--}
#    PR_URCORNER=${altchar[k]:--}
export PATH=~/bin/:$PATH
export QINSTALLDIR=${HOME}
export ARCHITECTURE_PATH=`~/bin/architecture-path`
export QARCHITECTURE_PATH=${ARCHITECTURE_PATH}
export PATH=${PATH}:~/bin
export PATH=${PATH}:~/bin/${ARCHITECTURE_PATH}
export LD_LIBRARY_PATH=/usr/local/lib:${HOME}/lib/${ARCHITECTURE_PATH}:${HOME}/include/$(architecture-path):${HOME}/lib/$(architecture-path)/include:${HOME}/lib/$(architecture-path):$LD_LIBRARY_PATH
ulimit -c unlimited
