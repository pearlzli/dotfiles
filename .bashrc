# need this for emacs syntax highlighting to display properly
# DO NOT set to cygwin, or emacs display gets fucked up for some reason
export TERM="xterm-256color"

# set default editor for command-line programs
export EDITOR="emacs"

# custom PS1: https://www.linux.com/learn/how-make-fancy-and-useful-bash-prompt-linux
# git branch to prompt: https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\e[1;35m\]\u@\h \[\e[0;35m\]\w\[\e[0;36m\]\$(parse_git_branch)\[\e[0;35m\] $ \[\e[m\]"

# arrows and C-p/C-n search from current command
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward'  2>/dev/null
bind '"\C-p": history-search-backward' 2>/dev/null
bind '"\C-n": history-search-forward'  2>/dev/null

# command aliases
alias cp="cp -i"
alias la="ls -a"
alias ld="ls -d */"
alias ll="ls -l -h"
alias mv="mv -i"

# hide files from ls
hide="--hide='*.aux' --hide='*.bbl' --hide='*.blg' --hide='*.fls' --hide='*.log' --hide='*.nav' --hide='*.out' --hide='*.snm' --hide='*.thm' --hide='*.toc' --hide='*~'"

# OS-specific command aliases
case $OSTYPE in
  cygwin*)
    alias ls="ls --color=auto --sort=extension --group-directories-first $hide"
    ;;
  darwin*) # OS X
    alias ls="ls -G"
    ;;
  linux*)
    alias ls="ls --color=auto --sort=extension --group-directories-first $hide"
    ;;
  *) ;;
esac

# program aliases
alias e="emacs -nw"

# git-specific aliases
alias ga="git add"
alias gb="git branch"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gd="git diff"
alias gg="git grep"
alias gpo="git push origin"
alias gs="git status"

# cache DISPLAY environment variable from outside tmux
cache_display() {
  echo "$DISPLAY" > ~/.DISPLAY
    echo "DISPLAY cached as $DISPLAY"
}

parse_display() {
  DISPLAY_OLD="$DISPLAY"
  export DISPLAY="$(cat ~/.DISPLAY)"
  echo "DISPLAY updated from $DISPLAY_OLD to $DISPLAY"
}

# source system-specific aliases
source ~/.bashrc-local
