\ProvidesClass{coolcv}[2022/10/01 a Cool CV LaTeX Class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax
\LoadClass{article}

\usepackage[sfdefault]{FiraSans}
\usepackage[T1]{fontenc}
\usepackage{xcolor}
\usepackage[absolute,overlay]{textpos}
\usepackage{tikz}
\usetikzlibrary{positioning,math}
\usepackage{calc}
\usepackage{array}
\usepackage{etoolbox}
\usepackage[hidelinks]{hyperref}

% dracula theme
\definecolor{hlcolor}{HTML}{62d6e8}
\definecolor{sidebg}{HTML}{626483}
\definecolor{sidefg}{HTML}{e9e9f4}
\definecolor{section}{HTML}{626483}
\definecolor{workplace}{HTML}{626483}

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{\TPHorizModule}
\setlength{\parindent}{0pt}
\setlength{\tabcolsep}{0pt}

% mandatory to call this in preamble
\newcommand{\setuplengths}[3][5mm]{
	\newlength{\padding}
	\setlength{\padding}{#1}
	\newlength{\sidewidth}
	\setlength{\sidewidth}{#2}
	\newlength{\leftmarginnew}
	\setlength{\leftmarginnew}{\sidewidth + \padding}
	\newlength{\sideblock}
	\setlength{\sideblock}{\sidewidth - 2\padding}
	\newlength{\mainblock}
	\setlength{\mainblock}{\paperwidth - \sidewidth - 2\padding}
	\newlength{\tabcustomsep}
	\setlength{\tabcustomsep}{2mm}

	\newlength{\cventrydatewidth}
	\setlength{\cventrydatewidth}{#3}
	\newlength{\cventrycontentwidth}
	\setlength{\cventrycontentwidth}{\mainblock - \cventrydatewidth - \tabcustomsep}

	\usepackage[left=\leftmarginnew,top=\padding,right=\padding,bottom=\padding,nohead,nofoot]{geometry}
}

\newenvironment{cvsidebar}{
	\begin{tikzpicture}[remember picture, overlay]
		\fill[fill=sidebg] (current page.south west) rectangle ++(\sidewidth,\paperheight);
	\end{tikzpicture}
	\begin{textblock*}{\sideblock}(\padding, \padding)
		\color{sidefg}
}{
	\end{textblock*}
}

\newcommand{\cvperson}[1]{
	{\Huge\color{hlcolor}#1}
}

\newcommand{\cvpicture}[2][4cm]{
	\newlength{\radius}
	\setlength{\radius}{#1/2}
	\begin{center}
		\begin{tikzpicture}
			\clip (0, 0) circle (\radius);
			\node at (0,0) {\includegraphics[width=#1]{#2}};
		\end{tikzpicture}
	\end{center}
}

\newenvironment{cvcontactbox}{
	\begin{center}%
		\begin{tabular}{rl}%
}{
		\end{tabular}
	\end{center}
}

\newcommand{\cvcontactinfo}[3][]{ %\cvcontactinfo[url]{icon}{value}
	\ifstrempty{#1}{
		{\Large\color{hlcolor}#2\hspace{5mm}} & {\large{#3}} \\%
	}{
		\href{#1}{\Large\color{hlcolor}#2\hspace{5mm}} & \href{#1}{\large{#3}} \\%
	}
}

\renewcommand{\section}[1]{
	\par
	\bigskip
	{\color{hlcolor}\rule[.35\baselineskip]{1cm}{3pt}}
	\hspace{5mm}{\color{section}\bfseries\huge #1}\hspace{5mm}
	{\color{hlcolor}\rule[.35\baselineskip]{1cm}{3pt}}
	\vspace{\tabcustomsep}
	\par
}

\newcommand{\sidesection}[2]{ %\sidesection{title}{content}
	\par
	\vspace{\tabcustomsep}
	{\color{hlcolor}\bfseries\huge #1}
	\par
	\vspace{\tabcustomsep}
	\parbox{\linewidth}{#2}
	\bigskip
	\par
}

\newcommand{\cventry}[5][]{ %\cventry{date}{title}{institution}{description}
	\begin{tabular}{%
			@{\extracolsep{\fill}}>{\raggedleft\arraybackslash}p{\cventrydatewidth}%
			@{\extracolsep{\tabcustomsep}}p{\cventrycontentwidth}%
		}
		\parbox{\cventrydatewidth}{\flushright#2} & \textbf{#3} \hspace{\tabcustomsep} {\small #1} \hfill {\bfseries\color{workplace}#4} \\%
		& \parbox{\cventrycontentwidth}{#5} \\%
	\end{tabular}
}

\newcommand{\cvlist}[2]{
	{\bfseries\textbullet\hspace{\tabcustomsep}#1}: #2\par
}
