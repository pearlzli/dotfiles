% Page formatting
\LoadClass[11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage[onehalfspacing]{setspace}

% Load mystyle.sty
\usepackage{mystyle}

% Theorem definitions
% Italicize non-{defn,example,remark} theorem environments
% Use same counter for all theorem environments
\theoremstyle{plain}
\newtheorem{assump}{Assumption}

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{claim}[theorem]{Claim}
\newtheorem{conj}[theorem]{Conjecture}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{prop}[theorem]{Proposition}

\theoremstyle{definition}
\newtheorem{defn}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}

% Link colors
\hypersetup{colorlinks=true,
  linkcolor=blue, % internal links (sections, equations, etc.)
  urlcolor=blue,  % URL links
  citecolor=blue, % citations
}
