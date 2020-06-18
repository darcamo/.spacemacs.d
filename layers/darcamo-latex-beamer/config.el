(define-derived-mode beamer-mode
  LaTeX-mode "Beamer-Mode" "A derived mode from LaTeX-mode for latex buffers with beamer presentations."
  (setq outline-regexp "[   ]*\\\\\\(appendix\\|documentstyle\\|documentclass\\|part\\|chapter\\|section\\|subsection\\|subsubsection\\|paragraph\\|subparagraph\\|begin{frame}\\|end{frame}\\)\\|^[^%\n]*\\\\begin *{document}\\|^[^%\n]*\\\\end *{document}")

  (setq reftex-section-levels
        '(("section" . 1) ("subsection" . 2) ("frametitle" . 3)))

  ;; (TeX-PDF-mode 1)  ;; Turn on PDF mode.

  (setq LaTeX-beamer-item-overlay-flag nil)
  (reftex-mode 1)
  (reftex-reset-mode)
  )


;; Add some beamer commands as font-lock keywords
;; (font-lock-add-keywords 'tikz-mode
;;                         '(("\\(\\\\\\(frametitle\\|framesubtitle\\)\\){" 1 font-lock-warning-face t)))


;; A file called presentations.tex is automatically in beamer-mode
(add-to-list 'auto-mode-alist '("presentation\\.tex" . beamer-mode))








(define-skeleton beamer-skeleton
  "Inserts a Latex beamer skeleton into current buffer.
This only makes sense for empty buffers."
  nil
  "\\documentclass{beamer}
% \\documentclass[draft,handout]{beamer}
% \\documentclass[handout, notes=show/hide/only]{beamer}
% \\usepackage[orientation=landscape,size=custom,width=16,height=9,scale=0.5,debug]{beamerposter}

\\mode<presentation>
{
  \\usetheme{AnnArbor}
%   Possible Themes:
%   \"AnnArbor\" \"Antibes\" \"Bergen\" \"Berkeley\" \"Berlin\" \"Boadilla\"
%   \"boxes\" \"CambridgeUS\" \"Copenhagen\" \"Darmstadt\" \"Dresden\"
%   \"Frankfurt\" \"Goettingen\" \"Hannover\" \"Ilmenau\" \"JuanLesPins\"
%   \"Luebeck\" \"Madrid\" \"Malmoe\" \"Marburg\" \"Montpellier\" \"PaloAlto\"
%   \"Pittsburgh\" \"Rochester\" \"Singapore\" \"Szeged\" \"Warsaw\"
%   \"default\"
%
%   Best Ones:
%   AnnArbor or CambridgeUS, Dresden or Frankfurt or Singapore, Goettingen or Hannover or Marburg, JuanLesPins, Madrid, PaloAlto, Warsaw

  \\setbeamercovered{transparent} % How uncovered text showld appear. Possible values are: invisible,
                                 % transparent, dynamic, highly dynamic, still covered, still
                                 % covered, again covered.
%   \\usecolortheme{wolverine}
%   \\usefonttheme{serif}
%   \\useinnertheme{circles}
%   \\useoutertheme{shadow}


\\usepackage[english]{babel}
%\\usepackage[latin1]{inputenc} % Use this if the file is encoded with windows encoding
\\usepackage[utf8]{inputenc} % Use this if the file is encoded with utf-8
\\usepackage{times}
\\usepackage[T1]{fontenc}
\\usepackage{amsmath} % Part of AMS-LaTeX
% One of the good things of the amsmath package is the math enviroments matrix, pmatrix, bmatrix, Bmatrix, vmatrix and Vmatrix
\\usepackage{graphicx}
\\usepackage{pgf}
%\\usepackage{tikz} % Create graphics in Latex
%\\usepackage{listings} % Typeset source code for many languages

% Pegue em http://www.guidodiepen.nl/2009/07/creating-latex-beamer-handouts-with-notes/
%\\usepackage{handoutWithNotes}
%\\pgfpagesuselayout{4 on 1 with notes}[a4paper,border shrink=5mm]

% \\setbeameroption{show notes}
% \\setbeameroption{show only notes}
}

\\title"
  (setq v1 (skeleton-read "Short Title for the Presentation: " "[short title]"))" % [short title] (optional, use only with long paper titles)" \n
  "{"(skeleton-read "Title for the Presentation: ")"}" \n \n
  _ "%\\subtitle{Include Only If Paper Has a Subtitle} % (optional)" \n \n
  "\\author%[Author, Another] % (Optional, use only with lots of authors)" \n
  "{" (skeleton-read "Author(s) - Use \\and to separate: " "Darlan Cavalcante Moreira") "}" \n
  "%{F.~Author\\inst{1} \\and S.~Another\\inst{2}}" \n
  "% - Give the names in the same order as the appear in the paper." \n
  "% - Use the \\inst{?} command only if the authors have different affiliation." \n \n
  "\\institute%[Universities of Somewhere and Elsewhere] % (Short version: optional, but mostly needed)" \n
  "{" (skeleton-read "Instituto: " "Universidade Federal do Ceará") "}" \n
  "% {
%   \\inst{1}
%   Department of Computer Science\\\\
%   University of Somewhere
%   \\and
%   \\inst{2}
%   Department of Theoretical Philosophy\\\\
%   University of Elsewhere}
  % - Use the \\inst command only if there are several affiliations.
  % - Keep it simple, no one is interested in your street address." \n
  "\\date{" (skeleton-read "Date: " "\\today") "}" \n
  "%\\date[CFP 2003] % (optional, should be abbreviation of conference name)
   %{Conference on Fabulous Presentations, 2003}
   % - Either use conference name or its abbreviation.
   % - Not really informative to the audience, more for people (including
   %   yourself) who are reading the slides online" \n \n \n
   "% xxxxxxxxxx For \"PDF information catalog\", can be left out xxxxxxxxxxxxxxxxxxxx
\\subject{Subject of the presentation}
\\keywords{keyword1, kwyword2}

% If you have a file called \"university-logo-filename.xxx\", where xxx
% is a graphic format that can be processed by latex or pdflatex,
% resp., then you can add a logo as follows:

% \\pgfdeclareimage[height=0.5cm]{university-logo}{university-logo-filename}
% \\logo{\\pgfuseimage{university-logo}}

% this shows the outline at the beginning of every section,
% highlighting the current section
% \\AtBeginSection[]
% {
%   \\begin{frame}<beamer>{}
%     \\frametitle{Outline}
%     \\tableofcontents[currentsection]
%   \\end{frame}
% }


% If you wish to uncover everything in a step-wise fashion, uncomment
% the following command:
% \\beamerdefaultoverlayspecification{<+->}
% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \n \n \n
"% xxxxxxxxxxxxxxx Presentation Structure xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
% Structuring a talk is a difficult task and the following structure
% may not be suitable. Here are some rules that apply for this
% solution:

% - Exactly two or three sections (other than the summary).
% - At *most* three subsections per section.
% - Talk about 30s to 2min per frame. So there should be between about
%   15 and 30 frames, all told.

% - A conference audience is likely to know very little of what you
%   are going to talk about. So *simplify*!
% - In a 20min talk, getting the main ideas across is hard
%   enough. Leave out details, even if it means being less precise than
%   you think necessary.
% - If you omit details that are vital to the proof/implementation,
%   just say so once. Everybody will be happy with that.
% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \n \n \n
"% xxxxxxxxxxxxxxx Frame Options xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
% [plain] -> Use the \"plain\" option when you want a frame with just a picture or table without anything-else
% [fragile] -> Use the \"fragile\" option when the verbatim environment or the \\verb command is used inside the frame
% You must also use the fragile option if you use the lstlisting environment since it is similar to verbatim" \n \n \n
"% xxxxxxxxxxxxxxx Useful Tips xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
% Blocks are another nice way to make highlighted blocks of text (or anything).
%
% \\begin{block}{Simple block}
%   bla bla bla
% \\end{block}
%
% \\begin{exampleblock}{Example block}
%   bla bla bla
% \\end{exampleblock}
%
% \\begin{alertblock}{}
%   bla bla bla
% \\end{alertblock}
%
% Columns are for vertically organizing text.
% The beamer screen is 128 mm $\\times$ 96 mm.
% Two columns of 6cm appears to work well. Remember to make
% allowance for margins around the stuff inside a column. Three
% columns of 4cm for figures may work as well.
%   \\begin{columns}[t] % try also others different of [t]
%     \\begin{column}{6cm}
%       Stuff inside the first column
%     \\end{column}
%     \\begin{column}{6cm}
%       Stuff inside the second column
%     \\end{column}
%   \\end{columns}
%
% You can use externally launched movies with
% \\href{run:default.avi}{click here to open the movie}
%
% Besides using overlays you can also emphasize using
% \\item<1- | alert@1>
% \\item<2- | alert@2> ...
%
% Overlays can also be used with blocks
% \\begin{block}{Some block}<1->
%   bla bla bla
% \\end{block}
% \\begin{block}{Some other block}<2->
%   bla bla bla
% \\end{bloc}
%
% Ofcourse overlays can also be used with images
% \\pgfuseimage{imagem1}<1>
% \\pgfuseimage{imagem2}<2>
% \\pgfuseimage{imagem3}<3>
%
% Example using columns:
% \\begin{columns}[t]
%   \\begin{column}{5cm}
%     \\pgfdeclareimage[width=5cm]{automato1}{automato1}
%     \\pgfuseimage{automato1}<1>
%     \\pgfdeclareimage[width=5cm]{automato2}{automato2}
%     \\pgfuseimage{automato2}<2>
%     \\pgfdeclareimage[width=5cm]{automato3}{automato3}
%     \\pgfuseimage{automato3}<3>
%     \\pgfdeclareimage[width=5cm]{automato4}{automato4}
%     \\pgfuseimage{automato4}<4>
%   \\end{column}
%   \\begin{column}{5cm}
%     \\begin{itemize}
%     \\item <1- | alert@1> Reconhecimento inicia no estado $q_1$
%     \\item <2- | alert@2> Transição para estado $q_2$
%     \\item <3- | alert@3> L^e $0$ e fica no estado $q_2$
%     \\item <4- | alert@4> Transição para o estado final $q_3$
%     \\end{itemize}
%     \\[\\xymatrix{
%      *++[o][F-]{q_1} \\ar@(ul,ul)[] \\ar[r]^{1}
%      \\ar[d]^{0} & *++[o][F=]{q_3} \\\\
%      *++[o][F-]{q_2} \\ar[ur]_{1} \\ar@(dl,d)[]_{0} }\\]
%   \\end{column}
% \\end{columns}
% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \n \n \n
"\\begin{document}" \n \n
"% % xxxxxxxxxxxxxxxxxxxx Some tikz options xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
% % For every picture that defines or uses external nodes, you'll have to
% % apply the 'remember picture' style. To avoid some typing, we'll apply
% % the style to all pictures.
% \\tikzstyle{every picture}+=[remember picture]

% % By default all math in TikZ nodes are set in inline mode. Change this to
% % displaystyle so that we don't get small fractions.
% \\everymath{\\displaystyle}
% % xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \n \n \n
"% \\part{Part 1}

% beamer makes the titlepage from info above: author, date, title, etc.
\\begin{frame}
  \\titlepage
\\end{frame}

% beamer makes the ToC from sections and subsections below...
\\begin{frame}{Outline}
%  \\frametitle{Outline} % Frame Title can be an option of the frame environment or called explicitaly with the \\frametitle command
  \\tableofcontents%[part=1]
% You might wish to add the option [pausesections]
% There are also options such as currentsection, currentsubsection, etc.
\\end{frame}

% \\begin{frame}
% \\frametitle{Outline}
% \\tableofcontents[part=2]
% \\end{frame}" \n \n \n
"\\section{Motivation}

\\subsection{The Basic Problem That We Studied}

\\begin{frame}{Make Titles Informative.}{Subtitles are optional.} % Use Uppercase Letters
  % - A title should summarize the slide in an understandable fashion
  % for anyone how does not follow everything on the slide itself.
  % Frame transition effects
  \\transboxin<1>
%   \\transblindshorizontal
%   \\transblindsvertical
%   \\transboxin
%   \\transboxout
%   \\transdissolve
%   \\transglitter
%   \\transsplithorizontalin
%   \\transsplithorizontalout
%   \\transsplitverticalin
%   \\transsplitverticalout
%   \\transwipe

  \\begin{itemize}
  \\item Use \\texttt{itemize} a lot.
  \\item Use very short sentences or short phrases.
  \\item ação
  \\end{itemize}
\\end{frame}" \n \n \n
"\\begin{frame}{Make Titles Informative.}%[options] % A good option when using figures or tables is the \"plain\" option

  You can create overlays\\dots
  \\begin{itemize}
  \\item using the \\texttt{pause} command:
    \\begin{itemize}
    \\item
      First item.
      \\pause
    \\item
      Second item.
    \\end{itemize}
  \\item
    using overlay specifications:
    \\begin{itemize}
    \\item<3->
      First item.
    \\item<4->
      Second item.
      \\note[item]{Uma nota}<1>
    \\end{itemize}
  \\item
    using the general \\texttt{uncover} command:
    \\begin{itemize}
      \\uncover<5->{\\item
        First item.}
      \\uncover<6->{\\item
        Second item.}
    \\end{itemize}
  \\end{itemize}
  \\note[item]{Outra nota}<1> % Without the overlay specification the note will be added in all slides of a frame. This usually is not what you want.
\\end{frame}" \n \n \n
"\\subsection{Previous Work}

\\begin{frame}{Make Titles Informative.}
\\end{frame}

\\begin{frame}{Make Titles Informative.}
\\end{frame}" \n \n \n
"\\section{Our Results/Contribution}

\\subsection{Main Results}

\\begin{frame}{Make Titles Informative.}
\\end{frame}

\\begin{frame}{Make Titles Informative.}
\\end{frame}

\\begin{frame}{Make Titles Informative.}
\\end{frame}


\\subsection{Basic Ideas for Proofs/Implementation}

\\begin{frame}{Make Titles Informative.}
\\end{frame}

\\begin{frame}{Make Titles Informative.}
\\end{frame}

\\begin{frame}{Make Titles Informative.}
\\end{frame}" \n \n \n
"\\section*{Summary}

\\begin{frame}{Summary}

  % Keep the summary *very short*.
  \\begin{itemize}
  \\item
    The \\alert{first main message} of your talk in one or two lines.
  \\item
    The \\alert{second main message} of your talk in one or two lines.
  \\item
    Perhaps a \\alert{third message}, but not more than that.
  \\end{itemize}

  % The following outlook is optional.
  \\vskip0pt plus.5fill
  \\begin{itemize}
  \\item
    Outlook
    \\begin{itemize}
    \\item
      Something you haven't solved.
    \\item
      Something else you haven't solved.
    \\end{itemize}
  \\end{itemize}
\\end{frame}" \n \n \n
"% All of the following is optional and typically not needed.
\\appendix
\\section<presentation>*{\\appendixname}
\\subsection<presentation>*{For Further Reading}

\\begin{frame}[allowframebreaks]
  \\frametitle<presentation>{For Further Reading}

  \\begin{thebibliography}{10}

    \\beamertemplatebookbibitems
    % Start with overview books.

  \\bibitem{Author1990}
    A.~Author.
    \\newblock {\\em Handbook of Everything}.
    \\newblock Some Press, 1990.

    \\beamertemplatearticlebibitems
    % Followed by interesting articles. Keep the list short.

  \\bibitem{Someone2000}
    S.~Someone.
    \\newblock On this and that.
    \\newblock {\\em Journal of This and That}, 2(1):50--100,
    2000.
  \\end{thebibliography}
\\end{frame}

\\end{document}" \n \n
(beamer-mode)
)



(setq LaTeX-beamer-item-overlay-flag nil)
