%%% 1. Basic

% Pass in options to beamer class
% https://tex.stackexchange.com/a/418947/116532
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

% Load beamer class
% Disable automatic theorem definitions (https://tex.stackexchange.com/a/285558/116532)
\LoadClass[aspectratio=169,notheorems]{beamer}


%%% 2. Appearance

% Use light blue colortheme
\usecolortheme{seahorse}

% Use Lato font
\usepackage[default]{lato}

% Set colors
\definecolor{indigo}{RGB}{51,51,178}
\definecolor{blue}{RGB}{20,115,251}
\definecolor{pink}{RGB}{222,15,112}

\hypersetup{colorlinks=true,
  linkcolor=indigo, % internal links (sections, equations, etc.)
  urlcolor=indigo,  % URL links
  citecolor=indigo, % citations
}

% Page numbers (not nav controls) in bottom right
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{footline}[frame number]
\usepackage{appendixnumberbeamer}

% Remove frame title numbering from allowframebreaks
\setbeamertemplate{frametitle continuation}{}


%%% 3. Sections and environments

% Add TOC slide at the beginning of each section
% Use \section* to suppress this slide for a given section
% https://en.wikibooks.org/wiki/LaTeX/Presentations#Table_of_Contents
% Don't count TOC slides toward frame numbering
% https://tex.stackexchange.com/a/49805/116532
\AtBeginSection[]{
  \begin{frame}[plain,noframenumbering]
    \tableofcontents[currentsection,hideothersubsections]
  \end{frame}
}
\setbeamertemplate{section in toc}[sections numbered]
\setbeamertemplate{subsection in toc}[subsections numbered]

% Box theorems and definitions
\setbeamercolor{block title}{use=structure,fg=white,bg=structure.fg!75!black}
\setbeamercolor{block body}{parent=normal text,use=block title,bg=block title.bg!10!bg}
\newcommand{\theoremcite}[1]{{\hypersetup{citecolor=white}\citealt{#1}}}

% Use circular bullets for subitems
\setbeamertemplate{itemize subitem}[circle]

% Define wideitemize and widenumerate environments
\newenvironment{wideitemize}{\itemize\addtolength{\itemsep}{\baselineskip}}{\enditemize}
\newenvironment{wideenumerate}{\enumerate\addtolength{\itemsep}{\baselineskip}}{\endenumerate}


%%% 4. Other

% Load mystyle.sty
\usepackage{mystyle}

% Redefine some macros
\renewcommand{\P}{\text{Pr}}

% Add vertical space
\newcommand{\myvskip}{

  \vspace{\baselineskip}}

% Theorem definitions
% Don't italicize any theorem environments
\theoremstyle{definition}
\newtheorem{assump}{Assumption}
\newtheorem{claim}{Claim}
\newtheorem{conj}{Conjecture}
\newtheorem{corollary}{Corollary}
\newtheorem{defn}{Definition}
\newtheorem{example}{Example}
\newtheorem{lemma}{Lemma}
\newtheorem{prop}{Proposition}
\newtheorem{remark}{Remark}
\newtheorem{theorem}{Theorem}

% Necessary to use subcaption package with Beamer
% https://tex.stackexchange.com/a/426090/116532
\makeatletter
\let\@@magyar@captionfix\relax
\makeatother

% Open PDFs in full page mode
% https://tex.stackexchange.com/a/16473/116532
\hypersetup{pdfstartview=Fit}