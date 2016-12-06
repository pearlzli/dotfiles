;; user details
(setq user-full-name "Pearl Li")
(setq user-mail-address "pearlzli16@gmail.com")

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)

;; line numbers
(global-linum-mode t)
(setq linum-format "%4d ")
(global-set-key (kbd "C-x l") 'linum-mode) ; toggle linum-mode for tmux copy-paste

;; symlinks
(setq vc-follow-symlinks nil)

;; default to unified diffs
(setq diff-switches "-u")

;; unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style (quote post-forward-angle-brackets))

;; mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

;; backup files
(setq backup-directory-alist
      `((".*" . , "~/.emacs.d/backup/")))
(setq auto-save-file-name-transforms
      `((".*" , "~/.emacs.d/backup/" t)))
(setq auto-save-list-file-prefix nil)

;; row and column numbers
(setq column-number-mode t)

;; set default max line width
(setq-default fill-column 80)

;; increment and decrement numbers
(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))
(defun my-decrement-number-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))
(global-set-key (kbd "C-c =") 'my-increment-number-decimal)
(global-set-key (kbd "C-c -") 'my-decrement-number-decimal)

;; unbind C-o (insertline, but I use C-o as my tmux prefix)
(global-unset-key (kbd "C-o"))

;; trailing whitespace
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "color-167") ; red
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; highlight matching parentheses
(show-paren-mode t)
(setq show-paren-delay 0)
(set-face-background 'show-paren-match "brightblack")
(set-face-background 'show-paren-mismatch "color-167") ; red

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
(load "~/.emacs.d/cl-lib-0.5.el")
(load "markdown-mode.el")
(autoload 'gfm-mode "gfm-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

;; Julia
(add-to-list 'load-path "~/.emacs.d/julia-emacs")
(require 'julia-mode)

;; colors
(set-face-attribute 'region nil :inverse-video t)
(set-face-foreground font-lock-builtin-face "brightmagenta")
(set-face-foreground font-lock-comment-face "color-35") ; forest green
(set-face-foreground font-lock-constant-face "brightcyan")
(set-face-foreground font-lock-function-name-face "blue")
(set-face-foreground font-lock-keyword-face "brightblue")
(set-face-foreground font-lock-string-face "color-167") ; red
(set-face-foreground font-lock-type-face "brightcyan")
(set-face-foreground 'linum "brightblack")
(set-face-foreground 'minibuffer-prompt "brightblue")

;; load system-specific settings
(setq custom-file "~/.emacs-local.el")
(load custom-file)
