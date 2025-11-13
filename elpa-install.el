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

(mapcar (lambda (package)
         ; Install package if not already installed
         (unless (package-installed-p package)
           (package-install package)))

        ; List of packages to be installed (separated by linebreaks)
        '(auctex
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
          xclip))
