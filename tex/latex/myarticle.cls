% Page formatting
\LoadClass[11pt]{article}
\textwidth=7in
\textheight=9in
\topmargin=-0.5in
\oddsidemargin=-0.25in
\evensidemargin=-0.25in

% Enumerate spacing
\let\oldenumerate\enumerate
\renewcommand{\enumerate}{
  \oldenumerate
  \setlength{\itemsep}{11pt}
  \setlength{\parskip}{11pt}
}

% Load mystyle.sty
\usepackage{mystyle}