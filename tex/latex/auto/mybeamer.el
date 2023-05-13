(TeX-add-style-hook
 "mybeamer"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("beamer" "aspectratio=169" "notheorems" "10pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("lato" "default")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-environments-local "semiverbatim")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "beamer"
    "beamer10"
    "lato"
    "natbib"
    "appendixnumberbeamer"
    "mystyle")
   (TeX-add-symbols
    '("citet" ["argument"] 1)
    '("citep" ["argument"] 1)
    '("cite" ["argument"] 1)
    '("slideselection" 1)
    '("blmb" 2)
    '("blg" 2)
    '("bl" 2)
    '("theoremcite" 1)
    '("letbeamertemplate" 2)
    "miniframeson"
    "miniframesoff"
    "disablecolorlinks"
    "oldcite"
    "oldcitep"
    "oldcitet")
   (LaTeX-add-environments
    '("handoutframeselect" LaTeX-env-args ["argument"] 0)
    "wideitemize"
    "wideenumerate")
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
    "pink"
    "lightgray"
    "replightgrey"
    "repmedgrey"
    "reporange"
    "repdarkpurple"
    "themepurple"))
 :latex)

