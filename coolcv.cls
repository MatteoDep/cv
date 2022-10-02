\ProvidesClass{coolcv}[2022/10/01 a Cool CV LaTeX Class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax
\LoadClass{article}

\usepackage[sfdefault,light]{roboto}
\usepackage[T1]{fontenc}
\usepackage{xcolor}
\usepackage[absolute,overlay]{textpos}
\usepackage{tikz}
\usetikzlibrary{positioning,math}
\usepackage{calc}
\usepackage{array}
\usepackage[hidelinks]{hyperref}

\definecolor{hlcolor}{HTML}{7726C9}
\definecolor{sidecolor}{HTML}{A0A3C4}
\definecolor{textcolor}{HTML}{555555}

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{\TPHorizModule}
\setlength{\parindent}{0pt}
\setlength{\tabcolsep}{0pt}

% mandatory to call this in preamble
\newcommand{\setuplengths}[4][5mm]{
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

	\newlength{\cvcontacticonwidth}
	\setlength{\cvcontacticonwidth}{#4}
	\newlength{\cvcontactcontentwidth}
	\setlength{\cvcontactcontentwidth}{\sideblock - \cvcontacticonwidth}

	\usepackage[left=\leftmarginnew,top=\padding,right=\padding,bottom=\padding,nohead,nofoot]{geometry}
}

\newenvironment{cvsidebar}{
	\begin{tikzpicture}[remember picture, overlay]
		\fill[fill=sidecolor] (current page.south west) rectangle ++(\sidewidth,\paperheight);
	\end{tikzpicture}
	\begin{textblock*}{\sideblock}(\padding, \padding)
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
		% \begin{tabular}{>{\raggedleft\arraybackslash}p{\cvcontacticonwidth}p{\cvcontactcontentwidth}}
		\begin{tabular}{rl}
}{
		\end{tabular}
	\end{center}
}

\newcommand{\cvcontactinfo}[2][]{
	{\Large\color{hlcolor}#1\hspace{5mm}} & {\large\color{textcolor}{#2}} \\%
}

\renewcommand{\section}[1]{
	\par
	\vspace{\tabcustomsep}
	{\color{hlcolor}\rule[.35\baselineskip]{1cm}{3pt}}
	\hspace{5mm}{\color{textcolor}\bfseries\huge #1}\hspace{5mm}
	{\color{hlcolor}\rule[.35\baselineskip]{1cm}{3pt}}
	\vspace{\tabcustomsep}
	\par
}

\newcommand{\sidesection}[1]{
	\par
	\vspace{\tabcustomsep}
	{\color{hlcolor}\bfseries\huge #1}
	\par
}

\newcommand{\cventry}[4] %\cventry{date}{title}{institution}{description}
{
	\begin{tabular}{@{\extracolsep{\fill}}>{\raggedleft\arraybackslash}p{\cventrydatewidth}@{\extracolsep{\tabcustomsep}}p{\cventrycontentwidth}}
		\parbox{\cventrydatewidth}{\raggedleft#1} & \textbf{#2} \hfill {\footnotesize#3} \\
		& \parbox{\cventrycontentwidth}{#4} \\
	\end{tabular}
}
