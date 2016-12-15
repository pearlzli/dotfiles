% Page formatting
\LoadClass[11pt]{article}
\textwidth=7in
\textheight=9in
\topmargin=-0.5in
\oddsidemargin=-0.25in
\evensidemargin=-0.25in

% Packages
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{bm}                             % Bold math
\usepackage[bottom]{footmisc}               % Footnote at page bottom
\usepackage{color}
\usepackage{graphicx}                       % Graphics support
\usepackage{hyperref}                       % URL support
\usepackage{mathrsfs}                       % Script math

% Enumerate spacing
\let\oldenumerate\enumerate
\renewcommand{\enumerate}{
  \oldenumerate
  \setlength{\itemsep}{11pt}
  \setlength{\parskip}{11pt}
}

% Switch \epsilon and \varepsilon
\let\oldepsilon\epsilon
\let\oldvarepsilon\varepsilon
\renewcommand{\epsilon}{\oldvarepsilon}
\renewcommand{\varepsilon}{\oldepsilon}

% Left and right brackets
\newcommand{\paren}[1]{\left( #1 \right)}
\newcommand{\bracket}[1]{\left[ #1 \right]}
\newcommand{\curly}[1]{\left\{ #1 \right\}}
\newcommand{\inner}[1]{\left\langle #1 \right\rangle}
\newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}
\newcommand{\ceil}[1]{\left\lceil #1 \right\rceil}
\newcommand{\abs}[1]{\left| #1 \right|}     % Absolute value
\newcommand{\norm}[1]{\lVert #1 \rVert}    % Norm
\newcommand{\eval}[1]{\left. #1 \right|}    % Evaluated at

% General math commands
\newcommand{\comp}[1]{#1^{\mathsf{c}}}      % Complement
\def\N{\mathbb{N}}                          % Natural numbers
\def\Z{\mathbb{Z}}                          % Integers
\def\Q{\mathbb{Q}}                          % Rational numbers
\def\R{\mathbb{R}}                          % Real numbers
\def\C{\mathbb{C}}                          % Complex numbers

% Math 546 commands
\def\ind{\bm{1}}                            % Indicator function
\def\m{\mathbf{m}}                          % Lebesgue measure
\def\P{\mathbb{P}}                          % Probability measure
\def\E{\mathbb{E}}                          % Expectation
\def\Var{\mathrm{Var}}                      % Variance
\def\Cov{\mathrm{Cov}}                      % Covariance
\def\eqd{\,{\buildrel \mathcal{D} \over =}\,}         % Equal in distribution
\def\io{\ \mathrm{i.o.}}                    % Infinitely often

% Code with syntax highlighting
\usepackage{listings}
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
\newcommand{\mylstset}[1]{\lstset{language=#1,%
  numberstyle=\\tiny\\color\{gray\},%
  keywordstyle=\color{blue},%
  commentstyle=\color{dkgreen},%
  stringstyle=\color{mauve}}}
