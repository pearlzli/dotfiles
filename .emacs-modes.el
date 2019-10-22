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
(load "markdown-mode.el")
(autoload 'gfm-mode "gfm-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(add-hook 'markdown-mode-hook
          (lambda()
            (local-unset-key (kbd "M-n"))   ; M-n and M-p redefined in .emacs
            (local-unset-key (kbd "M-p")))) ; https://stackoverflow.com/a/19324726/2756250

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
(xclip-mode 1) ; let emacs use clipboard
(define-key ado-mode-map (kbd "C-c C-c") 'ado-send-command-to-stata)
(define-key ado-mode-map (kbd "C-c C-a") 'ado-send-buffer-to-stata)

;; ESS (R only)
(add-to-list 'load-path "~/.emacs.d/ESS/lisp")
(require 'ess-r-mode)
