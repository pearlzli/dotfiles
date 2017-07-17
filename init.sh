#!/bin/bash


### 0. init.sh Setup

# Colors: see https://stackoverflow.com/questions/2924697/how-does-one-output-bold-text-in-bash
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)


### 1. Link dotfiles

cd $HOME

# Create symlinks
thisdir=$(dirname $0)
for file in ".bashrc" ".tmux.conf" ".emacs" ".emacs-modes.el" ".gitconfig"; do
    ln -s "$thisdir/$file" $file
    echo "Linked $file"
done

# Create local dotfiles if they don't already exist
for file in ".bashrc-local" ".gitconfig-local"; do
    if [ ! -f $file ]; then
        touch $file
        echo "${green}Created $file${normal}"
    fi
done


### 2. Clone necessary packages into .emacs.d

# Create .emacs.d if it doesn't already exist
if [ ! -d "$HOME/.emacs.d" ]; then
    mkdir "$HOME/.emacs.d"
    echo "${green}Created .emacs.d${normal}"
fi

cd "$HOME/.emacs.d"

# cl-lib
wget "https://elpa.gnu.org/packages/cl-lib-0.5.el"

# Git
git clone "https://github.com/magit/git-modes.git"

# Julia
git clone "https://github.com/JuliaEditorSupport/julia-emacs.git"

# Markdown
git clone "https://github.com/defunkt/markdown-mode.git"

# MATLAB
wget "matlab-emacs.cvs.sourceforge.net/viewvc/matlab-emacs/matlab-emacs/?view=tar"
tar -zxvf "matlab-emacs?view\=tar"
rm "matlab-emacs?view=tar"