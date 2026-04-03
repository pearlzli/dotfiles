(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (version< emacs-version "26.3")
  ; Fix "Failed to download 'melpa' archive" error
  ; https://melpa.org/#/getting-started (under "Known Issues")
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

  ; Fix "Failed to download 'gnu' archive" error
  ; https://stackoverflow.com/a/58236306
  ; https://elpa.gnu.org/packages/gnu-elpa-keyring-update.html
  (unless (package-installed-p 'gnu-elpa-keyring-update)
    (setq package-check-signature nil)
    (package-install 'gnu-elpa-keyring-update)
    (setq package-check-signature t)))

(package-refresh-contents)

; Install packages that aren't already installed
; https://stackoverflow.com/a/39891192
; Don't automatically add packages installed by this script to package-selected-packages
(advice-add 'package--save-selected-packages :override #'ignore)
(dolist (pkg '(auctex
               beacon
               bind-key
               cl-lib
               csv-mode
               ess
               git-modes
               julia-mode
               markdown-mode
               pandoc-mode
               unfill
               xclip
               yaml-mode))
  (unless (package-installed-p pkg)
    (condition-case err
        (package-install pkg)
      (error (message "Skipping %s: %s" pkg (error-message-string err))))))
(advice-remove 'package--save-selected-packages #'ignore)
