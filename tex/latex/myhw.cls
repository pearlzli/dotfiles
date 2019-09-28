% Page formatting
\LoadClass[11pt]{article}
\textwidth=7in
\textheight=9in
\topmargin=-0.5in
\oddsidemargin=-0.25in
\evensidemargin=-0.25in

% Paragraph spacing
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0pt}

\usepackage{titlesec}
\titlespacing{\subsection}{0pt}{0pt}{-0.75\baselineskip}

% List environments
\usepackage{enumitem}
\setlist[enumerate]{parsep=\baselineskip}
\setlist[enumerate,1]{label=\alph*), ref=(\alph*)}
\setlist[enumerate,2]{label=\roman*), ref=(\roman*)}
\setlist[itemize]{parsep=\baselineskip}

% Theorems
\usepackage{amsthm}
\newtheorem{lemma}{Lemma}
\newtheorem{prop}{Proposition}

% Load mystyle.sty
\usepackage{mystyle}
