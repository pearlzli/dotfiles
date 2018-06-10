#!/bin/bash

# init.sh
#   Initialize (nearly) everything for a new machine. Install Homebrew (and
#   use it to install other things) if on OS X, link dotfiles, and install
#   Emacs packages.
#
#   Usage:
#     ./init.sh path/to/dotfile/repo


### 0. init.sh Setup

# Location of dotfiles repo
dotfile_dir=$1

# Check if something is installed
# Usage: not_installed <program>
not_installed() {
  if [[ -n "$(which $1)" ]]; then
    return 1
  else
    return 0
  fi
}

# Colors
# https://stackoverflow.com/questions/2924697/how-does-one-output-bold-text-in-bash
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)

# Make directory if it doesn't already exist
# Usage: maybe_mkdir <path>
maybe_mkdir() {
    if [ ! -d "$1" ]; then
        mkdir -p $1
        if [ $? -eq 0 ]; then
            echo "${green}Created $1${normal}"
        else
            echo "${red}Could not create $1${normal}"
        fi
    fi
}

# Create symlinks verbosely
# Usage: try_symlink <file>
try_symlink() {
    if [ -L $1 ]; then
        echo "${red}Did not link $1: symlink already exists${normal}"
    elif [ ! -f $1 ]; then
        ln -s "$dotfile_dir/$1" $1
        if [ $? -eq 0 ]; then
            echo "${green}Linked $1${normal}"
        else
            echo "${red}Could not link $1${normal}"
        fi
    else
        echo "${red}Did not link $1: non-symlink file already exists. Merge $1 into $dotfile_dir/$1 first and then delete $1 before retrying${normal}"
    fi

}

# Length of time before timing out
timeout_length="2s"

# Print result of timeout downloading
# Usage: timeout_result <retcode> <filename>
function timeout_result {
    if [ $1 -eq 124 ]; then
        echo "${red}Killed downloading $2: timed out${normal}"
    elif [ $1 -ne 0 ]; then
        echo "${red}Could not download $2${normal}"
    else
        echo "${green}Successfully downloaded $2${normal}"
    fi
}


### 1. Install Mac-specific things

case $OSTYPE in
    darwin*) # OS X
        if not_installed brew; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

        brew install coreutils
        brew install emacs
        brew install tmux
        brew install wget
        brew cask install julia

        brew cask install mactex
        if [ -z "$(grep texbin ~/.bashrc-local)" ]; then
            echo "export PATH=\$PATH:/Library/TeX/texbin" >> ~/.bashrc-local
            if [ $? -eq 0 ]; then
                echo "${green}Added TeX Live binaries to PATH in ~/.bashrc-local${normal}"
            else
                echo "${red}Could not add TeX Live binaries to PATH in ~/.bashrc-local${normal}"
            fi
        else
            echo "${red}Did not add TeX Live binaries to PATH in ~/.bashrc-local: already there${normal}"
        fi

        my_timeout=gtimeout
        ;;

    *)
        my_timeout=timeout
        ;;
esac


### 2. Link dotfiles

cd $HOME

# Create symlinks
for file in ".bashrc" ".tmux.conf" ".emacs" ".emacs-modes.el" ".gitconfig"; do
    try_symlink $file
done

# Create local dotfiles if they don't already exist
for file in ".bashrc-local" ".gitconfig-local"; do
    if [ ! -f $file ]; then
        touch $file
        echo "${green}Created $file${normal}"
    fi
done

# Create symlinks for TeX files
cd $dotfile_dir
texfiles=$(find tex/latex -mindepth 1)

if not_installed kpsewhich; then
    echo "${red}Didn't link TeX files: make sure /Library/TeX/texbin is in PATH and re-run init.sh${normal}"
else
    texdir=$(kpsewhich -var-value=TEXMFHOME)
    maybe_mkdir "$texdir"
    maybe_mkdir "$texdir/tex/latex"

    cd $texdir
    for file in $texfiles; do
        try_symlink $file
    done
end

### 3. Clone necessary packages into .emacs.d, timing out after $timeout_length if necessary

cd $HOME

# Create .emacs.d if it doesn't already exist
maybe_mkdir "$HOME/.emacs.d"
maybe_mkdir "$HOME/.emacs.d/backup"

cd "$HOME/.emacs.d"

# cl-lib
if [ ! -f "cl-lib-0.5.el" ]; then
   $my_timeout $timeout_length wget "https://elpa.gnu.org/packages/cl-lib-0.5.el"
   timeout_result $? "cl-lib"
fi

# Git
$my_timeout $timeout_length git clone "https://github.com/magit/git-modes.git"
timeout_result $? "git-modes"

# Julia
$my_timeout $timeout_length git clone "https://github.com/JuliaEditorSupport/julia-emacs.git"
timeout_result $? "julia-emacs"

# Markdown
$my_timeout $timeout_length git clone "https://github.com/defunkt/markdown-mode.git"
timeout_result $? "markdown-mode"

# MATLAB
$my_timeout $timeout_length git clone "https://git.code.sf.net/p/matlab-emacs/src" "matlab-emacs"
timeout_result $? "matlab-emacs"
