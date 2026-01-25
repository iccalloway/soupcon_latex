\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{anthology}[2026/01/16 Recipe Anthology Class]
\LoadClass[12pt]{article}

% --- Packages ---
\RequirePackage{wrapstuff}
\RequirePackage{fontspec}


%\RequirePackage[utf8]{inputenc}
%\RequirePackage[T1]{fontenc}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{hyperref}
\RequirePackage{wrapfig}
\RequirePackage{CormorantGaramond}
\RequirePackage{etoolbox}
\RequirePackage{tocloft}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage{xcolor} % Required for defining colors

% Fonts
\setmainfont{CormorantGaramond-Regular}[
    Path = ./fonts/Cormorant_Garamond/static/,
    Extension = .ttf,
    BoldFont = CormorantGaramond-Bold,
    ItalicFont = CormorantGaramond-Italic,
    BoldItalicFont = CormorantGaramond-BoldItalic
]

\newfontfamily{\laofont}{Lao Sangam MN}[Script=Lao]


\hypersetup{
    colorlinks=true,    % Colors the text of the link instead of drawing a box
    linkcolor=black,     % Internal links (TOC) - usually best kept black for print
    urlcolor=blue,      % Web and email links will be blue
    citecolor=blue      % Citations will be blue
}

% Adjust geometry to make room for a header
\geometry{margin=1in, headheight=60pt, top=1.2in}

% Define the header style with the logo
\fancypagestyle{logoheader}{
    \fancyhf{} % clear all fields
    \renewcommand{\headrulewidth}{0pt} % Remove the horizontal line
    \fancyhead[C]{\includegraphics[width=0.5\textwidth]{logo.png}}
    \fancyfoot[C]{\thepage}
}



% --- Table of Contents Customization ---
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}} % Standardized dotted leaders
\renewcommand{\cftsecfont}{\normalfont}             % Recipe names not bold
\renewcommand{\cftsecpagefont}{\normalfont}
\cftpagenumbersoff{section}                         % Hide page numbers

% Helper for a variable horizontal grid (1 to 4 images)
\newcommand{\photoGrid}[4]{
    \begin{center}
        \hfill
        \ifstrempty{#1}{}{\begin{minipage}[b]{0.22\textwidth}\includegraphics[width=\linewidth]{#1}\end{minipage}\hfill}
        \ifstrempty{#2}{}{\begin{minipage}[b]{0.22\textwidth}\includegraphics[width=\linewidth]{#2}\end{minipage}\hfill}
        \ifstrempty{#3}{}{\begin{minipage}[b]{0.22\textwidth}\includegraphics[width=\linewidth]{#3}\end{minipage}\hfill}
        \ifstrempty{#4}{}{\begin{minipage}[b]{0.22\textwidth}\includegraphics[width=\linewidth]{#4}\end{minipage}\hfill}
    \end{center}
}
% Updated Category Page with Optional Images
% Use {} in main.tex for any missing images
\newcommand{\recipeCategory}[5]{
    \newpage
    \thispagestyle{empty}
    \phantomsection
    
    \vspace*{\fill}
    \begin{center}
        {\Huge\fontfamily{CormorantGaramond-LF}\selectfont #1}
        \par\vspace{3em}
        
        % Only draw the grid if at least one image is provided
        \ifstrempty{#2#3#4#5}{}{
            \photoGrid{#2}{#3}{#4}{#5}
        }
    \end{center}
    \vspace*{\fill}
    \newpage
}
% --- Custom List Formatting ---
\newcommand{\ingredients}[1]{
    \ifstrempty{#1}{}{
        \subsection*{\underline{Ingredients}}
        % Use leftmargin=* to remove the extra indent
        \begin{itemize}[noitemsep, leftmargin=*] #1 \end{itemize}
    }
}

\newcommand{\instructions}[1]{
    \ifstrempty{#1}{}{
        \subsection*{\underline{Instructions}}
        % Use leftmargin=* to remove the extra indent
        \begin{enumerate}[noitemsep, leftmargin=*] #1 \end{enumerate}
    }
}
% --- The Recipe Macro ---
% \recipe{Title}{Author}{Abstract}{IngredientsCmd}{InstructionsCmd}{Notes}{Image}
\usepackage{etoolbox}

% #1: Name, #2: Submitter, #3: Abstract, #4: Ingredients, 
% #5: Instructions, #6: Notes, #7: Image, #8: Category
% Replace the Image/Content logic in your \recipe macro with this:
% 1. Add this to your package list at the top of the .cls file
\RequirePackage{wrapstuff}

% 2. Update the \recipe macro logic
\newcommand{\recipe}[9]{
    \newpage
    \phantomsection
    
    % --- TOC Logic (Kept from original) ---
    \ifcsdef{cat#8}{}{%
        \addcontentsline{toc}{part}{#8}%
        \csdef{cat#8}{true}%
    }
    
    \addcontentsline{toc}{section}{%
    {\fontfamily{CormorantGaramond-LF}\selectfont #1} % Forces Title to serif
    \dotfill 
    \textit{Submitted by #2}%
}
    
    %\addcontentsline{toc}{section}{#1 \dotfill \textit{Submitted by #2}} 
    \cftpagenumbersoff{section}
    \cftpagenumbersoff{part}

% --- Title and Author on Page ---
\begin{samepage} % Keeps title and submitter together
    {\noindent\Huge\fontfamily{CormorantGaramond-LF}\selectfont\raggedright 
        % Explicitly wrap the title/subtitle content to protect the font
        {#1}\ifstrempty{#9}{}{ (#9)} 
    \par}
    {\noindent\large\fontfamily{CormorantGaramond-LF}\selectfont\textit{Submitted by #2} \par}
\end{samepage}
\vspace{1.5em}

    % --- Visual Layout ---
    \ifstrempty{#7}{
        % Case: No image
        \ifstrempty{#3}{}{\noindent \textbf{Abstract}: #3 \par \medskip}
        #4 % Ingredients
        #5 % Instructions
    }{
        % Case: With image - Using wrapstuff
        % width=0.45\textwidth, type=figure, and placement=r (right)
        \begin{wrapstuff}[width=0.45\textwidth, hsep=1em, vsep=0pt]
            \centering
            \includegraphics[width=\linewidth]{#7}
        \end{wrapstuff}

        \ifstrempty{#3}{}{\noindent \textbf{Abstract}: #3 \par \medskip}
        
        #4 % Ingredients
        
        \vspace{1em}
        #5 % Instructions (This will now wrap correctly even across pages)
    }

    \ifstrempty{#6}{}{\medskip \subsection*{Notes} #6}
    \vfill
}