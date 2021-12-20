(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/"))
(when (version< emacs-version "26.3")
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))
(package-refresh-contents)

(mapcar (lambda (package)
         ; Install package if not already installed
         (unless (package-installed-p package)
           (package-install package)))

        ; List of packages to be installed (separated by linebreaks)
        '(auctex
          bind-key
          cl-lib
          ein
          ess
          gitconfig-mode
          gitignore-mode
          julia-mode
          markdown-mode
          matlab-mode
          pandoc-mode
          unfill
          xclip))
