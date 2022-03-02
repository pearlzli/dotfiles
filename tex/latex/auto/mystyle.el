(TeX-add-style-hook
 "mystyle"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("footmisc" "bottom")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "amsmath"
    "amssymb"
    "amsthm"
    "bm"
    "booktabs"
    "cancel"
    "color"
    "float"
    "footmisc"
    "graphicx"
    "hyperref"
    "cleveref"
    "listings"
    "mathrsfs"
    "natbib"
    "subcaption")
   (TeX-add-symbols
    '("todo" 1)
    '("juliainline" 1)
    '("bashinline" 1)
    '("hltext" 1)
    '("nmpder" 4)
    '("npder" 3)
    '("mpder" 3)
    '("spder" 2)
    '("pderol" 2)
    '("pder" 2)
    '("sder" 2)
    '("derol" 2)
    '("der" 2)
    '("inv" 1)
    '("comp" 1)
    '("eval" 1)
    '("norm" 1)
    '("abs" 1)
    '("ceil" 1)
    '("floor" 1)
    '("inner" 1)
    '("curly" 1)
    '("bracket" 1)
    '("paren" 1)
    '("group" 1)
    "tageq"
    "oh"
    "st"
    "where"
    "corrto"
    "N"
    "Z"
    "Q"
    "R"
    "C"
    "sumin"
    "prodin"
    "join"
    "bigjoin"
    "meet"
    "bigmeet"
    "given"
    "ind"
    "m"
    "F"
    "iidsim"
    "E"
    "eqd"
    "dto"
    "pto"
    "io"
    "addrefstoc"
    "oldepsilon"
    "oldvarepsilon"
    "oldforall"
    "renewtheorem")
   (LaTeX-add-color-definecolors
    "codegreen"
    "codepurple"
    "lightgray")
   (LaTeX-add-listings-lstdefinestyles
    "bash"
    "julia"))
 :latex)

