% Page formatting
\LoadClass[11pt]{article}
\usepackage[margin=1in]{geometry}

% Paragraph spacing
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0pt}

\usepackage{titlesec}
\titlespacing{\section}{0pt}{0pt}{-0.5\baselineskip}
\titlespacing{\subsection}{0pt}{0pt}{-0.5\baselineskip}
\titlespacing{\subsubsection}{0pt}{0pt}{-0.5\baselineskip}

\usepackage{caption}
\captionsetup[table]{skip=0.5\baselineskip}

% Don't number (sub...)sections
\setcounter{secnumdepth}{0}

% List environments
\usepackage{enumitem}
\setlist[enumerate]{parsep=\baselineskip}
\setlist[itemize]{parsep=\baselineskip}

% Theorem definitions
% Italicize non-remark theorem environments
\usepackage{amsthm}
\theoremstyle{plain}
\newtheorem{lemma}{Lemma}
\newtheorem{prop}{Proposition}

% Load mystyle.sty
\usepackage{mystyle}
