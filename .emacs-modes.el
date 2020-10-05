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
(setq markdown-asymmetric-header t)
(setq markdown-enable-math t)
(add-hook 'markdown-mode-hook 'pandoc-mode)

;; Pandoc
;; Notes on pandoc-{revert,load-default}-settings:
;; - In theory, load-default should look for local settings first, then global settings
;; - In practice, only global settings are read, so need to call revert
;; - Must add hooks in (revert, load-default) order so that they're run in (load-default, revert) order
(setq pandoc-data-dir "~/dotfiles/pandoc-mode")
(setq pandoc-pdf-viewer "skim")
(add-hook 'pandoc-mode-hook 'pandoc-revert-settings)       ; see notes above
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings) ;

;; Python
(setq python-indent-guess-indent-offset-verbose nil) ; https://stackoverflow.com/a/51966682/2756250

;; MATLAB
(setq matlab-indent-function t)

;; Stata
(add-to-list 'load-path "~/.emacs.d/ado-mode/lisp")
(autoload 'ado-mode "ado-mode" "Stata mode (ado-mode)" t)
(setq auto-mode-alist (cons '("\\.do$" . ado-mode) auto-mode-alist))
(setq ado-close-under-line-flag nil) ; indent close brace at same indent level as open brace
(setq ado-tab-width 4)
(with-eval-after-load 'ado-mode
  (define-key ado-mode-map (kbd "C-c C-c") 'ado-send-command-to-stata)
  (define-key ado-mode-map (kbd "C-c C-a") 'ado-send-buffer-to-stata)
  (define-key ado-mode-map (kbd "TAB") 'ado-indent-region) ; default is ado-indent-line
  (unless (executable-find "xclip")
    (display-warning 'initialization "xclip not found; can't use ado-send-{command,buffer}-to-stata")))
