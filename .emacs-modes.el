;; outline-minor-mode and outline-magic (LaTeX)
;; https://emacs.stackexchange.com/questions/361/how-can-i-hide-display-latex-section-just-like-org-mode-does-with-headlines
;; https://emacs.stackexchange.com/questions/13426/auctex-doesnt-run-bibtex
(add-hook 'LaTeX-mode-hook #'outline-minor-mode)
(add-to-list 'load-path "~/.emacs.d/outline-magic")
(add-hook 'outline-mode-hook
          (lambda ()
            (require 'outline-cycle)))
(add-hook 'outline-minor-mode-hook
          (lambda ()
            (require 'outline-magic)
            (define-key outline-minor-mode-map  (kbd "C-c TAB") 'outline-cycle)))
(setq TeX-parse-self t) ; run bibtex on C-c C-c
(setq TeX-auto-save t)  ;

;; Git
(add-to-list 'load-path "~/.emacs.d/git-modes")
(autoload 'gitconfig-mode "gitconfig-mode"
  "Major mode for editing .gitconfig files" t)
(add-to-list 'auto-mode-alist '("\\.gitconfig\\'" . gitconfig-mode))
(autoload 'gitignore-mode "gitignore-mode"
  "Major mode for editing .gitignore files" t)
(add-to-list 'auto-mode-alist '("\\.gitignore\\'" . gitignore-mode))

;; Markdown
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(load "~/.emacs.d/elpa/cl-lib-0.6.1/cl-lib.el")
(load "markdown-mode.el")
(autoload 'gfm-mode "gfm-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

;; Julia
(add-to-list 'load-path "~/.emacs.d/julia-emacs")
(require 'julia-mode)

;; MATLAB
(add-to-list 'load-path "~/.emacs.d/matlab-emacs")
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist))
(defun my-matlab-mode-hook ()
  "Custom MATLAB hook"
  (setq matlab-indent-function t) ; function bodies indented
  (setq fill-column 80) ; where auto-fill should wrap
  (turn-on-auto-fill)
  (setq matlab-comment-region-s "% "))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)
(defun my-matlab-shell-mode-hook ()
  '())
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(add-hook 'matlab-mode-hook (lambda () (local-set-key "\M-;" nil)))
(add-hook 'matlab-mode-hook (lambda () (local-set-key "\M-q" nil)))

;; Stata
(add-to-list 'load-path "~/.emacs.d/ado-mode/lisp")
(require 'ado-mode)
