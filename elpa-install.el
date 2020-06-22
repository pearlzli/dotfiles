(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(mapcar (lambda (package)
         ; Install package if not already installed
         (unless (package-installed-p package)
           (package-install package)))

        ; List of packages to be installed (separated by linebreaks)
        '(auctex
          cl-lib
          xclip))
