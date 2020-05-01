;; Diff mode
(with-eval-after-load 'diff-mode
  (set-face-foreground 'diff-context "brightblack")
  (set-face-background 'diff-added "green")
  (set-face-background 'diff-changed "yellow")
  (set-face-background 'diff-removed "brightred")
  (set-face-attribute 'diff-refine-added nil :inherit 'diff-added)
  (set-face-attribute 'diff-refine-changed nil :inherit 'diff-changed)
  (set-face-attribute 'diff-refine-removed nil :inherit 'diff-removed))

;; LaTeX
(with-eval-after-load 'font-latex
  (set-face-attribute 'font-latex-sectioning-5-face nil :foreground "magenta" :weight 'bold)
  (set-face-foreground 'font-latex-bold-face "brightred")
  (set-face-foreground 'font-latex-italic-face "brightred")
  (set-face-foreground 'font-latex-math-face "brightyellow"))

(setq TeX-parse-self t) ; make AUCTeX run bibtex
(setq TeX-auto-save t)  ; https://emacs.stackexchange.com/a/13870/14500
(defun my-TeX-auto-generate ()
  "Auto-generate and reapply style hooks"
  (TeX-auto-generate "~/dotfiles/tex/latex" "~/dotfiles/tex/latex/auto") ; https://tex.stackexchange.com/a/410552/116532
  'TeX-normal-mode) ; https://www.gnu.org/software/auctex/manual/auctex/Parsing-Files.html
(setq LaTeX-beamer-item-overlay-flag nil) ; don't ask for itemize overlay in Beamer (https://emacs.stackexchange.com/a/7573/14500)

(setq reftex-extra-bindings t) ; use more intuitive key bindings (must be defined before loading RefTeX)
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-default-bibliography '("~/Drive/research/papers/library.bib")) ; set default bib file (https://tex.stackexchange.com/a/54825/116532)

;; Git
(add-to-list 'load-path "~/.emacs.d/git-modes")
(add-to-list 'auto-mode-alist '("\\.gitconfig\\'" . gitconfig-mode))
(add-to-list 'auto-mode-alist '("\\.gitignore\\'" . gitignore-mode))
(autoload 'gitconfig-mode "gitconfig-mode" "Major mode for editing .gitconfig files" t)
(autoload 'gitignore-mode "gitignore-mode" "Major mode for editing .gitignore files" t)

;; Markdown
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(load "markdown-mode.el")
(autoload 'gfm-mode "gfm-mode" "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(setq markdown-asymmetric-header t)
(setq markdown-enable-math t)
(defun my-markdown-mode-hook ()
  "Custom Markdown hook"
  (local-unset-key (kbd "M-n"))  ; I redefined M-n and M-p in .emacs
  (local-unset-key (kbd "M-p"))) ; https://stackoverflow.com/a/19324726/2756250
(add-hook 'markdown-mode-hook 'my-markdown-mode-hook)

;; Julia
(add-to-list 'load-path "~/.emacs.d/julia-emacs")
(require 'julia-mode)

;; MATLAB
(add-to-list 'load-path "~/.emacs.d/matlab-emacs")
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist))
(setq matlab-indent-function t)
(setq matlab-comment-region-s "% ")
(defun my-matlab-mode-hook ()
  "Custom MATLAB hook"
  (turn-on-auto-fill)
  (setq fill-column 80)
  (local-set-key "\M-;" nil)
  (local-set-key "\M-q" nil))
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)

;; Stata
(add-to-list 'load-path "~/.emacs.d/ado-mode/lisp")
(autoload 'ado-mode "ado-mode" "Stata mode (ado-mode)" t)
(setq auto-mode-alist (cons '("\\.do$" . ado-mode) auto-mode-alist))
(with-eval-after-load 'ado-mode
  (setq ado-close-under-line-flag nil) ; indent close brace at same indent level as open brace
  (setq ado-tab-width 4)
  (define-key ado-mode-map (kbd "C-c C-c") 'ado-send-command-to-stata)
  (define-key ado-mode-map (kbd "C-c C-a") 'ado-send-buffer-to-stata)
  (define-key ado-mode-map (kbd "TAB") 'ado-indent-region)) ; default is ado-indent-line

;; ESS (R only)
(add-to-list 'load-path "~/.emacs.d/ESS/lisp")
(require 'ess-r-mode)
