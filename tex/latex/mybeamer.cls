% Pass in options to beamer class
% https://tex.stackexchange.com/a/418947/116532
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

% Page formatting
\LoadClass[aspectratio=169]{beamer}

% Use Lato font
\usepackage[default]{lato}

% Set colors
% https://ramblingacademic.com/2015/12/08/how-to-quickly-overhaul-beamer-colors
\definecolor{blue}{RGB}{0,100,190}
\definecolor{green}{RGB}{0,160,0}
\definecolor{gray}{RGB}{205,205,205}
\definecolor{violet}{RGB}{90,90,180}
\setbeamercolor{structure}{fg=violet}

% Page numbers (not nav controls) in bottom right
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{footline}[frame number]
\usepackage{appendixnumberbeamer}

% Remove frame title numbering from allowframebreaks
\setbeamertemplate{frametitle continuation}{}

% Add TOC slide at the beginning of each section
% Use \section* to suppress this slide for a given section
% https://en.wikibooks.org/wiki/LaTeX/Presentations#Table_of_Contents
\AtBeginSection[]{
  \begin{frame}
    \tableofcontents[currentsection,hideothersubsections]
  \end{frame}
}
\setbeamertemplate{section in toc}[sections numbered]
\setbeamertemplate{subsection in toc}[subsections numbered]

% Box theorems and definitions
\setbeamercolor{block title}{use=structure,fg=white,bg=structure.fg!75!black}
\setbeamercolor{block body}{parent=normal text,use=block title,bg=block title.bg!10!bg}
\newcommand{\theoremcite}[1]{{\hypersetup{citecolor=white}\citealt{#1}}}

% Define wideitemize environment for use with nested itemize
\newenvironment{wideitemize}{\itemize\addtolength{\itemsep}{\baselineskip}}{\enditemize}

% Use circular bullets for subitems
\setbeamertemplate{itemize subitem}[circle]

% Tikz overlays
% https://tex.stackexchange.com/q/6135/116532
\usepackage{tikz}
\usetikzlibrary{positioning}
\tikzset{onslide/.code args={<#1>#2}{%
  \only<#1>{\pgfkeysalso{#2}}%
}}
\newcommand<>{\btikzset}[2]{\alt#3{\tikzset{#1}}{\tikzset{#2}}}

% Single command to pause and add vertical space
\newcommand{\pauseskip}{\pause

\vspace{\baselineskip}}

% Load mystyle.sty
\usepackage{mystyle}

% Necessary to use subcaption package with Beamer
% https://tex.stackexchange.com/a/426090/116532
\makeatletter
\let\@@magyar@captionfix\relax
\makeatother