# Need this for emacs syntax highlighting to display properly
export TERM="xterm-256color"

# Set default editor for command-line programs
export EDITOR="emacs"

# Custom PS1:
#   user@hostname current-directory (git branch) $
# See:
# 1. https://www.linux.com/learn/how-make-fancy-and-useful-bash-prompt-linux
# 2. https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\e[1;35m\]\u@\h \[\e[0;35m\]\w\[\e[0;36m\]\$(parse_git_branch)\[\e[0;35m\] $ \[\e[m\]"

# Arrows and C-p/C-n search from current command
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward'  2>/dev/null
bind '"\C-p": history-search-backward' 2>/dev/null
bind '"\C-n": history-search-forward'  2>/dev/null

# Command aliases
alias cp="cp -i"
alias e="emacs -nw"
alias la="ls -a"
alias ld="ls -d */"
alias ll="ls -l -h"
alias mv="mv -i"
alias mytop="top -u $USER"

# Hide files from ls
hide="--hide='*.aux' --hide='*.bbl' --hide='*.blg' --hide='*.fls' --hide='*.log' --hide='*.nav' --hide='*.out' --hide='*.snm' --hide='*.thm' --hide='*.toc' --hide='*~'"

# Show directory names in light blue
export LS_COLORS=$LS_COLORS'di=1;34:'

# OS-specific command aliases
case $OSTYPE in
    cygwin*)
        alias browser="chrome"
        alias ls="ls --color=auto --sort=extension --group-directories-first $hide"
        ;;
    darwin*) # OS X
        alias browser="open -a \"Google Chrome\""
        alias ls="ls -G"
        alias openf="open -R" # show in Finder

        alias adobe="open -a Adobe\ Acrobat\ Reader\ DC.app"
        alias safari="open -a Safari.app"
        alias skim="open -a Skim.app"

        # Stop Skim asking about auto-reloading
        # https://tex.stackexchange.com/a/43060/116532
        defaults write -app Skim SKAutoReloadFileUpdate -boolean true
        ;;
    linux*)
        alias browser="firefox"
        alias ls="ls --color=auto --sort=extension --group-directories-first $hide"
        ;;
    *) ;;
esac

# Git-specific aliases
alias ga="git add"
alias gap="git add --patch"
alias gb="git branch"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gd="git diff"
alias gdt="git difftool"
alias gg="git grep"
alias gpo="git push origin"
alias gs="git status"

# Stop graphical display popup for password when git pushing
unset SSH_ASKPASS

# Set default file-creation mode to u=rwx, g=rwx, o=rx
# Check your (human-readable) permissions using "umask -S"
umask 0002

# When evince and other graphical displays don't work, it's often because the
# DISPLAY environment variable inside tmux isn't the same as the one outside
# tmux.
#
# 1. Detach from tmux session and use cache_display.
# 2. Reattach to tmux session and use parse_display. (You'll have to do this in
#    each pane in which you want to open a graphical display.)
cache_display() {
    echo "$DISPLAY" > ~/.DISPLAY
    echo "DISPLAY cached as $DISPLAY"
}

parse_display() {
    DISPLAY_OLD="$DISPLAY"
    export DISPLAY="$(cat ~/.DISPLAY)"
    echo "DISPLAY updated from $DISPLAY_OLD to $DISPLAY"
}

# Set default grep options:
# -i: ignore case
# -n: show line number
# -r: search recursively
# --color=auto
export GREP_OPTIONS='-inr --color=auto'

# Automatically convert between local and remote userids in sshfs
alias sshfs="sshfs -o idmap=user"

# Source system-specific aliases
source ~/.bashrc-local
