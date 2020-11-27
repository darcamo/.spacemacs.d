
;; Org Default Backends
(with-eval-after-load 'org
  (add-to-list 'org-export-backends 'md)
  (add-to-list 'org-export-backends 'odt)

  (with-eval-after-load 'use-package-core
    (use-package ox-extra
      :config
      (ox-extras-activate '(ignore-headlines))
      )

    (use-package ox-beamer)
    )
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
  (setq org-export-with-broken-links 'mark)
  )


;; use speaker notes that work both with reveal.js and beamer
(defun darlan/replace-notes-environment (text backend info)
  "Replace '\begin{notes} content \end{notes}' in beamer export
with a \note{content}. This is useful when you are creating
presentations in org-mode with both reveal and beamer. You can
add speaker notes inside '#+begin_notes' and '#+end_notes' as in
reveal."
  (if (org-export-derived-backend-p backend 'beamer)
      (replace-regexp-in-string "\\\\end{notes}"
                                "}"
                                (replace-regexp-in-string "\\\\begin{notes}"
                                                          "\\\\note{"
                                                          text))
    text
    )
  )


(with-eval-after-load 'ox
  (add-to-list 'org-export-filter-special-block-functions 'darlan/replace-notes-environment)
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
