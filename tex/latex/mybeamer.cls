% Page formatting
\LoadClass{beamer}

% Section title slide
% http://tex.stackexchange.com/a/178803
\AtBeginSection[]{
  \begin{frame}
    \vfill
    \centering
    \begin{beamercolorbox}[sep=8pt,center,shadow=true,rounded=true]{title}
      \usebeamerfont{title}\insertsectionhead\par%
    \end{beamercolorbox}
    \vfill
  \end{frame}
}

% Load mystyle.sty
\usepackage{mystyle}