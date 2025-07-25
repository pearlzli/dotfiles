;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Add package archives (https://emacs.stackexchange.com/q/268/14500)
;; Marmalade discontinued (https://www.emacswiki.org/emacs/MarmaladeRepo)
;; Use MELPA mirror (https://emacs.stackexchange.com/a/61577/14500)
;; If version < 26.3, disable TLS1.3 (https://melpa.org/#/getting-started, under "Known issues")
(add-to-list 'package-archives '("melpa" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/"))
(when (version< emacs-version "26.3")
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BASIC EDITING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; User details
(setq user-full-name "Pearl Li")
(setq user-mail-address "pearlzli16@gmail.com")

;; Tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Don't prompt when opening a symlink
(setq vc-follow-symlinks nil)

;; Mouse support
(unless window-system
  (xterm-mouse-mode t)
  (bind-key* [mouse-4] (lambda () (interactive) (scroll-down 1)))
  (bind-key* [mouse-5] (lambda () (interactive) (scroll-up 1))))

;; Highlight cursor
(beacon-mode 1)
(setq beacon-size 40)
(bind-key* "M-o" 'beacon-blink)

;; Let emacs kill ring use clipboard
;; Nice to have in general; needed for sending commands to Stata in ado-mode
(when (cl-some 'executable-find
             '("xclip" ; X11
               "pbcopy" ; OS X
               "getclip")) ; Cygwin
  (xclip-mode t))

;; Comment current line if no active region
;; https://stackoverflow.com/a/9697222/2756250
(defun comment-or-uncomment-region-or-line ()
    "Comment or uncomment the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(bind-key* "M-;" 'comment-or-uncomment-region-or-line)

;; Indent/outdent current line/region with M-} and M-{
;; These key bindings were originally used for forward-paragraph and backward-paragraph
;; Would prefer M-] and M-[, but the latter is forbidden
;; https://emacs.stackexchange.com/a/48739/14500
(defun my-indent-region-or-line ()
  "Indent the region (or the current line if there's no active region) by 4 spaces."
  (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (indent-rigidly beg end 4)
        (setq deactivate-mark nil)))
(defun my-outdent-region-or-line ()
  "Outdent the region (or the current line if there's no active region) by 4 spaces."
  (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (indent-rigidly beg end -4)
        (setq deactivate-mark nil)))
(bind-key* "M-}" 'my-indent-region-or-line)
(bind-key* "M-{" 'my-outdent-region-or-line)

;; Move backup files to central location
;; https://stackoverflow.com/a/2680682/2756250
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; don't delink hardlinks
  version-control t      ; use version numbers on backups
  delete-old-versions t  ; automatically delete excess backups
  kept-new-versions 10   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )
(setq auto-save-file-name-transforms
      `((".*" , "~/.emacs.d/backup/" t)))
(setq auto-save-list-file-prefix nil)

;; Unbind C-o (insertline, but I use C-o as my tmux prefix)
(global-unset-key (kbd "C-o"))

;; Use C-u for undo
;; C-/ doesn't work on OS X (see https://github.com/bbatsov/prelude/issues/327)
(bind-key* "C-u" 'undo)

;; Use M-n and M-p to move forward and back 10 lines
;; Use M-F and M-B to move forward and back 20 characters
;; https://stackoverflow.com/a/2657587
(bind-key* "M-n" (lambda () (interactive) (next-line 10)))
(bind-key* "M-p" (lambda () (interactive) (previous-line 10)))
(bind-key* "M-F" (lambda () (interactive) (forward-char 20)))
(bind-key* "M-B" (lambda () (interactive) (backward-char 20)))

;; Use C-x h and C-x v to split windows horizontally and vertically, mirroring
;;   tmux key bindings
(global-unset-key (kbd "C-x 2")) ; formerly split-window-below
(global-unset-key (kbd "C-x 3")) ; formerly wplit-window-right
(bind-key* "C-x h" 'split-window-right)
(bind-key* "C-x v" 'split-window-below)

;; Load custom modes, e.g. Julia mode
(load "~/.emacs-modes.el")

;; Load local settings
(load "~/.emacs-local.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ADVANCED EDITING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Reload .emacs with C-x C-e (originally bound to eval-last-sexp)
(bind-key* "C-x C-e" (lambda () (interactive) (load-file "~/.emacs")))

;; Reload current file if buffer not modified
;; https://emacs.stackexchange.com/a/171/14500
;; Bind to C-x C-r (originally bound to find-file-read-only)
(defun revert-buffer-no-confirm ()
    "Revert buffer without asking for confirmation."
    (interactive)
    (progn
      (revert-buffer t (not (buffer-modified-p)) t)
      (message "Reloaded file %s" buffer-file-name)))
(bind-key* "C-x C-r" 'revert-buffer-no-confirm)

;; Rebind minibuffer history browsing to C-n and C-p (originally M-n and M-p)
;; https://www.emacswiki.org/emacs/MinibufferHistory
(define-key minibuffer-local-map (kbd "C-n") 'next-history-element)
(define-key minibuffer-local-map (kbd "C-p") 'previous-history-element)

;; Add missing rules to tex input method
;; https://www.emacswiki.org/emacs/TeXInputMethod
(with-temp-buffer
  (activate-input-method "TeX")
  (let ((quail-current-package (assoc "TeX" quail-package-alist)))
   (quail-define-rules ((append . t))
                       ("\\Phi" "Φ") ("\\bar" "̄") ("\\hi" "̅") ("\\lo" "̲"))))

;; Delete trailing whitespace upon saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Turn many spaces into just one space in a highlighted region
(defun just-one-space-in-region (beg end)
  "replace all whitespace in the region with single spaces"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward "\\s-+" nil t)
        (replace-match " ")))))
(global-set-key (kbd "C-x SPC") 'just-one-space-in-region)

;; Delete file and buffer
;; http://emacsredux.com/blog/2013/04/03/delete-file-and-buffer/
(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (if (yes-or-no-p "Really delete file and kill buffer? ")
            (progn
              (delete-file filename)
              (message "Deleted file %s" filename)
              (kill-buffer))
          (progn
            message "Did not delete file %s" filename))))))
(bind-key* "C-c D"  'delete-file-and-buffer)

;; Rename file and buffer
;; http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
(bind-key* "C-c R"  'rename-file-and-buffer)

;; Turn keymap numbers into key sequences
;; https://emacs.stackexchange.com/a/38518/14500
(defun keymap-number-to-char (number)
  "Display key sequence associated with keymap number."
  (interactive "sNumber: ")
  (message "Key is %s" (single-key-description (string-to-number number))))
(defun keymap-number-to-char-buffer (&optional undo)
  "Change keymap numbers in buffer to characters. For example, display 24 as C-x."
  (interactive "P")
  (if undo
      (remove-overlays nil nil 'chunyang-show-number-as-char t)
    (save-excursion
      (goto-char (point-min))
      (let (ov)
        (while (re-search-forward "[0-9]+" nil :no-error)
          (setq ov (make-overlay (match-beginning 0) (match-end 0)))
          (overlay-put ov 'display (single-key-description
                                    (string-to-number (match-string 0))))
          (overlay-put ov 'chunyang-show-number-as-char t))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DISPLAY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Highlight selections
(setq transient-mark-mode t)

;; Show row and column numbers in bottom bar
;; https://stackoverflow.com/a/43902887/2756250
(setq column-number-mode t)
(unless (version< emacs-version "26")
  (setq column-number-indicator-zero-based nil))

;; Show line numbers
;; Set default max line width to 80 characters
(global-display-line-numbers-mode 1)
(setq fill-column 80)
(defun toggle-line-numbers-and-fill-column-indicator ()
  "Toggle line numbers and fill column indicator for tmux copy-paste."
  (interactive)
  (display-line-numbers-mode 'toggle)
  (if (bound-and-true-p display-fill-column-indicator-in-mode)
      (display-fill-column-indicator-mode 'toggle)
      ()))
(bind-key* "C-x l" 'toggle-line-numbers-and-fill-column-indicator)

;; Unique buffer names, e.g. filename<dir1> and filename<dir2>
(require 'uniquify)
(setq uniquify-buffer-name-style (quote post-forward-angle-brackets))

;; Highlight matching and mismatched parentheses
(show-paren-mode t)
(setq show-paren-delay 0)

;; Highlight trailing whitespace
(setq-default show-trailing-whitespace t)

;; Colors
(set-face-attribute 'region nil :inverse-video t)
(set-face-background 'show-paren-match "brightblack")
(set-face-background 'show-paren-mismatch "red")
(set-face-background 'trailing-whitespace "brightred")
(set-face-foreground font-lock-builtin-face "brightmagenta")
(set-face-foreground font-lock-comment-face "green")
(set-face-foreground font-lock-constant-face "brightcyan")
(set-face-foreground font-lock-function-name-face "blue")
(set-face-foreground font-lock-keyword-face "brightblue")
(set-face-foreground font-lock-string-face "brightred")
(set-face-foreground font-lock-type-face "brightcyan")
(set-face-foreground font-lock-variable-name-face "yellow")
(set-face-foreground 'minibuffer-prompt "brightblue")
(set-face-background 'region "yellow")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CUSTOM VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-indent-environment-list
   '(("verbatim" current-indentation)
     ("verbatim*" current-indentation)
     ("tabular" LaTeX-indent-tabular)
     ("tabular*" LaTeX-indent-tabular)
     ("align")
     ("align*")
     ("array" LaTeX-indent-tabular)
     ("eqnarray" LaTeX-indent-tabular)
     ("eqnarray*" LaTeX-indent-tabular)
     ("displaymath")
     ("equation")
     ("equation*")
     ("picture")
     ("tabbing")))
 '(LaTeX-section-hook
   '(LaTeX-section-heading LaTeX-section-title LaTeX-section-section))
 '(TeX-command-list
   '(("TeX" "%(PDF)%(tex) %(file-line-error) %(extraopts) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("Makeinfo" "makeinfo %(extraopts) %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo %(extraopts) --html %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "amstex %(PDFout) %(extraopts) %`%S%(mode)%' %t" TeX-run-TeX nil
      (ams-tex-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "%(cntxcom) --once --texutil %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "%(cntxcom) %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "[ -e %s.aux ] && ~/dotfiles/mendeley-fixup.sh %s; bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
     ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
     ("View" "open -a Skim %s.pdf" TeX-run-discard-or-function t t :help "Run Viewer")
     ("Print" "%p" TeX-run-command t t :help "Print the file")
     ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     ("File" "%(o?)dvips %d -o %f " TeX-run-dvips t t :help "Generate PostScript file")
     ("Dvips" "%(o?)dvips %d -o %f " TeX-run-dvips nil t :help "Convert DVI file to PostScript")
     ("Dvipdfmx" "dvipdfmx %d" TeX-run-dvipdfmx nil t :help "Convert DVI file to PDF with dvipdfmx")
     ("Ps2pdf" "ps2pdf %f" TeX-run-ps2pdf nil t :help "Convert PostScript file to PDF")
     ("Glossaries" "makeglossaries %s" TeX-run-command nil t :help "Run makeglossaries to create glossary file")
     ("Index" "makeindex %s" TeX-run-index nil t :help "Run makeindex to create index file")
     ("upMendex" "upmendex %s" TeX-run-index t t :help "Run upmendex to create index file")
     ("Xindy" "texindy %s" TeX-run-command nil t :help "Run xindy to create index file")
     ("Check" "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for common mistakes")
     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Auto Generate" "my-TeX-auto-generate" TeX-run-function nil t :help "Auto generate and reapply style hooks")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))
 '(TeX-insert-braces-alist
   '(("bracket" . t)
     ("centering")
     ("clearpage")
     ("curly" . t)
     ("maketitle")
     ("noindent")
     ("pagebreak")
     ("paren" . t)
     ("titlepage")))
 '(markdown-hide-urls t)
 '(package-selected-packages
   '(beacon git-modes unfill pandoc-mode ess julia-mode bind-key markdown-mode xclip cl-lib auctex))
 '(reftex-label-alist
   '(("assump" 84 "assump:" nil nil nil -3)
     ("claim" 84 "claim:" nil nil nil -3)
     ("conj" 84 "conj:" nil nil nil -3)
     ("corollary" 84 "cor:" nil nil nil -3)
     ("defn" 84 "defn:" nil nil nil -3)
     ("lemma" 84 "lemma:" nil nil nil -3)
     ("prop" 84 "prop:" nil nil nil -3)
     ("theorem" 84 "theorem:" nil nil nil -3)
     ("remark" 84 "remark:" nil nil nil -3)))
 '(reftex-ref-style-alist
   '(("Default" t
      (("\\ref" 13)
       ("\\pageref" 112)
       ("\\eqref" 101)))
     ("Cleveref" "cleveref"
      (("\\cref" 99)
       ("\\Cref" 67)
       ("\\cpageref" 100)
       ("\\Cpageref" 68)))))
 '(reftex-ref-style-default-list '("Default" "Cleveref"))
 '(warning-suppress-types '((auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
