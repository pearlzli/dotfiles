# dotfiles

Configuration files for bash, emacs, git, tmux, etc.

## Setup

To set up a new machine:

1. If on MacOS: import [prefs.terminal](https://github.com/pearlzli/dotfiles/blob/master/prefs.terminal). Otherwise, fiddle with the terminal colors (see [colors.md](https://github.com/pearlzli/dotfiles/blob/master/colors.md)) and font (either Consolas or Deja Vu Sans Mono) yourself.

2. If necessary, generate SSH key (`ssh-keygen`) and add public key to [Github](https://github.com/settings/keys).

3. If on MacOS, [install Command-Line Tools without XCode](https://apple.stackexchange.com/a/372486).

4. Clone this repo **using the SSH protocol** (or else you'll have to type in your password to push later).

5. Run `./init.sh path/to/dotfile/repo`. (If necessary, `chmod init.sh u+x` first.)

6. Add things to .bashrc-local, like aliases and environment variables.

7. If desired and on MacOS, set up [keyboard shortcuts](https://support.apple.com/lt-lt/guide/mac-help/mchlp2271/mac) and [text replacements](https://support.apple.com/guide/mac-help/back-up-and-share-text-replacements-on-mac-mchl2a7bd795/mac).

8. Install [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=en) Chrome extension and copy [vimium-mappings.md](https://github.com/pearlzli/dotfiles/blob/master/vimium-mappings.md) into custom key mappings. If on MacOS, [check the "Ignore keyboard layout" advanced setting](https://github.com/philc/vimium/issues/3197#issuecomment-614829140) in order to use mappings involving the meta key.

## Branches

- `master`
- `pre-emacs-24.4`: replaces `with-eval-after-load` ([introduced in Emacs 24.4](https://stackoverflow.com/a/21880276/2756250)) with `eval-after-load`

## Attribution

Thanks to [Matt Cocci](https://github.com/MattCocci/ConfigurationTemplates), [Micah Smith](https://github.com/micahjsmith/dotfiles), and [Erica Moszkwoski](https://github.com/emoszkowski/configFiles) for much of this stuff.
