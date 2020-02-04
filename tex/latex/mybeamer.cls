% Page formatting
\LoadClass{beamer}

% Page numbers (not nav controls) in bottom right
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{footline}[frame number]
\usepackage{appendixnumberbeamer}

% Add TOC slide at the beginning of each section
% Use \section* to suppress this slide for a given section
% https://en.wikibooks.org/wiki/LaTeX/Presentations#Table_of_Contents
\AtBeginSection[]{
  \begin{frame}
    \tableofcontents[currentsection]
  \end{frame}
}
\setbeamertemplate{section in toc}[sections numbered]

% Tikz overlays
% https://tex.stackexchange.com/q/6135/116532
\usepackage{tikz}
\usetikzlibrary{positioning}
\tikzset{onslide/.code args={<#1>#2}{%
  \only<#1>{\pgfkeysalso{#2}}%
}}
\newcommand<>{\btikzset}[2]{\alt#3{\tikzset{#1}}{\tikzset{#2}}}

% Load mystyle.sty
\usepackage{mystyle}