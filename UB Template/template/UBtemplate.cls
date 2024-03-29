

\newcommand\fileversion{beta.0.1}
\newcommand\filedate{2022/12/05}
\newcommand\fileauthor{JunjieLi & ManuelLiuWang}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UBtemplate}[\filedate\space A UBtemplate thesis class file by \fileauthor \space (v\fileversion)]
\typeout{https://github.com/junjielyu13/LaTeX_UB_template-no-official-/}


% ******************************************************************************
% **************************** Class Definition ********************************
% ******************************************************************************



% *************************** Pre-defined Options ******************************

% Page Size
\newcommand\PHD@papersize{a4paper} % Set Default as a4paper
\DeclareOption{a4paper}{\renewcommand\PHD@papersize{a4paper}}
\DeclareOption{a5paper}{\renewcommand\PHD@papersize{a5paper}}
\PassOptionsToClass{\PHD@papersize}{book}%


% Font Size
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{book}}%
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{book}}%
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{book}}%

% Page side 
\newif\if@oneside\@onesidefalse
\DeclareOption{oneside}{\PassOptionsToClass{oneside}{book}\@onesidetrue}%
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{book}}%



%  Font Option 
\newif\ifsetFont\setFontfalse                 % Font is not set

\newif\ifPHD@times\PHD@timesfalse             % Times with Math Support
\DeclareOption{times}{
  \ifsetFont
    \ClassWarning{PhDThesisPSnPDF}{Font selection conflict: A font package was
      aleady specified. Please check the document class options in case you 
      have defined two fonts.}
  \else
    \PHD@timestrue
    \setFonttrue
  \fi
}

\newif\ifPHD@fourier\PHD@fourierfalse         % Fourier with Math Support
\DeclareOption{fourier}{
  \ifsetFont
    \ClassWarning{PhDThesisPSnPDF}{Font selection conflict: A font package was
      aleady specified. Please check the document class options in case you 
      have defined two fonts.}
  \else
    \PHD@fouriertrue
    \setFonttrue
  \fi
}

\newif\ifsetCustomFont\setCustomFontfalse     % Custom Font with Math Support
\DeclareOption{customfont}{
  \ifsetFont
    \ClassWarning{PhDThesisPSnPDF}{Font selection conflict: A font package was
      aleady specified. Please check the document class options in case you 
      have defined two fonts.}
  \else
    \setCustomFonttrue
    \setFonttrue
  \fi
}


% *********************** Define a Print/Online Version ************************
\newif\if@print\@printfalse
\DeclareOption{print}{\@printtrue}




% ***************************** Custom Margins  ********************************
%\newif\ifsetCustomMargin\setCustomMarginfalse % Set Custom Margin
%\newif\ifsetMargin\setMarginfalse % Set Custom Margin
%\DeclareOption{custommargin}{\setCustomMargintrue}






% ****************************** Draft Option **********************************
\newif\ifsetDraft\setDraftfalse
%\newif\ifsetDraftClassic\setDraftClassicfalse
% Draft Mode
%\DeclareOption{draftclassic}{\PassOptionsToClass{draft}{book}
%  \setDraftClassictrue
%  \ClassWarning{PhDThesisPSnPDF}{Draft is ON. Don't forget to turn it
%    off in your final version. This is the classic version of draft.
%    Use `draft' for enhanced mode, which adds watermark with timestamp, 
%    line numbering, and version number.}}%

\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{book}
  \setDrafttrue 
  \ClassWarning{PhDThesisPSnPDF}{Draft is ON. Don't forget to turn it
    off in your final version. This enhanced `draft' mode adds watermark 
    with timestamp, line numbering, and version number. Use `draftclassic'
    if you prefer the lassic draft mode. To tweak options see
    `preamble.tex'}}%


% Line Numbers
\newif\ifPHD@lineno\PHD@linenotrue
\DeclareOption{lineno}{\PHD@linenotrue}
\DeclareOption{nolineno}{\PHD@linenofalse}


% Generates Warning for unknown options
\DeclareOption*{
  \ClassWarning{PhDThesisPSnPDF}{Unknown or non-standard option
'\CurrentOption'. I'll see if I can load it from the book class. If you get a
warning unused global option(s): `\CurrentOption` then the option is not
supported!}
  \PassOptionsToClass{\CurrentOption}{book}
}

% Process options and load class
\ProcessOptions\relax%

\LoadClass{book}%




% ******************************************************************************
% ******************************** Packages ************************************
% ******************************************************************************
% ************************** Layout and Formatting *****************************

\RequirePackage{lscape}   % Supports Landscape Layout
\RequirePackage{setspace} % Define line spacing in paragraph
\RequirePackage{calc}     % calculate vertical spacing

% ************************* Conditional Statements *****************************
\RequirePackage{ifthen}   % Conditional statements
\RequirePackage{ifpdf}    % Check for pdfLaTeX
\RequirePackage{ifxetex}  % XeLaTeX



% *************************** Graphics and Figures *****************************
\RequirePackage[usenames, dvipsnames]{color}
\ifpdf
  % Convert eps figures to pdf
  \RequirePackage{epstopdf}
  \RequirePackage[pdftex]{graphicx}
  \DeclareGraphicsExtensions{.png, .jpg, .pdf}
  \pdfcompresslevel=9
  \graphicspath{{Figs/Raster/}{Figs/}}
\else
  \RequirePackage{graphicx}
  \DeclareGraphicsExtensions{.eps, .ps}
  \graphicspath{{Figs/Vector/}{Figs/}}
\fi



% ******************************* Time Stamp ***********************************
% Compute the timestamp based on an idea of
% Tim Piessens \texttt{<Tim.Piessens@esat.kuleuven.ac.be>}.

\RequirePackage{datetime}

\newcount\PHD@hour \newcount\PHD@minute
\PHD@hour=\time
\divide \PHD@hour by 60
\PHD@minute=\time
\count@=\PHD@hour
\multiply \count@ by -60
\advance \PHD@minute by \count@
\newcommand{\PHD@daytime}{%
  \today\space--\space%
  \ifnum\PHD@hour=0 00\else\ifnum\PHD@hour<10 0\fi%
  \number\PHD@hour\fi:\ifnum\PHD@minute<10 0\fi\number\PHD@minute
}

% ******************************* Draft Mode ***********************************
% Initializing Draft Text
\newcommand\SetDraftText[1]{}
% Initializing Draft Version
\newcommand\SetDraftVersion[1]{}
% Initializing Draft Content
\newcommand\SetDraftWMPosition[1]{}
% Initializing Draft Gray Scale
\newcommand\SetDraftGrayScale[1]{}

% Classic Draft Mode
%\ifsetDraftClassic
% Disable figures in `draft'\
%\setkeys{Gin}{draft=true}
%\fi

% If Draft Mode is active
\ifsetDraft
% Disable figures in `draft'\
\setkeys{Gin}{draft=false}

% Line numbering (can be switched off)
\ifPHD@lineno
\RequirePackage[switch,pagewise,mathlines]{lineno}
\renewcommand{\frontmatter}{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
  \nolinenumbers
}
\renewcommand{\mainmatter}{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
  \linenumbers
}
\renewcommand{\backmatter}{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \linenumbers
}

% Fix display lineno issue in mathmode
\newcommand*\patchAmsMathEnvironmentForLineno[1]{%
  \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
  \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
  \renewenvironment{#1}%
     {\linenomath\csname old#1\endcsname}%
     {\csname oldend#1\endcsname\endlinenomath}%
}% 

\newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
  \patchAmsMathEnvironmentForLineno{#1}%
  \patchAmsMathEnvironmentForLineno{#1*}%
}%

\AtBeginDocument{%
  \patchBothAmsMathEnvironmentsForLineno{equation}%
  \patchBothAmsMathEnvironmentsForLineno{align}%
  \patchBothAmsMathEnvironmentsForLineno{flalign}%
  \patchBothAmsMathEnvironmentsForLineno{alignat}%
  \patchBothAmsMathEnvironmentsForLineno{gather}%
  \patchBothAmsMathEnvironmentsForLineno{multline}%
}

\fi % End \ifPDH@lineno

% Creates a Watermark Draft at the specified location.
% The settings can be tweaked in the preamble

% Draft text
\newcommand\drafttext{Draft}
\renewcommand\SetDraftText[1]{%
  \renewcommand\drafttext{#1}
}

% Draft Version
\newcommand\draftVersion{v1.0}
\renewcommand\SetDraftVersion[1]{%
  \renewcommand\draftVersion{#1}
}

% Draft Gray Scale
\newcommand\draftGrayScale{0.75}
\renewcommand\SetDraftGrayScale[1]{%
  \renewcommand\draftGrayScale{#1}
}

% Draft Content
\newcommand\DraftContent{%
  \hspace*{\fill}
  \Large
  \textcolor[gray]{\draftGrayScale}{%
    {\drafttext}\space-\space{\draftVersion}\hspace{\stretch{1}}{\PHD@daytime}
    \hspace*{\fill}
  }
}

% Adding watermark in draft mode with time stamp
\RequirePackage{everypage}
\RequirePackage[absolute]{textpos}
% Default values for draft watermark
\newcommand\draftposition{top}
\newcommand\draftnodeanchor{1in+\voffset-\topmargin}
\AddEverypageHook{%
  \begin{textblock*}{\paperwidth}[0.,2.5](0\paperwidth,\draftnodeanchor)
    \DraftContent
  \end{textblock*}
}

% Conditional evaluation to position the draft water mark  (top / bottom)
\renewcommand\SetDraftWMPosition[1]{%
  \renewcommand\draftposition{#1}
  \ifthenelse{\equal{\draftposition}{bottom}}
    {\renewcommand\draftnodeanchor{\paperheight-\voffset}} %Bottom
    {\ifthenelse{\equal{\draftposition}{top}}
      {\renewcommand\draftnodeanchor{1in+\voffset-\topmargin}} %Top
      {\ClassWarning{PDThesisPSnPDF}{Unrecognised draft position
          using default value of top}
        \renewcommand\draftnodeanchor{1in+\voffset-\topmargin}}} %Top
    
    \AddEverypageHook{%
    \begin{textblock*}{\paperwidth}[0.,2.5](0\paperwidth,\draftnodeanchor)
      \DraftContent
    \end{textblock*}
  }
}

% If NOT Draft
\else 

\renewcommand\SetDraftText[1]{\ClassWarning{PhDThesisPSnPDF}{Draft is
    inactive, to use SetDraftText include `draft' in the document 
    class options.}}
% Draft Version
\renewcommand\SetDraftVersion[1]{\ClassWarning{PhDThesisPSnPDF}{Draft is
    inactive, to use SetDraftVersion include `draft' in the document
    class options.}}
% Draft Content
\renewcommand\SetDraftWMPosition[1]{\ClassWarning{PhDThesisPSnPDF}{Draft
    is inactive, to use SetDraftWMPosition include `draft' in the document
    class options.}}

\renewcommand\SetDraftGrayScale[1]{\ClassWarning{PhDThesisPSnPDF}{Draft is
    inactive, to use SetDraftWMPosition include `draft' in the document
    class options.}}
\fi






% ********************************** Fonts **********************************
\RequirePackage{textcomp}
% Font Selection
\ifPHD@times
  \ifxetex
  \else
    \RequirePackage{mathptmx}  % times roman, including math (where possible)
  \fi
  \setFonttrue
  \message{PhDThesisPSnPDF: Using Times Roman font}
\else
  \ifPHD@fourier
    \RequirePackage{fourier} % Fourier
    \setFonttrue
    \message{PhDThesisPSnPDF: Using Fourier font}
  \else
    \ifsetCustomFont
      \setFonttrue
      \message{PhDThesisPSnPDF: Using custom font}
    \else
      \setFontfalse
      \message{PhDThesisPSnPDF: No font is set}
    \fi % custom font
  \fi % Fourier font
\fi % Times font

% If Font is not set throw a warning.
\ifsetFont
\else
  \ClassWarning{PhDThesisPSnPDF}{Using default font Latin Modern. If you
    would like to use other pre-defined fonts use `times' (The Cambridge 
    University PhD thesis guidelines recommend using Times font)  or `fourier'
    or load a custom font in the preamble.tex file by specifying `customfont' 
    in the class options}
  \RequirePackage{lmodern}
\fi


\ifxetex
  % XeLaTeX
  \usepackage{amsmath}
  \usepackage{fontspec}
  \usepackage[]{unicode-math}
  \setmainfont[
    Extension = .otf,
    UprightFont = *-regular,
    BoldFont = *-bold,
    ItalicFont = *-italic,
    BoldItalicFont = *-bolditalic,
  ]{xits}
  
  \setmathfont[ 
    Extension = .otf,
    BoldFont = *bold,
  ]{xits-math}
  
\else
  % default: pdfLaTeX
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  
  % If building with PDFLaTeX, use microtype spacing adjustments
  \RequirePackage[final]{microtype}
  
  \input{glyphtounicode}
  \pdfglyphtounicode{f_f}{FB00}
  \pdfglyphtounicode{f_i}{FB01}
  \pdfglyphtounicode{f_l}{FB02}
  \pdfglyphtounicode{f_f_i}{FB03}
  \pdfglyphtounicode{f_f_l}{FB04}
  \pdfgentounicode=1

  \RequirePackage{amsfonts}
  \RequirePackage{amsmath}
  \RequirePackage{amssymb}
\fi

% Don't break enumeration (etc.) across pages in an ugly manner
\clubpenalty=10000
\widowpenalty=10000



%******************************* Print / Online ********************************
% Defines a print / online version to define page-layout and hyperrefering

% Moved below other usepackage definitions to fix PDFLaTeX footnote warning
% Based on the suggestion by John Plaice

\RequirePackage[unicode=true]{hyperref}

\if@print
  % For Print version
  \hypersetup{
    final=true,
    plainpages=false,
    pdfstartview=FitV,
    pdftoolbar=true,
    pdfmenubar=true,
    bookmarksopen=true,
    bookmarksnumbered=true,
    breaklinks=true,
    linktocpage,
    colorlinks=true,
    linkcolor=black,
    urlcolor=black,
    citecolor=black,
    anchorcolor=black
  }
  %\ifsetCustomMargin
  % Margin to be define in preamble using geometry package
  %\else
  %  \RequirePackage[paper=\PHD@papersize,hmarginratio=1:1,
  %    vmarginratio=1:1,scale=0.75,bindingoffset=5mm]{geometry}
  %\fi
  %    
  \if@twoside
    \hypersetup{pdfpagelayout=TwoPageRight}
  \else
    \hypersetup{pdfpagelayout=OneColumn}
  \fi

\else
  % For PDF Online version
  \hypersetup{
    final=true,
    plainpages=false,
    pdfstartview=FitV,
    pdftoolbar=true,
    pdfmenubar=true,
    bookmarksopen=true,
    bookmarksnumbered=true,
    breaklinks=true,
    linktocpage,
    colorlinks=true,
    linkcolor=blue,
    urlcolor=blue,
    citecolor=blue,
    anchorcolor=green
  }

  %\ifsetCustomMargin
   % % Margin to be define in preamble using geometry package
    %\else
     % % No Margin staggering on Odd and Even side
      %\RequirePackage[paper=\PHD@papersize,hmarginratio=1:1,
       % vmarginratio=1:1,scale=0.75]{geometry} % dvips
    %\fi
    \hypersetup{pdfpagelayout=OneColumn}
\fi



% ************************ URL Package and Definition **************************
\RequirePackage{url}
% Redefining urlstyle to use smaller fontsize in References with URLs
\newcommand{\url@leostyle}{%
 \@ifundefined{selectfont}{\renewcommand{\UrlFont}{\sffamily}}
 {\renewcommand{\UrlFont}{\normalsize}}}
\urlstyle{leo}

% option to split urls over multiple lines for latex >> DVIPS >> PDF option
\ifpdf
  % PDFLaTeX does it automatically.
\else
  % dvips
  \RequirePackage{breakurl} % to split the url over multiple lines
\fi
  
% ******************************************************************************
% **************************** Pre-defined Settings ****************************
% ******************************************************************************

% *************************** Setting PDF Meta-Data ****************************
\ifpdf
\AtBeginDocument{
  \hypersetup{
    pdftitle = {\@title},
    pdfauthor = {\@author},
    pdfsubject={\@subject},
    pdfkeywords={\@keywords}
  }
}
\fi



% ******************************** Line Spacing ********************************
% Set spacing as 1.5 line spacing for the PhD Thesis
% In practice, fortunately, nobody knows really what “one-and-a-half spaced
% type” means exactly (in terms of millimetres baseline distance). The following
% LaTeX setting has routinely been considered perfectly acceptable:

\renewcommand\baselinestretch{1.2}



% ******************************************************************************
% **************************** Macro Definitions *******************************
% ******************************************************************************
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

% Subtitle (optional)
\newcommand{\@subtitle}{}
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}

% The year and term the degree will be officially conferred
\newcommand{\@degreedate}{\monthname[\the\month]\space\the\year}
\newcommand{\degreedate}[1]{\renewcommand{\@degreedate}{#1}}

% The full (unabbreviated) name of the degree
\newcommand{\@degreetitle}{}
\newcommand{\degreetitle}[1]{\renewcommand{\@degreetitle}{#1}}

% The name of your department(eg. Engineering, Maths, Physics)
\newcommand{\@dept}{}
\newcommand{\dept}[1]{\renewcommand{\@dept}{#1}}

% The name of your college (eg. King's)
\newcommand{\@college}{}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}

% The name of your University
\newcommand{\@university}{}
\newcommand{\university}[1]{\renewcommand{\@university}{#1}}

% Defining the crest
\newcommand{\@crest}{}
\newcommand{\crest}[1]{\renewcommand{\@crest}{#1}}

% Defining the college crest
\newif\ifPHD@collegeshield\PHD@collegeshieldfalse
\newcommand{\@collegeshield}{}
\newcommand{\collegeshield}[1]{\renewcommand{\@collegeshield}{#1}\PHD@collegeshieldtrue}

% Supervisor
\newif\ifPHD@supervisor\PHD@supervisorfalse
\newcommand{\@supervisor}{}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisor}{#1}\PHD@supervisortrue}

% Supervisor Title (Supervisor - Default, can be changed)
\newcommand{\@supervisorrole}{Supervisor: }
\newcommand{\supervisorrole}[1]{\renewcommand{\@supervisorrole}{#1}}

% Supervisor width to align
\newcommand{\@supervisorlinewidth}{0.35\textwidth}
\newcommand{\supervisorlinewidth}[1]{\renewcommand{\@supervisorlinewidth}{#1}}

% Advisor
\newif\ifPHD@advisor\PHD@advisorfalse
\newcommand{\@advisor}{}
\newcommand{\advisor}[1]{\renewcommand{\@advisor}{#1}\PHD@advisortrue}

% Advisor Title (Advisor - Default, can be changed)
\newcommand{\@advisorrole}{Advisor: }
\newcommand{\advisorrole}[1]{\renewcommand{\@advisorrole}{#1}}

% Advisor width to align
\newcommand{\@advisorlinewidth}{0.25\textwidth}
\newcommand{\advisorlinewidth}[1]{\renewcommand{\@advisorlinewidth}{#1}}

% Submission Text
\newcommand{\submissiontext}{This dissertation is submitted for the degree of }

% keywords (These keywords will appear in the PDF meta-information
% called `pdfkeywords`.)
\newcommand{\@keywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}

% subjectline (This subject will appear in the PDF meta-information
% called `pdfsubject`.)
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{#1}}


% These macros define an environment for front matter that is always
% single column even in a double-column document.
\newenvironment{alwayssingle}{%
       \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
       \else\newpage\fi}
       {\if@restonecol\twocolumn\else\newpage\fi}

% Set single column even under two column layout
\newcommand{\setsinglecolumn}{
\if@twocolumn
   \onecolumn
\else
\fi
}


% ******************************************************************************
% *************************** Front Matter Layout ******************************
% ******************************************************************************

% ******************************** Title Page **********************************
\renewcommand{\maketitle}{

% To compute the free vertical space in Title page
\computeTitlePageSpacing

\thispagestyle{empty}

\begin{singlespace}
\begin{center}

% University Crest Long if college crest is defined
\ifPHD@collegeshield%
	{\usebox{\PHD@crest}}
	\vspace{.15\PHD@titlepagespacing}
\fi

% Title
{\usebox{\PHD@Title}} % subtitle is defined


% Crest

\ifPHD@collegeshield%
	\vspace{.15\PHD@titlepagespacing}
	{\usebox{\PHD@collegecrest}}
	\vspace{.1\PHD@titlepagespacing}
\else
	\vspace{.25\PHD@titlepagespacing}
	{\usebox{\PHD@crest}}
	\vspace{.15\PHD@titlepagespacing}
\fi



% Author
{\usebox{\PHD@author}}
\vspace*{1em}

% Supervisor
\ifPHD@supervisor%
{\usebox{\PHD@supervisor}}
\vspace*{0.5em}
\fi

% Advisor
\ifPHD@advisor%
{\usebox{\PHD@advisor}}
\vspace*{0.5em}
\fi

% Department and University
{\usebox{\PHD@dept}}
\vspace{.2\PHD@titlepagespacing}

% Submission Text
{\usebox{\PHD@submission}}

% College and degree date
\vfill
{\usebox{\PHD@collegedate}}
    
\end{center}

\end{singlespace}

}


% ******************** To compute empty space in title page *******************
% Boxes below are used to space different contents on the title page
% Based on https://github.com/cambridge/thesis

\newcommand{\computeTitlePageSpacing}{


% Title Box
\newsavebox{\PHD@Title}
\begin{lrbox}{\PHD@Title}
  \begin{minipage}[c]{0.98\textwidth}
    \centering \Huge \bfseries{\@title}
    \ifthenelse{\equal{\@subtitle}{}}{
      % subtitle is not defined
    }{
      \\
      \centering \Large {\@subtitle}
    } % subtitle is defined
  \end{minipage}
\end{lrbox}

% University Crest Box
\newsavebox{\PHD@crest}
\begin{lrbox}{\PHD@crest}
  {\@crest \par}
\end{lrbox}

\newsavebox{\PHD@collegecrest}
\begin{lrbox}{\PHD@collegecrest}
  \ifPHD@collegeshield%
    {\@collegeshield}
  \else
    % College shield is undefined
  \fi
\end{lrbox}

% Author Box
\newsavebox{\PHD@author}
\begin{lrbox}{\PHD@author}
  \begin{minipage}[c]{\textwidth}
    \centering \Large \bfseries{\@author}
      \vspace{0.5em}   
  \end{minipage}
\end{lrbox}

% Supervisor Box
\newsavebox{\PHD@supervisor}
\begin{lrbox}{\PHD@supervisor}
  \begin{minipage}[c]{\textwidth}
    \ifthenelse{\equal{\@supervisor}{}}{
      % supervisor is not defined
    }{
      \begin{center}
        \makebox[\widthof{supervisorrole} + \@supervisorlinewidth][c]{
          \Large
          \@supervisorrole \parbox[t]{\@supervisorlinewidth}{\@supervisor}
        }
      \end{center}
      \vspace{0.5em}
    } % supervisor is defined
  \end{minipage}
\end{lrbox}

% Advisor Box
\newsavebox{\PHD@advisor}
\begin{lrbox}{\PHD@advisor}
  \begin{minipage}[c]{\textwidth}
    \ifthenelse{\equal{\@advisor}{}}{
      % advisor is not defined
    }{
      \begin{center}
        \makebox[\widthof{advisorrole} + \@advisorlinewidth][c]{
          \Large
          \@advisorrole \parbox[t]{\@advisorlinewidth}{\@advisor}
        }
      \end{center}
      \vspace{0.5em}
    } % advisor is defined
  \end{minipage}
\end{lrbox}

% Department Box
\newsavebox{\PHD@dept}
\begin{lrbox}{\PHD@dept}
  \begin{minipage}[c]{\textwidth}
    \centering {\large \@dept \par}
	       {\large \@university \par}
  \end{minipage}
\end{lrbox}

% Submission Box
\newsavebox{\PHD@submission}
\begin{lrbox}{\PHD@submission}
  \begin{minipage}[c]{\textwidth}
    \begin{center}
      \large \submissiontext \par
      \large \textit {\@degreetitle} \par
    \end{center}
  \end{minipage}
\end{lrbox}

% College and Date Box
\newsavebox{\PHD@collegedate}
\begin{lrbox}{\PHD@collegedate}
\begin{minipage}[c]{\textwidth}
  \large
  \ifthenelse{\equal{\@college}{}}{
    % college is not defined
    \begin{center}
      \@degreedate
    \end{center}
  }{
    % college is defined
    \begin{minipage}[b]{0.49\textwidth}
      \flushleft\@college
    \end{minipage}
    \begin{minipage}[b]{0.49\textwidth}
      \flushright \@degreedate
    \end{minipage}
  } % college is defined
\end{minipage}
\end{lrbox}

%  Now to compute the free vertical space
\newlength{\PHD@titlepagespacing}
\setlength{\PHD@titlepagespacing}{ \textheight %
			- \totalheightof{\usebox{\PHD@Title}}
			- \totalheightof{\usebox{\PHD@crest}}
			- \totalheightof{\usebox{\PHD@collegecrest}}
			- \totalheightof{\usebox{\PHD@author}}
                   	- \totalheightof{\usebox{\PHD@supervisor}}
                   	- \totalheightof{\usebox{\PHD@advisor}}
			- \totalheightof{\usebox{\PHD@dept}}
			- \totalheightof{\usebox{\PHD@submission}}
			- \totalheightof{\usebox{\PHD@collegedate}}
}
}
