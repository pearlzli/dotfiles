# dotfiles

Configuration files for bash, emacs, git, tmux, etc.

## Setup

To set up a new machine:

1. If on OS X, import [prefs.terminal](https://github.com/pearlzli/dotfiles/blob/master/prefs.terminal). Otherwise, fiddle with the terminal colors (see [colors.md](https://github.com/pearlzli/dotfiles/blob/master/colors.md)) and font (either Consolas or Deja Vu Sans Mono) yourself.

2. If necessary, generate SSH key (`ssh-keygen`) and add public key to [Github](https://github.com/settings/keys).

3. Clone this repo **using the SSH protocol** (or else you'll have to type in your password to push later).

4. Run `./init.sh path/to/dotfile/repo`. (If necessary, `chmod init.sh u+x` first.)

5. Add things to .bashrc-local, like aliases and environment variables.

6. If desired and on OS X, set up SSHFS:
   * `brew install --cask osxfuse`
   * Restart computer (this step is why this isn't in init.sh)
   * `brew install sshfs`
   * `sshfs username@hostname:remotedir localdir` to mount
   * `umount localdir` to unmount

7. If desired and on OS X, [set up text replacements](https://support.apple.com/guide/mac-help/back-up-and-share-text-replacements-on-mac-mchl2a7bd795/mac)

## Attribution

Thanks to [Matt Cocci](https://github.com/MattCocci/ConfigurationTemplates), [Micah Smith](https://github.com/micahjsmith/dotfiles), and [Erica Moszkwoski](https://github.com/emoszkowski/configFiles) for much of this stuff.
