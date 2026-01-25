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

% Customize reference formats
% https://tex.stackexchange.com/a/122178/116532 (general)
% https://tex.stackexchange.com/a/359651/116532 (subequation)
% https://tex.stackexchange.com/a/10116/116532 (footnote)
\crefformat{equation}{equation (#2#1#3)}
\crefrangeformat{equation}{equations (#3#1#4) to~(#5#2#6)}
\crefmultiformat{equation}{equations (#2#1#3)}{ and~(#2#1#3)}{, (#2#1#3)}{ and~(#2#1#3)}
\crefalias{subequation}{equation}
\crefformat{footnote}{#2\footnotemark[#1]#3}

\Crefname{assump}{Assumption}{Assumptions}
\Crefname{claim}{Claim}{Claims}
\Crefname{conj}{Conjecture}{Conjectures}
\Crefname{corollary}{Corollary}{Corollaries}
\Crefname{defn}{Definition}{Definitions}
\Crefname{example}{Example}{Examples}
\Crefname{lemma}{Lemma}{Lemmata}
\Crefname{prop}{Proposition}{Propositions}
\Crefname{remark}{Remark}{Remarks}
\Crefname{theorem}{Theorem}{Theorems}

% Link colors
\hypersetup{colorlinks=true,
  linkcolor=blue, % internal links (sections, equations, etc.)
  urlcolor=blue,  % URL links
  citecolor=blue, % citations
}
