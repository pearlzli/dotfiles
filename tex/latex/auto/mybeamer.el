(TeX-add-style-hook
 "mybeamer"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("beamer" "aspectratio=169" "notheorems")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("lato" "default")))
   (add-to-list 'LaTeX-verbatim-environments-local "semiverbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "beamer"
    "beamer10"
    "lato"
    "appendixnumberbeamer"
    "mystyle")
   (TeX-add-symbols
    '("theoremcite" 1)
    "myvskip")
   (LaTeX-add-environments
    '("wideitemize" LaTeX-env-item)
    '("wideenumerate" LaTeX-env-item))
   (LaTeX-add-amsthm-newtheorems
    "assump"
    "claim"
    "conj"
    "corollary"
    "defn"
    "example"
    "lemma"
    "prop"
    "remark"
    "theorem")
   (LaTeX-add-xcolor-definecolors
    "indigo"
    "blue"
    "pink"))
 :latex)

