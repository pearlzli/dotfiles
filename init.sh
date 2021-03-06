#!/bin/bash

# init.sh
#   Initialize (nearly) everything for a new machine. Install Homebrew (and
#   use it to install other things) if on OS X, link dotfiles, and install
#   Emacs packages.
#
#   Usage:
#     ./init.sh path/to/dotfile/repo


### 0. init.sh Setup

# Colors
# https://stackoverflow.com/questions/2924697/how-does-one-output-bold-text-in-bash
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)

# Location of dotfiles repo
if [ -z "$1" ]; then
    echo "${red}Run script using ./init.sh path/to/dotfiles/repo${normal}"
    exit 1
fi
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
# Usage: try_symlink <src> <dst=src>
# Performs: ln -s "$dotfile_dir/$src" "$(pwd)/$dst"
# See https://stackoverflow.com/a/33419280 for reference on bash optional arguments
try_symlink() {
    src=$1
    dst=${2:-$src}
    if [ -L "$dst" ]; then
        echo "${red}Did not link $(pwd)/$dst: symlink already exists${normal}"
    elif [ ! -f "$src" ]; then
        ln -s "$dotfile_dir/$src" "$dst"
        if [ $? -eq 0 ]; then
            echo "${green}Linked $(pwd)/$dst -> $dotfile_dir/$src${normal}"
        else
            echo "${red}Could not link $(pwd)/$dst${normal}"
        fi
    else
        echo "${red}Did not link $dst: non-symlink file already exists. Merge $dst into $dotfile_dir/$src first and then delete $dst before retrying${normal}"
    fi
}

# Add to PATH environment variable verbosely
# Usage: try_addpath <dir> <front>
try_addpath() {
    dir=$1
    front=$2 # whether to add dir to front of PATH
    if [ -z "$(grep $dir ~/.bashrc-local)" ]; then
        if [ $front -eq 1 ]; then
            echo "export PATH=$dir:\$PATH" >> ~/.bashrc-local
        else
            echo "export PATH=\$PATH:$dir" >> ~/.bashrc-local
        fi
        if [ $? -eq 0 ]; then
            echo "${green}Added $dir to PATH in ~/.bashrc-local${normal}"
        else
            echo "${red}Could not add $dir to PATH in ~/.bashrc-local${normal}"
        fi
    else
        echo "${red}Did not add $dir to PATH in ~/.bashrc-local: already there${normal}"
    fi
}

# Length of time before timing out
timeout_length="30s"

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

        brew install rename
        brew install coreutils
        brew install emacs
        brew install pandoc
        brew install tmux
        brew install wget
        brew install --cask mactex
        brew install --cask meld
        brew install --cask anaconda

        # The following are easier to build using Brew than in Julia
        brew install gcc   # HDF5.jl
        brew install cmake # Polynomials.jl

        # Add to PATH
        try_addpath "/Library/TeX/texbin" 0
        try_addpath "/usr/local/anaconda3/bin" 1

        # Copy SF Mono font for use in non-Terminal apps (symlinking doesn't seem like enough)
        # https://osxdaily.com/2018/01/07/use-sf-mono-font-mac/
        # https://apple.stackexchange.com/a/376828
        cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/SFMono-*.otf ~/Library/Fonts
        if [ $? -eq 0 ]; then
            echo "${green}Copied SF Mono font files to ~/Library/Fonts${normal}"
        else
            echo "${red}Could not copy SF Mono font files to ~/Library/Fonts${normal}"
        fi

        # Use SF Mono in Meld
        # https://github.com/yousseb/meld/issues/38#issuecomment-547577592
        defaults write org.gnome.meld "/org/gnome/meld/use-system-font" 0
        defaults write org.gnome.meld "/org/gnome/meld/custom-font" "SF Mono, 14"
        if [ $? -eq 0 ]; then
            echo "${green}Set SF Mono as Meld font${normal}"
        else
            echo "${red}Could not set SF Mono as Meld font${normal}"
        fi

        # Copy Mac key bindings
        maybe_mkdir ~/Library/KeyBindings
        cp "$dotfile_dir/DefaultKeyBinding.dict" ~/Library/KeyBindings

        # Symlink AppleScripts
        cd /Applications
        try_symlink "applescripts/emacs-nw.app" "emacs -nw.app"
        cd ~/Library/Services
        try_symlink "applescripts/desktop-alias.workflow" "Make Desktop alias.workflow"

        my_timeout="gtimeout $timeout_length"
        ;;

    *)
        my_timeout="timeout $timeout_length"
        ;;
esac


### 2. Link dotfiles

cd $HOME

# Create symlinks
for file in ".bashrc" ".tmux.conf" ".emacs" ".emacs-modes.el" ".gitconfig" ".Xmodmap" ".Xdefaults"; do
    try_symlink $file
done

# Create local dotfiles if they don't already exist
for file in ".bashrc-local" ".gitconfig-local"; do
    if [ ! -f $file ]; then
        touch $file
        echo "${green}Created $file${normal}"
    fi
done

# Julia startup
maybe_mkdir ~/.julia/config
cd ~/.julia/config
try_symlink startup.jl

# Stata startup
maybe_mkdir ~/Documents/Stata
cd ~/Documents/Stata
try_symlink profile.do

# TeX files
cd $dotfile_dir
texfiles=$(find tex/latex -name *.cls -o -name *.sty)
bstfiles=$(find bibtex/bst -name *.bst)

if not_installed kpsewhich; then
    echo "${red}Didn't link TeX files: make sure /Library/TeX/texbin is in PATH and re-run init.sh${normal}"
else
    texdir=$(kpsewhich -var-value=TEXMFHOME)
    maybe_mkdir "$texdir"

    # Style and class files
    maybe_mkdir "$texdir/tex/latex"
    cd $texdir
    for file in $texfiles; do
        try_symlink $file
    done

    # Bibliography style files
    maybe_mkdir "$texdir/bibtex/bst"
    cd $texdir
    for file in $bstfiles; do
        try_symlink $file
    done

    # kbordermatrix package
    cd "$texdir/tex/latex"
    wget "http://mirrors.concertpass.com/tex-archive/macros/generic/misc/kbordermatrix.sty"
    echo "${green}Installed kbordermatrix.sty${normal}"
fi

# Pandoc templates
maybe_mkdir "$HOME/.pandoc"
maybe_mkdir "$HOME/.pandoc/templates"
cd ~/.pandoc/templates
try_symlink pandoc/templates/GitHub.html5 GitHub.html5


### 3. Clone emacs and tmux packages, timing out after $timeout_length if necessary

cd $HOME

# Create .emacs.d if it doesn't already exist
maybe_mkdir "$HOME/.emacs.d"
maybe_mkdir "$HOME/.emacs.d/backup"

cd "$HOME/.emacs.d"

# Install emacs packages from package manager
emacs --script "$dotfile_dir/elpa-install.el"

# Emacs Stata mode
$my_timeout git clone "https://github.com/louabill/ado-mode.git"
timeout_result $? "ado-mode"

# Pandoc filters
pip install --user pandoc-eqnos

# Tmux plugin manager
if not_installed tmux; then
    echo "${red}Didn't install tmux plugin manager: make sure tmux is installed and re-run init.sh${normal}"
else
    if [ $(echo "$TMUX_VERSION >= 1.9" | bc) -eq 1 ]; then
        $my_timeout git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    else
        echo "${red}Didn't install tmux plugin manager: need at least tmux version 1.9${normal}"
    fi
fi
