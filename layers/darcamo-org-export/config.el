
;; Org Default Backends
(with-eval-after-load 'org
  (add-to-list 'org-export-backends 'md)
  (add-to-list 'org-export-backends 'odt)
  )


;; MathJax configuration (for HTML export)
(with-eval-after-load 'ox-html
  (setq org-html-mathjax-options
        '((path "file:///home/darlan/Dropbox/MathJax-master/MathJax.js?config=default")
          (scale "100")
          (align "center")
          (indent "2em")
          (mathml nil)))
  )


(with-eval-after-load 'ox-latex
  (setq org-latex-pdf-process
        ;; This requires latexmk, but it has many advantages such as running
        ;; latex the correct number of times, support calling biber when
        ;; biblatex is used, etc
         '("latexmk -shell-escape -bibtex -pdf %f"))
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
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
