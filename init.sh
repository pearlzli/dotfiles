#!/bin/bash

### 1. Link dotfiles

cd ~
for file in ".bashrc" ".tmux.conf" ".emacs" ".emacs-modes.el" ".gitconfig"; do
    ln -s "dotfiles/$file" "$file"
    echo "Linked $file"
done

# Create local dotfiles if they don't already exist
for file in ".bashrc-local" ".gitconfig-local"; do
    if [ ! -f $file ]; then
        touch $file
        echo "Created $file"
    fi
done


### 2. Clone necessary packages into .emacs.d

if [ ! -d "~/.emacs.d" ]; then
    mkdir "~/.emacs.d"
    echo "Created .emacs.d"
fi

cd "~/.emacs.d"

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