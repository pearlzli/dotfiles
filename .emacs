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

;; row and column numbers
(setq column-number-mode t)

;; Markdown
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(load "~/.emacs.d/cl-lib-0.4.el")
(load "markdown-mode.el")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

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
