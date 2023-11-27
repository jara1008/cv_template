\ProvidesClass{cv_template}[2023/11/20 cv class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%--- REQUIRED PACKAGES ---
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ifthen}
\RequirePackage{parskip}
\RequirePackage{listofitems}
\RequirePackage[sfdefault]{roboto} %Font can be modified
\RequirePackage[T1]{fontenc} %Font can be modified
\RequirePackage[hidelinks]{hyperref}

\ProcessOptions\relax

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%--- COLOURS ---
\definecolor{cyan}{HTML}{CAE9F5}
\definecolor{gray}{RGB}{210, 210, 210}
\definecolor{darkgray}{RGB}{100, 100, 100}

%--- CONFIGURATIONS ---
\pagestyle{empty}
\setlength{\parindent}{0pt}

%--- HEADER DEFINITIONS ---

\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}

%--- HEADER LAYOUT ---

\newcommand{\makeheader}{
    \begin{tikzpicture}[remember picture, overlay]
        \node[rectangle, fill=cyan, anchor=north, minimum width=44cm, minimum height=6cm] (box) at (-5cm, 4.8cm)
        {};
    \end{tikzpicture}

    %profile pic should more or less be square, else the layout has to be adjusted
    \begin{textblock}{6}(0.5, 0.3)
        \ifthenelse{\equal{\profilepic}{}}{}{
            \begin{center}
                \begin{tikzpicture}[x=\imagescale, y=\imagescale]
                    \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
                \end{tikzpicture}
          \end{center}
        }
    \end{textblock}

    \begin{textblock}{10}(8.5, 1.2)
    \centering
        {\Huge\cvname}\par
        \vspace{10pt}
        {\Large\cvjobtitle}\par
        \vspace{10pt}
        \ifthenelse{\equal{\aboutme}{}}{}{
			\aboutme
		}
    \end{textblock}
}

%--- SIDEBAR DEFINITIONS ---
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength}
\newlength{\SectionTitelLength}

\newcommand{\profilesection}[1]{
    \setlength\TotalSectionLength{\linewidth}
    \settowidth{\SectionTitelLength}{\huge #1}
    \addtolength\TotalSectionLength{-\SectionTitelLength}
    \vspace{8pt}
    {\color{black}} \huge #1 \rule[0.15\baselineskip]
    {\TotalSectionLength{1pt}}
}

\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvnationality}[1]{\renewcommand{\cvnationality}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvinterests}[1]{\renewcommand{\cvinterests}{#1}}

\ExplSyntaxOn
\newcommand\test[2]{\seq_item:Nn#2{#1}}
\ExplSyntaxOff

\newcommand{\skills}[1]{
    \begin{tikzpicture}
        \foreach \x in {0,1,...,5}{
            \ifthenelse{#1>\x}{
                \draw (\x*0.6, 0) [draw=black, fill=cyan] circle (5pt);
            }{
                \draw (\x*0.6, 0) [draw=black, fill=gray] circle (5pt);
            }
        }
    \end{tikzpicture}
}

\newcommand{\customTabular}[2]{
    \readlist\mylist{#2}
    \begin{tabular}
        \hline
        \foreach \i [count=\j] in {#1}{
            \parbox[t]{2.7cm}{
            {\textsc{\i}}}&
            \parbox[t]{0cm}{
            \skills{\mylist[\j]}\\}
            \newline
        }
    \end{tabular}
}

%--- SIDEBAR LAYOUT ---
\newcommand{\makesidebar}{
    \begin{tikzpicture}[remember picture, overlay]
        \node[rectangle, fill=gray, anchor=north, minimum width=15cm, minimum height=25cm] (box) at (-5cm, -0.56cm)
        {};
    \end{tikzpicture}

    \begin{textblock}{6.2}(0.5, 6.7)     
    {\Large\textsc{Info}}\\
    \rule[0.2cm]{\linewidth}{0.4pt}
        \begin{tabular}{@{}p{2.75cm}p{3.25cm}}
            \ifthenelse{\equal{\cvaddress}{}}{}{\textsc{Address:}& 
            \parbox[t]{3cm}{\cvaddress\\}}
            \\
			\ifthenelse{\equal{\cvdate}{}}{}{\textsc{Birthday:} & \cvdate\\}
            \\
            \ifthenelse{\equal{\cvnationality}{}}{}{\textsc{Nationality:} & \cvnationality\\}
            \\[3pt]
		\end{tabular}
    {\Large\textsc{Contact}}\\
    \rule[0.2cm]{\linewidth}{0.4pt}
        %change links accordingly
        \begin{tabular}{@{}p{2.75cm}p{3.25cm}}
            \ifthenelse{\equal{\cvmail}{}}{}{\textsc{Mail: } & \href{mailto:\cvmail}{\cvmail}\\}
            \\
			\ifthenelse{\equal{\cvnumberphone}{}}{}{\textsc{Telephone:}
            & \cvnumberphone\\}
            \\
            \ifthenelse{\equal{\cvgithub}{}}{}{\textsc{Git: } 
             & \href{https://www.github.com}{\cvgithub}\newline}
            \\
            \ifthenelse{\equal{\cvlinkedin}{}}{}{\textsc{LinkedIn: }
             & \href{https://www.linkedin.com}{\cvlinkedin}\newline}
            \\[3pt]
		\end{tabular}
  
    {\Large\textsc{Skills}}\\
    \rule[0.2cm]{\linewidth}{0.4pt}

    %NOTE: this needs to be changed here!
    \customTabular{Singing, Songwriting, Playing Guitar}{4, 5, 6}

    {\Large\textsc{Languages}}\\
    \rule[0.2cm]{\linewidth}{0.4pt}

    %NOTE: this needs to be changed here!
    \customTabular{German, English, French}{6, 5, 4}

    {\Large\textsc{Interests}}\\
    \rule[0.2cm]{\linewidth}{0.4pt}
    {\cvinterests}
    
    \end{textblock} 
}

%--- MAIN DEFINITIONS ---
\newcommand{\header}[1]{
    {\Large\textsc{#1}}\\
    \rule[0.2cm]{\linewidth}{0.4pt}
}

\newcommand{\littleHeader}[1]{
    {\large\color{darkgray} #1}
    \par
}

\newcommand{\fromTo}[1]{
    {\large #1}
    \par
}

\endinput
