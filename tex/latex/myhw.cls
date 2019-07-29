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

% Itemize spacing
\let{\olditemize}{\itemize}
\renewcommand{\itemize}{
  \olditemize
  \setlength{\parskip}{\baselineskip}
}

% Enumerate spacing
\let{\oldenumerate}{\enumerate}
\renewcommand{\enumerate}{
  \oldenumerate
  \setlength{\itemsep}{\baselineskip}
  \setlength{\parskip}{\baselineskip}
}

% Enumerate numbering
\renewcommand{\labelenumi}{\alph{enumi}) }
\renewcommand{\labelenumii}{\roman{enumii}) }

% Theorems
\usepackage{amsthm}
\newtheorem{lemma}{Lemma}
\newtheorem{prop}{Proposition}

% Load mystyle.sty
\usepackage{mystyle}
