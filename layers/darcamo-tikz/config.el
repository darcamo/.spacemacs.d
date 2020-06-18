;; Better paragraph fill for tikz
(with-eval-after-load "latex"
  ;; Add tikzpicture and scope to the list of environments with special
  ;; indentation.
  (add-to-list 'LaTeX-indent-environment-list '("tikzpicture"))
  (add-to-list 'LaTeX-indent-environment-list '("scope"))
  )



;; Define a tikz-mode derived from latex mode
(define-derived-mode tikz-mode
  LaTeX-mode "Tikz-Mode" "A derived mode from LaTeX-mode that add some keywords related to tikz to font-lock. It is useful when the latex document is a single tikz picture using the standalone package."
  (setq case-fold-search nil))



;; Add some tikz commands as font-lock keywords
(font-lock-add-keywords 'tikz-mode
                        '(("\\(\\\\\\(tikz\\|tikzset\\|pgfdeclarelayer\\|pgfsetlayers\\)\\){" 1 font-lock-warning-face t)))

;; Add \draw, \path and \node and \matrix as keywords.
(font-lock-add-keywords 'tikz-mode
                        '(("\\(\\\\\\(draw\\|path\\|node\\|matrix\\|coordinate\\)\\)" 1 font-lock-warning-face t)))



;; Tell Emacs to open files with the extension .tikz or .pgf  in tikz-mode
(add-to-list 'auto-mode-alist '("\.tikz$" . tikz-mode))
(add-to-list 'auto-mode-alist '("\.pgf$" . tikz-mode))



;; Add .tikz and .pgf to file extensions known by Auctex
;; Without this, Auctex won't compile files with extensions ".tikz" or ".pgf"
;; even if they are valid latex files.
;; The TeX-file-extensions variable is defined only after latex.el (from
;; auctex) has been loaded.
(with-eval-after-load "latex"
  (add-to-list 'TeX-file-extensions "tikz")
  (add-to-list 'TeX-file-extensions "pgf")
  )



;; ;; Skeletons for Tikz
;; (define-skeleton tikz-latex-skeleton
;;   "Insert a Latex tikz skeleton into current buffer.
;; This only makes sense for empty buffers."
;;   nil
;;   "\\documentclass{standalone}

;; \\usepackage[utf8]{inputenc} % Use this if the file is encoded with utf-8
;; \\usepackage{lmodern}  % Very good to use with the fontenc package to generate good PDFs
;; \\usepackage[T1]{fontenc}  % Important. See http://tex.stackexchange.com/questions/664/why-should-i-use-usepackaget1fontenc
;; \\usepackage{amsmath,amssymb} % Part of AMS-LaTeX
;; % One of the good things of the amsmath package is the math enviroments matrix, pmatrix, bmatrix, Bmatrix, vmatrix and Vmatrix
;; \\usepackage{tikz}
;; \\usetikzlibrary{positioning}
;; \\usetikzlibrary{shadows}
;; \\usetikzlibrary{backgrounds}
;; \\usetikzlibrary{shapes}
;; \\usetikzlibrary{shapes.multipart}
;; \\usetikzlibrary{matrix}
;; \\usetikzlibrary{intersections}
;; \\usetikzlibrary{fit}
;; \\usetikzlibrary{calc}
;; %\\usetikzlibrary{decorations.pathmorphing}
;; \\usetikzlibrary{decorations.pathreplacing}

;; % My custom package with my math definitions
;; % Located at /home/darlan/Dropbox/Arquivos de Instalação/Latex_Packages/MathDefinitions.sty
;; \\usepackage{MathDefinitions}

;; \\begin{document}

;; \\begin{tikzpicture}[framed]
;;   \\draw (0,0) -- (1,1);
;; \\end{tikzpicture}

;; \\end{document} "> \n \n
;; "%%% Local Variables:
;; %%% mode: tikz
;; %%% TeX-PDF-mode: t
;; %%% TeX-master: t
;; %%% End: "> \n \n

;; (TeX-PDF-mode t))
