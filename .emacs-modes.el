;; Diff mode
(with-eval-after-load 'diff-mode
  (set-face-foreground 'diff-context "brightblack")
  (set-face-background 'diff-added "green")
  (set-face-background 'diff-changed "yellow")
  (set-face-background 'diff-removed "brightred")
  (set-face-attribute 'diff-refine-added nil :inherit 'diff-added)
  (set-face-attribute 'diff-refine-changed nil :inherit 'diff-changed)
  (set-face-attribute 'diff-refine-removed nil :inherit 'diff-removed))

;; SMerge mode
(with-eval-after-load 'smerge-mode
  (set-face-background 'smerge-markers "brightblack")
  (set-face-attribute 'smerge-lower nil :inherit 'diff-added :background nil)
  (set-face-attribute 'smerge-upper nil :inherit 'diff-removed :background nil)
  (set-face-attribute 'smerge-refined-added nil :inherit 'diff-added :background nil)
  (set-face-attribute 'smerge-refined-changed nil :inherit 'diff-changed :background nil)
  (set-face-attribute 'smerge-refined-removed nil :inherit 'diff-removed) :background nil)

;; LaTeX
(with-eval-after-load 'font-latex
  (set-face-attribute 'font-latex-sectioning-5-face nil :foreground "magenta" :weight 'bold)
  (set-face-foreground 'font-latex-bold-face "brightred")
  (set-face-foreground 'font-latex-italic-face "brightred")
  (set-face-foreground 'font-latex-math-face "brightyellow"))
(with-eval-after-load 'latex
  (add-to-list 'LaTeX-font-list '(112 "" "" "\\paren{" "}"))  ; add font key bindings
  (add-to-list 'LaTeX-font-list '(98 "" "" "\\bracket{" "}")) ; https://tex.stackexchange.com/a/523728/116532
  (add-to-list 'LaTeX-font-list '(99 "" "" "\\curly{" "}")))  ; https://en.wikipedia.org/wiki/ASCII#Printable_characters

(setq TeX-parse-self t) ; make AUCTeX run bibtex
(setq TeX-auto-save t)  ; https://emacs.stackexchange.com/a/13870/14500
(setq TeX-date-format "%B %-d, %Y") ; Month D, YYYY (https://emacs.stackexchange.com/a/13046/14500)
(setq TeX-auto-private '("~/dotfiles/tex/latex/auto"))
(setq TeX-style-private '("~/dotfiles/tex/latex/auto"))
(setq LaTeX-beamer-item-overlay-flag nil) ; don't ask for itemize overlay in Beamer (https://emacs.stackexchange.com/a/7573/14500)
(setq bibtex-align-at-equal-sign t)
(defun my-TeX-auto-generate ()
  "Auto-generate and reapply style hooks"
  (TeX-auto-generate "~/dotfiles/tex/latex" "~/dotfiles/tex/latex/auto") ; https://tex.stackexchange.com/a/410552/116532
  'TeX-normal-mode) ; https://www.gnu.org/software/auctex/manual/auctex/Parsing-Files.html

(setq reftex-extra-bindings t) ; use more intuitive key bindings (must be defined before loading RefTeX)
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-default-bibliography '("~/Drive/research/papers/library.bib")) ; set default bib file (https://tex.stackexchange.com/a/54825/116532)
(setq reftex-plug-into-AUCTeX t)

;; Markdown
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(load "markdown-mode.el")
(autoload 'gfm-mode "gfm-mode" "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(setq markdown-asymmetric-header t)
(setq markdown-enable-math t)

;; Julia
(add-to-list 'load-path "~/.emacs.d/julia-emacs")
(add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))
(autoload 'julia-mode "julia-mode" "Julia mode" t)

;; Python
(setq python-indent-guess-indent-offset-verbose nil) ; https://stackoverflow.com/a/51966682/2756250

;; MATLAB
(add-to-list 'load-path "~/.emacs.d/matlab-emacs")
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist))
(setq matlab-indent-function t)
(setq matlab-comment-region-s "% ")
(with-eval-after-load 'matlab-mode
  (setq fill-column 80)
  (local-set-key "\M-;" nil)
  (local-set-key "\M-q" nil))

;; Stata
(add-to-list 'load-path "~/.emacs.d/ado-mode/lisp")
(autoload 'ado-mode "ado-mode" "Stata mode (ado-mode)" t)
(setq auto-mode-alist (cons '("\\.do$" . ado-mode) auto-mode-alist))
(setq ado-close-under-line-flag nil) ; indent close brace at same indent level as open brace
(setq ado-tab-width 4)
(with-eval-after-load 'ado-mode
  (define-key ado-mode-map (kbd "C-c C-c") 'ado-send-command-to-stata)
  (define-key ado-mode-map (kbd "C-c C-a") 'ado-send-buffer-to-stata)
  (define-key ado-mode-map (kbd "TAB") 'ado-indent-region)) ; default is ado-indent-line

;; ESS (R only)
(add-to-list 'load-path "~/.emacs.d/ESS/lisp")
(autoload 'ess-r-mode "ess-r-mode" "R mode (ESS)" t)
(setq auto-mode-alist (cons '("\\.r$" . ess-r-mode) auto-mode-alist))
