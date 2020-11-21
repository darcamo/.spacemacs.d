
;; Org Default Backends
(with-eval-after-load 'org
  (add-to-list 'org-export-backends 'md)
  (add-to-list 'org-export-backends 'odt)

  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines))
  )


;; Use unicode character for non-breaking space in org-mode
;;
;; In org-mode one must use `\nbsp{}` to represent a non-breaking space. This is
;; replaced by `~` in Latex and by `&nbsp;` in HTML. However, its annoying and
;; ugly to have `\nbsp{}` in the org-mode buffer. The code below adds a filter
;; in org-export that replaces the unicode character for non-breaking space with
;; the appropriated value such that it can be used instead of `\nbsp{}`.
;; NOTE: You can enter the unicode non-breaking space with `C-x 8 SPC`
(defun darlan/replace-unicode-non-break-space-org-filter (text backend info)
  "Replace the unicode character for nonbreaking space with '~' in latex,
'&nbsp;' in HTML, and a regular space in other backends."
  (if (org-export-derived-backend-p backend 'latex)
      (replace-regexp-in-string " "
                                "~"
                                text)
    (if (org-export-derived-backend-p backend 'html)
        (replace-regexp-in-string " "
                                  "&nbsp;"
                                  text)
      (replace-regexp-in-string " "
                                " "
                                text))
    )
  )

(with-eval-after-load 'ox
  (add-to-list 'org-export-filter-body-functions 'darlan/replace-unicode-non-break-space-org-filter)
  )



;; String with code to configure MathJax with my custom commands
;; This must come BEFORE mathjax is included
(setq darlan-mathjax-config-string "<script>
 window.MathJax = {
     TeX: {
         Macros: {
             // New Operators
             E: \"\\\\mathbb{E}\",
             Mod: [\"\\\\left \\\\vert #1 \\\\right \\\\vert\", 1],
             diag: \"{\\\\mathop{\\\\rm diag}\\\\nolimits}\",
             rank: \"{\\\\mathop{\\\\rm rank}\\\\nolimits}\",
             // Matrices
             mtA: \"\\\\mathbf{A}\",
             mtB: \"\\\\mathbf{B}\",
             mtC: \"\\\\mathbf{C}\",
             mtD: \"\\\\mathbf{D}\",
             mtE: \"\\\\mathbf{E}\",
             mtF: \"\\\\mathbf{F}\",
             mtG: \"\\\\mathbf{G}\",
             mtH: \"\\\\mathbf{H}\",
             mtI: \"\\\\mathbf{I}\",
             mtJ: \"\\\\mathbf{J}\",
             mtK: \"\\\\mathbf{K}\",
             mtL: \"\\\\mathbf{L}\",
             mtM: \"\\\\mathbf{M}\",
             mtN: \"\\\\mathbf{N}\",
             mtO: \"\\\\mathbf{P}\",
             mtP: \"\\\\mathbf{P}\",
             mtQ: \"\\\\mathbf{Q}\",
             mtR: \"\\\\mathbf{R}\",
             mtS: \"\\\\mathbf{S}\",
             mtT: \"\\\\mathbf{T}\",
             mtU: \"\\\\mathbf{U}\",
             mtV: \"\\\\mathbf{V}\",
             mtW: \"\\\\mathbf{W}\",
             mtX: \"\\\\mathbf{X}\",
             mtY: \"\\\\mathbf{Y}\",
             mtZ: \"\\\\mathbf{Z}\",
             // Vectors
             vtA: \"\\\\mathbf{a}\",
             vtB: \"\\\\mathbf{b}\",
             vtC: \"\\\\mathbf{c}\",
             vtD: \"\\\\mathbf{d}\",
             vtE: \"\\\\mathbf{e}\",
             vtF: \"\\\\mathbf{f}\",
             vtG: \"\\\\mathbf{g}\",
             vtH: \"\\\\mathbf{h}\",
             vtI: \"\\\\mathbf{i}\",
             vtJ: \"\\\\mathbf{j}\",
             vtK: \"\\\\mathbf{k}\",
             vtL: \"\\\\mathbf{l}\",
             vtM: \"\\\\mathbf{m}\",
             vtN: \"\\\\mathbf{n}\",
             vtO: \"\\\\mathbf{p}\",
             vtP: \"\\\\mathbf{p}\",
             vtQ: \"\\\\mathbf{q}\",
             vtR: \"\\\\mathbf{r}\",
             vtS: \"\\\\mathbf{s}\",
             vtT: \"\\\\mathbf{t}\",
             vtU: \"\\\\mathbf{u}\",
             vtV: \"\\\\mathbf{v}\",
             vtW: \"\\\\mathbf{w}\",
             vtX: \"\\\\mathbf{x}\",
             vtY: \"\\\\mathbf{y}\",
             vtZ: \"\\\\mathbf{z}\",
             // Sets
             stA: \"\\\\mathcal{A}\",
             stB: \"\\\\mathcal{B}\",
             stC: \"\\\\mathcal{C}\",
             stD: \"\\\\mathcal{D}\",
             stE: \"\\\\mathcal{E}\",
             stF: \"\\\\mathcal{F}\",
             stG: \"\\\\mathcal{G}\",
             stH: \"\\\\mathcal{H}\",
             stI: \"\\\\mathcal{I}\",
             stJ: \"\\\\mathcal{J}\",
             stK: \"\\\\mathcal{K}\",
             stL: \"\\\\mathcal{L}\",
             stM: \"\\\\mathcal{M}\",
             stN: \"\\\\mathcal{N}\",
             stO: \"\\\\mathcal{P}\",
             stP: \"\\\\mathcal{P}\",
             stQ: \"\\\\mathcal{Q}\",
             stR: \"\\\\mathcal{R}\",
             stS: \"\\\\mathcal{S}\",
             stT: \"\\\\mathcal{T}\",
             stU: \"\\\\mathcal{U}\",
             stV: \"\\\\mathcal{V}\",
             stW: \"\\\\mathcal{W}\",
             stX: \"\\\\mathcal{X}\",
             stY: \"\\\\mathcal{Y}\",
             stZ: \"\\\\mathcal{Z}\",
             // Calligraphic
             calA: \"\\\\mathcal{A}\",
             calB: \"\\\\mathcal{B}\",
             calC: \"\\\\mathcal{C}\",
             calD: \"\\\\mathcal{D}\",
             calE: \"\\\\mathcal{E}\",
             calF: \"\\\\mathcal{F}\",
             calG: \"\\\\mathcal{G}\",
             calH: \"\\\\mathcal{H}\",
             calI: \"\\\\mathcal{I}\",
             calJ: \"\\\\mathcal{J}\",
             calK: \"\\\\mathcal{K}\",
             calL: \"\\\\mathcal{L}\",
             calM: \"\\\\mathcal{M}\",
             calN: \"\\\\mathcal{N}\",
             calO: \"\\\\mathcal{P}\",
             calP: \"\\\\mathcal{P}\",
             calQ: \"\\\\mathcal{Q}\",
             calR: \"\\\\mathcal{R}\",
             calS: \"\\\\mathcal{S}\",
             calT: \"\\\\mathcal{T}\",
             calU: \"\\\\mathcal{U}\",
             calV: \"\\\\mathcal{V}\",
             calW: \"\\\\mathcal{W}\",
             calX: \"\\\\mathcal{X}\",
             calY: \"\\\\mathcal{Y}\",
             calZ: \"\\\\mathcal{Z}\",
             // Blackboard
             bbA: \"\\\\mathbb{A}\",
             bbB: \"\\\\mathbb{B}\",
             bbC: \"\\\\mathbb{C}\",
             bbD: \"\\\\mathbb{D}\",
             bbE: \"\\\\mathbb{E}\",
             bbF: \"\\\\mathbb{F}\",
             bbG: \"\\\\mathbb{G}\",
             bbH: \"\\\\mathbb{H}\",
             bbI: \"\\\\mathbb{I}\",
             bbJ: \"\\\\mathbb{J}\",
             bbK: \"\\\\mathbb{K}\",
             bbL: \"\\\\mathbb{L}\",
             bbM: \"\\\\mathbb{M}\",
             bbN: \"\\\\mathbb{N}\",
             bbO: \"\\\\mathbb{P}\",
             bbP: \"\\\\mathbb{P}\",
             bbQ: \"\\\\mathbb{Q}\",
             bbR: \"\\\\mathbb{R}\",
             bbS: \"\\\\mathbb{S}\",
             bbT: \"\\\\mathbb{T}\",
             bbU: \"\\\\mathbb{U}\",
             bbV: \"\\\\mathbb{V}\",
             bbW: \"\\\\mathbb{W}\",
             bbX: \"\\\\mathbb{X}\",
             bbY: \"\\\\mathbb{Y}\",
             bbZ: \"\\\\mathbb{Z}\",
             // Others Vectors
             vtAlpha: \"\\\\boldsymbol{\\\\alpha}\",
             vtBeta: \"\\\\boldsymbol{\\\\beta}\",
             vtEpsilon: \"\\\\boldsymbol{\\\\epsilon}\",
             vtGamma: \"\\\\boldsymbol{\\\\gamma}\",
             vtRho: \"\\\\boldsymbol{\\\\rho}\",
             vtEta: \"\\\\boldsymbol{\\\\eta}\",
             vtMu: \"\\\\boldsymbol{\\\\mu}\",
             vtNu: \"\\\\boldsymbol{\\\\nu}\",
             vtSigma: \"\\\\boldsymbol{\\\\sigma}\",
             vtTau: \"\\\\boldsymbol{\\\\tau}\",
             vtTheta: \"\\\\boldsymbol{\\\\theta}\",
             vtLambda: \"\\\\boldsymbol{\\\\lambda}\",
             vtOne: \"\\\\mathbf{1}\",
             vtZero: \"\\\\boldsymbol{0}\",
             // Other matrices
             mtAlpha: \"\\\\boldsymbol{\\\\Alpha}\",
             mtBeta: \"\\\\boldsymbol{\\\\Beta}\",
             mtGamma: \"\\\\boldsymbol{\\\\Gamma}\",
             mtRho: \"\\\\boldsymbol{\\\\Rho}\",
             mtEta: \"\\\\boldsymbol{\\\\Eta}\",
             mtMu: \"\\\\boldsymbol{\\\\Mu}\",
             mtNu: \"\\\\boldsymbol{\\\\Nu}\",
             mtSigma: \"\\\\boldsymbol{\\\\Sigma}\",
             mtTau: \"\\\\boldsymbol{\\\\Tau}\",
             mtTheta: \"\\\\boldsymbol{\\\\Theta}\",
             mtLambda: \"\\\\boldsymbol{\\\\Lambda}\",
             mtPhi: \"\\\\boldsymbol{\\\\Phi}\",
             mtOne: \"\\\\mathbf{1}\",
             mtZero: \"\\\\boldsymbol{0}\"
         }
     }
 };
</script>")

;; MathJax configuration (for HTML export)
(with-eval-after-load 'ox-html
  (setq org-html-mathjax-template (concat darlan-mathjax-config-string "\n" org-html-mathjax-template))
  )

(with-eval-after-load 'ox-twbs
  (setq org-twbs-mathjax-template (concat darlan-mathjax-config-string "\n" org-twbs-mathjax-template))
  )


(with-eval-after-load 'ox-latex
  (setq org-latex-pdf-process
        ;; This requires latexmk, but it has many advantages such as running
        ;; latex the correct number of times, support calling biber when
        ;; biblatex is used, etc
        '("latexmk -shell-escape -bibtex -output-directory=%o -lualatex %f")
        )

  (add-to-list 'org-latex-logfiles-extensions "glo")
  (add-to-list 'org-latex-logfiles-extensions "bbl")
  (add-to-list 'org-latex-logfiles-extensions "acn")
  (add-to-list 'org-latex-logfiles-extensions "ist")
  )

(with-eval-after-load 'ox-latex
  (add-to-list
   'org-latex-classes
   '("sbrt"
     "\\documentclass{sbrt2017eng}
\\usepackage{hyperref}
\\usepackage[nolist]{acronym}
\\usepackage[backend=biber,doi=false,isbn=false, url=false, sorting=none, maxbibnames=3, giveninits=true, dateabbrev=true]{biblatex}
\\addbibresource{~/Dropbox/org/references/articles.bib}
\\addbibresource{~/Dropbox/org/references/articles_without_notes.bib}
\\usepackage{amssymb}
\\usepackage{amsmath}
\\usepackage{tikz}
\\usepackage{MathDefinitions}
[NO-DEFAULT-PACKAGES]  % do not include any of the default packages
[PACKAGES]             % \\usepackage statements for packages
[EXTRA]                % the stuff from #+LATEX_HEADER(_EXTRA)
     "
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; NOTE: hyperref PACKAGE IS NOT INCLUDED! Add the file variable
  ;; org-latex-hyperref-template and set it to nil
  (add-to-list
   'org-latex-classes
   '("IEEEtran"
     "\\documentclass{IEEEtran}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{capt-of}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{MathDefinitions}
\\usepackage{siunitx}
\\usepackage{tikz}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{booktabs}
\\usepackage{makecell}  % Provide the \\thead command
\\usepackage{subcaption}
\\usepackage[backend=biber,doi=false,isbn=false, url=false, sorting=none, maxbibnames=3, giveninits=true, dateabbrev=true]{biblatex}
\\usepackage[acronym, nomain, shortcuts, sanitizesort, nogroupskip, nopostdot, nonumberlist]{glossaries}
[NO-DEFAULT-PACKAGES]  % do not include any of the default packages
[PACKAGES]             % \\usepackage statements for packages
[EXTRA]                % the stuff from #+LATEX_HEADER(_EXTRA)
     "
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list
   'org-latex-classes
   '("gtelabnt"
     "\\documentclass[doutorado, brazil, english]{gtelabnt}
\\usepackage{csquotes}
\\usepackage{MathDefinitions}
\\usepackage{booktabs}
[NO-DEFAULT-PACKAGES]  % do not include any of the default packages
[PACKAGES]             % \\usepackage statements for packages
[EXTRA]                % the stuff from #+LATEX_HEADER(_EXTRA)
     "
     ("\\chapter{%s}" . "\\chapter*{%s}")
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list
   'org-latex-classes
   '("thesischapter"
     "\\documentclass{article}
\\usepackage{csquotes}
\\usepackage{MathDefinitions}
\\usepackage{booktabs}
\\usepackage{hyperref}
[NO-DEFAULT-PACKAGES]  % do not include any of the default packages
[PACKAGES]             % \\usepackage statements for packages
[EXTRA]                % the stuff from #+LATEX_HEADER(_EXTRA)
     "
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  )


(setq org-publish-project-alist
      '(("thesis"
         :base-directory "~/git_files/darlan-thesis"
         :publishing-directory "export/"
         :publishing-function org-latex-publish-to-pdf
         :section-numbers t
         :table-of-contents nil)))

;; (setq org-format-latex-header "\\documentclass{gtelabnt}
;; \\usepackage[usenames]{color}
;; \\usepackage{definitions}
;; [PACKAGES]
;; [DEFAULT-PACKAGES]
;; \\pagestyle{empty}             % do not remove
;; % The settings below are copied from fullpage.sty
;; \\setlength{\\textwidth}{\\paperwidth}
;; \\addtolength{\\textwidth}{-3cm}
;; \\setlength{\\oddsidemargin}{1.5cm}
;; \\addtolength{\\oddsidemargin}{-2.54cm}
;; \\setlength{\\evensidemargin}{\\oddsidemargin}
;; \\setlength{\\textheight}{\\paperheight}
;; \\addtolength{\\textheight}{-\\headheight}
;; \\addtolength{\\textheight}{-\\headsep}
;; \\addtolength{\\textheight}{-\\footskip}
;; \\addtolength{\\textheight}{-3cm}
;; \\setlength{\\topmargin}{1.5cm}
;; \\addtolength{\\topmargin}{-2.54cm}")
