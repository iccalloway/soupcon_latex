\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{anthology}[2026/01/16 Recipe Anthology Class]
\LoadClass[11pt]{article}

% --- Packages ---
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{hyperref}
\RequirePackage{wrapfig}
\RequirePackage{CormorantGaramond}
\RequirePackage{etoolbox}
\RequirePackage{tocloft}

% --- Table of Contents Customization ---
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}} % Standardized dotted leaders
\renewcommand{\cftsecfont}{\normalfont}             % Recipe names not bold
\renewcommand{\cftsecpagefont}{\normalfont}
\cftpagenumbersoff{section}                         % Hide page numbers

% Category Header for TOC
\newcommand{\recipeCategory}[1]{
    \addtocontents{toc}{\vspace{1.5em}\noindent\textbf{\large #1}\par\vspace{0.5em}}
}

% --- Custom List Formatting ---
% Underlined headers as requested
\newcommand{\ingredients}[1]{
    \ifstrempty{#1}{}{
        \subsection*{\underline{Ingredients}}
        \begin{itemize}[noitemsep, leftmargin=1.2em] #1 \end{itemize}
    }
}

\newcommand{\instructions}[1]{
    \ifstrempty{#1}{}{
        \subsection*{\underline{Instructions}}
        \begin{enumerate}[noitemsep, leftmargin=1.2em] #1 \end{enumerate}
    }
}

% --- The Recipe Macro ---
% \recipe{Title}{Author}{Abstract}{IngredientsCmd}{InstructionsCmd}{Notes}{Image}
\newcommand{\recipe}[7]{
    \newpage
    \phantomsection
    % TOC Entry: Dish Name on left, Author on right
    \addcontentsline{toc}{section}{#1 \dotfill \textit{Submitted by #2}} 

    % Title and Author Header
    {\noindent\Huge\fontfamily{CormorantGaramond-LF}\selectfont #1 \par}
    {\noindent\large\textit{Submitted by #2} \par}
    \vspace{1em}

    % Wrapped Image Logic
    \ifstrempty{#7}{}{
        \begin{wrapfigure}{r}{0.45\textwidth}
            \centering
            \vspace{-25pt} % Aligns image with the Title line
            \includegraphics[width=\linewidth]{#7}
            \vspace{-10pt}
        \end{wrapfigure}
    }

    % Abstract/Description
    \ifstrempty{#3}{}{
        \noindent \textbf{Abstract}: #3 \par
    }
    
    % Content Blocks (Ingredients and Instructions)
    #4 
    #5 

    % Chef's Notes
    \ifstrempty{#6}{}{
        \subsection*{Chef's Notes}
        #6
    }
    \vfill
}