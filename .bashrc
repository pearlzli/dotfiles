# -*- shell-script -*-
# The above line tells emacs to open this file in shell-script-mode
# It must be the first line in the file
# https://www.gnu.org/software/emacs/manual/html_node/efaq/Associating-modes-with-files.html

# Need this for emacs syntax highlighting to display properly
export TERM="xterm-256color"

# Set default editor for command-line programs
export EDITOR="emacs"

# Cache tmux and ruby versions: https://stackoverflow.com/a/40902312/2756250
# Only if tmux/ruby commands exist: https://stackoverflow.com/a/677212
if command -v ruby &> /dev/null; then
    export RUBY_VERSION="$(ruby -v | sed -En "s/^ruby ([0-9]+(.[0-9]+)(.[0-9]+)).*/\1/p")"
fi
if command -v tmux &> /dev/null; then
    export TMUX_VERSION="$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")"
fi

# Custom PS1:
#   user@hostname current-directory (git branch) (python venv) $
# See:
# 1. https://www.linux.com/learn/how-make-fancy-and-useful-bash-prompt-linux
# 2. https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt
# 3. https://stackoverflow.com/questions/10406926/how-do-i-change-the-default-virtualenv-prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
parse_python_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="$(basename $VIRTUAL_ENV)"
        echo "($venv) "
    fi
}
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PS1="\[\e[1;35m\]\u@\h \[\e[0;35m\]\w \[\e[0;36m\]\$(parse_git_branch)\[\e[0;33m\]\$(parse_python_venv)\[\e[0;35m\]$ \[\e[m\]"

# Arrows and C-p/C-n search from current command
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward'  2>/dev/null
bind '"\C-p": history-search-backward' 2>/dev/null
bind '"\C-n": history-search-forward'  2>/dev/null

# Command aliases
alias cp="cp -i" # ask before overwriting
alias e="emacs -nw"
alias la="ls -a"
alias ld="ls -d */"
alias ll="ls -l -h"
alias less="less -r" # handle escape characters
alias mv="mv -i" # ask before overwriting
alias mytop="top -u $USER"
alias pip="python -m pip"

# Hide files from ls
hide="--hide='*.aux' --hide='*.bbl' --hide='*.blg' --hide='*.fls' --hide='*.log' --hide='*.nav' --hide='*.out' --hide='*.snm' --hide='*.thm' --hide='*.toc' --hide='*~'"

# Show directory names in light blue
export LS_COLORS=$LS_COLORS'di=1;34:'

# OS-specific command aliases
case $OSTYPE in
    cygwin*)
        alias ls="ls --color=auto --sort=extension --group-directories-first $hide"
        ;;
    darwin*) # OS X
        alias ls="ls -G"

        alias acrobat="open -a Adobe\ Acrobat.app"
        alias chrome="open -a Google\ Chrome.app"
        alias skim="open -a Skim.app"
        alias textedit="open -a TextEdit.app"

        # Stop Skim asking about auto-reloading
        # https://tex.stackexchange.com/a/43060/116532
        if [ -d "/Applications/Skim.app" ]; then
            defaults write -app Skim SKAutoReloadFileUpdate -boolean true
        fi
        ;;
    linux*)
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
alias gg="git grep"
alias gpo="git push origin"
alias gri="git rebase -i"
alias gs="git status"

function gdt {
    if [ $# -eq 0 ]; then
        # Do a directory diff if no arguments are passed in
        git difftool --dir-diff
    else
        git difftool "$@"
    fi
}

# Stop graphical display popup for password when git pushing
unset SSH_ASKPASS

# Set default file-creation mode to u=rwx, g=rwx, o=rx
# Check your (human-readable) permissions using "umask -S"
umask 0002

# When evince and other graphical displays don't work, it's often because the
# DISPLAY environment variable inside tmux isn't the same as the one outside
# tmux. To fix, run update_display in each pane where you want to open a
# graphical display (backgrounding current process if necessary).
# https://goosebearingbashshell.github.io/2017/12/07/reset-display-variable-in-tmux.html
update_display() {
    DISPLAY_OLD="$DISPLAY"
    export DISPLAY="`tmux show-env | sed -n 's/^DISPLAY=//p'`"
    echo "DISPLAY updated from $DISPLAY_OLD to $DISPLAY"
}

# Set default grep options:
# -i: ignore case
# -n: show line number
# -I: exclude binary files
# --color=auto
alias grep='grep -in -I --color=auto'

# Source system-specific aliases
source ~/.bashrc-local
