%%% 1. Basic

% Pass in options to beamer class
% https://tex.stackexchange.com/a/418947/116532
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

% Load beamer class
% Disable automatic theorem definitions (https://tex.stackexchange.com/a/285558/116532)
\LoadClass[aspectratio=169,notheorems,10pt]{beamer}


%%% 2. Appearance

% Use light blue colortheme
\usecolortheme{seahorse}

% Use Lato font
\usepackage[default]{lato}

% Set colors
\definecolor{indigo}{RGB}{51,51,178}
\definecolor{blue}{RGB}{20,115,251}
\definecolor{pink}{RGB}{222,15,112}
\definecolor{replightgrey}{RGB}{218 222 223}
\definecolor{repmedgrey}{RGB}{143 150 152}
\definecolor{reporange}{RGB}{255,93,56}
\definecolor{repdarkpurple}{RGB}{107,64,129}
\definecolor{themepurple}{RGB}{153,153,217}
\newcommand<>{\blue}[1]{\textcolor#2{blue}{#1}} %#418cfc
\newcommand<>{\pink}[1]{\textcolor#2{pink}{#1}} %#e02279
\newcommand<>{\orange}[1]{\textcolor#2{reporange}{#1}}
\newcommand<>{\purple}[1]{\textcolor#2{repdarkpurple}{#1}}
\newcommand<>{\gray}[1]{\textcolor#2{black!25!white}{#1}}

\hypersetup{colorlinks=true,
  linkcolor=indigo, % internal links (sections, equations, etc.)
  urlcolor=repmedgrey,  % URL links
  citecolor=repmedgrey, % citations
}

% Fix citation colors
% Without this, closing parenthesis is not colored
\usepackage{natbib}
\let\oldcite=\cite
\let\oldcitep=\citep
\let\oldcitet=\citet
\renewcommand{\cite}[2][]{\textcolor{repmedgrey}{\oldcite[#1]{#2}}}
\renewcommand{\citep}[2][]{\textcolor{repmedgrey}{\oldcitep[#1]{#2}}}
\renewcommand{\citet}[2][]{\textcolor{repmedgrey}{\oldcitet[#1]{#2}}}

% Show miniframes (horizontal nav bar with clickable circle for each slide)
\useoutertheme[subsection=false]{miniframes}

% Move miniframes to bottom
% https://tex.stackexchange.com/a/649597/116532
\makeatletter
\newcommand\letbeamertemplate[2]{\csletcs{beamer@@tmpl@#1}{beamer@@tmpl@#2}}
\letbeamertemplate{footline}{headline}
\setbeamertemplate{headline}[default]
\makeatother

% Add page numbers in bottom right
% https://tex.stackexchange.com/a/228167/116532
% https://tex.stackexchange.com/a/85744/116532
\makeatletter
\defbeamertemplate*{footline}{myminiframes theme}{
  \begin{beamercolorbox}[colsep=1.5pt]{upper separation line head}
  \end{beamercolorbox}
  \begin{beamercolorbox}[leftskip=.01cm,rightskip=0.3cm plus1fil]{section in head/foot}
    \vskip2pt
    \begin{minipage}[c]{0.9\paperwidth}
      \insertnavigation{\linewidth}
    \end{minipage}
    \hfill
    \begin{minipage}[c]{0.05\paperwidth}
      \raggedleft
      \insertframenumber
    \end{minipage}
    \vskip4pt
  \end{beamercolorbox}
  \ifbeamer@theme@subsection
    \begin{beamercolorbox}[colsep=1.5pt]{middle separation line head}
    \end{beamercolorbox}
    \begin{beamercolorbox}[
      ht=2.5ex,dp=1.125ex,
      leftskip=.3cm,
      rightskip=.3cm plus1fil,
    ]{subsection in head/foot}
    \usebeamerfont{subsection in head/foot}\insertsubsectionhead
    \end{beamercolorbox}
  \fi
  \begin{beamercolorbox}[colsep=1.5pt]{lower separation line head}
  \end{beamercolorbox}
}
\makeatother

% Turn off link coloring in miniframes
% https://tex.stackexchange.com/a/481051/116532
\makeatletter
\newcommand*\disablecolorlinks{\def\HyColor@UseColor##1{}}
\makeatletter
\addtobeamertemplate{footline}{\disablecolorlinks}{}

% No nav controls in bottom right
\setbeamertemplate{navigation symbols}{}

% Remove frame title numbering from allowframebreaks
\setbeamertemplate{frametitle continuation}{}

% Number appendix slides separately
\usepackage{appendixnumberbeamer}


%%% 3. Environments

% Box theorems and definitions
\setbeamercolor{block title}{use=structure,fg=white,bg=structure.fg!75!black}
\setbeamercolor{block body}{parent=normal text,use=block title,bg=block title.bg!10!bg}
\newcommand{\theoremcite}[1]{{\hypersetup{citecolor=white}\citealt{#1}}}

% List styles
\setbeamertemplate{itemize items}[circle] % circular bullets for all items
\setbeamertemplate{enumerate subitem}{\alph{enumii})} % lowercase letters for subitems
\setbeamertemplate{enumerate subsubitem}{\roman{enumiii})} % lowercase roman numerals for subsubitems

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
