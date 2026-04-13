# -*- shell-script -*-
# The above line tells emacs to open this file in shell-script-mode
# It must be the first line in the file
# https://www.gnu.org/software/emacs/manual/html_node/efaq/Associating-modes-with-files.html

# Need this for emacs syntax highlighting to display properly
export TERM="xterm-256color"

# Need this starting in tmux 3.6
# Otherwise, tmux sets to "truecolor" and emacs colors don't match Terminal colors
# https://github.com/tmux/tmux/issues/4699#issuecomment-3585364637
export COLORTERM=""

# Set default editor for command-line programs
export EDITOR="emacs"

# Cache tmux version: https://stackoverflow.com/a/40902312/2756250
# Only if tmux command exists: https://stackoverflow.com/a/677212
if command -v tmux &> /dev/null; then
    export TMUX_VERSION="$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")"
fi

# Custom PS1:
#   user@hostname current-directory (git branch) (python venv) $
# See:
# 1. https://www.linux.com/learn/how-make-fancy-and-useful-bash-prompt-linux
# 2. https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt
# 3. https://stackoverflow.com/questions/10406926/how-do-i-change-the-default-virtualenv-prompt
# 4. https://stackoverflow.com/questions/2564634/convert-absolute-path-into-relative-path-given-a-current-directory-using-bash
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
parse_python_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        rel_venv="$(perl -le 'use File::Spec; print File::Spec->abs2rel(@ARGV)' $VIRTUAL_ENV $pwd)"
        echo "($rel_venv) "
    elif command -v conda &> /dev/null && [[ -n "$CONDA_PREFIX" ]]; then
        rel_venv="$(perl -le 'use File::Spec; print File::Spec->abs2rel(@ARGV)' $CONDA_PREFIX $pwd)"
        echo "($rel_venv) "
    fi
}
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PS1="\[\e[1;35m\]\u@\h \[\e[0;35m\]\w \[\e[0;36m\]\$(parse_git_branch)\[\e[0;33m\]\$(parse_python_venv)\[\e[0;35m\]$ \[\e[m\]"

# Arrows and C-p/C-n search from current command
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward'  2>/dev/null
bind '"\C-p": history-search-backward' 2>/dev/null
bind '"\C-n": history-search-forward'  2>/dev/null

# Bash aliases
alias cp="cp -i" # ask before overwriting
alias e="emacs --no-window-system"
alias ev="emacs --eval \"(add-hook 'find-file-hook (defun make-read-only () (setq buffer-read-only t)))\"" # open in read-only mode
alias grep='grep --binary-files=without-match --color=auto --ignore-case --line-number'
alias la="ls -a"
alias ld="ls -d */"
alias ll="ls -l -h"
alias mv="mv -i" # ask before overwriting
alias mytop="top -user $USER"

# Show directory names in light blue
export LS_COLORS=$LS_COLORS'di=1;34:'

# OS-specific command aliases
case $OSTYPE in
    darwin*) # MacOS
        alias less="less --mouse --raw-control-chars"

        # -G = enable colorized output, equivalent to defining COLORTERM (set to "" above) and setting --color=auto
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
        alias less="less --raw-control-chars"
        alias ls="ls --color=auto --group-directories-first"
        ;;
    *) ;;
esac

# Git aliases
alias ga="git add"
alias gap="git add --patch"
alias gb="git branch"
alias gch="git checkout"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gd="git diff"
alias gg="git grep"
alias gpo="git push origin"
alias gri="git rebase --interactive"
alias gs="git status"
alias gu="git unstage"

function gdt {
    if [ $# -eq 0 ]; then
        # If no arguments passed in, diff all modified files in sequence
        git difftool `git ls-files --modified $DIR`
    else
        git difftool "$@"
    fi
}
function gmt {
    if [ $# -eq 0 ]; then
        # If no arguments passed in, merge all unmerged files in sequence
        git mergetool `git ls-files --unmerged $DIR`
    else
        git mergetool "$@"
    fi
}

# Python aliases
alias pip="python -m pip"

activate_python_venv() {
    venv_dir=${1:-"venv"}
    if [ -f "$venv_dir/bin/activate" ]; then
        source "$venv_dir/bin/activate"
        venv_path="$(realpath $venv_dir)"
        echo "Activated Python virtual environment at $venv_path"
    else
        echo "No Python virtual environment found at $venv_dir"
    fi
}
deactivate_python_venv() {
    deactivate
}

# Stop graphical display popup for password when git pushing
unset SSH_ASKPASS

# Set default file-creation mode to u=rwx, g=rwx, o=rx
# Check your (human-readable) permissions using "umask -S"
umask 0002

# Source system-specific aliases
source ~/.bashrc-local
