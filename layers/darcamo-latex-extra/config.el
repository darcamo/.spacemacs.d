
(with-eval-after-load "tex"
  ;; Set auctex-mode for tex files.
  (add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

  ;; I often use \include or \input in my latex documents
  ;; (setq-default TeX-master nil)

  ;; Here we have the default value of TeX-view-program-selection, but we only
  ;; changed output-pdf from "Evince" to "PDF Tools"
  (setq TeX-view-program-selection
        '(
        ((output-dvi has-no-display-manager) "dvi2tty")
        ((output-dvi style-pstricks) "dvips and gv")
        (output-dvi "xdvi")
        (output-pdf "PDF Tools")
        (output-html "xdg-open")))

  ;; Make reftex also recognize \addbibresource{bib-file} as a
  ;; bibliography. This syntax is used by Biblatex instead of the usual
  ;; \bibliography{bib-file} syntax.
  (with-eval-after-load "reftex"
    ;; (add-to-list 'reftex-bibliography-commands "addbibresource")
    ;; Use "\eqref{...}" to reference equations, instead of "(\ref{...})"
    ;; (setq reftex-label-alist '(AMSTeX))
    )

  ;; Revert the PDF-buffer (when using pdf-tools to visualize generated pdf)
  ;; after the TeX compilation has finished.
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  )


;; ;; Define a face for unimportant latex commands in math
;; ;; Taken from https://endlessparentheses.com/improving-latex-equations-with-font-lock.html
;; (defface endless/unimportant-latex-face
;;   '((t :height 0.5
;;        :inherit font-lock-comment-face))
;;   "Face used on less relevant math commands.")
;; 
;; (font-lock-add-keywords
;;  'latex-mode
;;  `((,(rx (or (and "\\" (or (any ",.!;")
;;                            (and (or "left" "right"
;;                                     "big" "Big")
;;                                 symbol-end)))
;;              (any "_^")))
;;     0 'endless/unimportant-latex-face prepend))
;;  'end)



(defface darcamo/latex-math-vector-or-matrix-face
  '((t (:weight bold :inherit font-latex-math-face)))
  "Face used on vectors and matrices in latex math (\\vtX, \\mtX, etc)")

;; (defface darcamo/latex-math-blackboard-face
;;   '((t (:family "MathJax_AMS" :foreground "yellow" :background "red" :inherit font-latex-math-face)))
;;   "Face used on blackboard symbols in latex math (\\bbA, \\bbV, etc)")



;; Font para definir uma face para Sets: MathJax_AMS -> Note que ela só funciona
;; para letras maiúsculas

;; Font para caligraphic: Mathjax_Caligraphic -> Note que ela só funciona
;; para letras maiúsculas


;; This works, but it will not fontify it they \vt? and \mt? commands are
;; replaced by pretiffied versions
;; (font-lock-add-keywords 'latex-mode
;;                         '(("\\vt[A-Z]\\|\\mt[A-Z]" . 'darcamo/latex-math-vector-or-matrix-face)
;;                           ))

;; ;; Pegue de https://emacs.stackexchange.com/questions/34043/how-to-highlight-prettified-symbols/34059#34059
;;
;; This will fontify not only all \vt? and \mt? but also the prettified symbols
;; that replace them
(font-lock-add-keywords
 'latex-mode
 '(
   ("\\(\\\\vt[A-Z]\\|\\\\mt[A-Z]\\)" ;; Matcher
    ;; MATCH-HIGHLIGHT
    (0 ;; number of the subexpression of MATCHER to be highlighted
     (when (funcall prettify-symbols-compose-predicate
                      (match-beginning 0)
                      (match-end 0)
                      (match-string 0))
         'darcamo/latex-math-vector-or-matrix-face)
     ;; OVERRIDE argument of MATCH-HIGHLIGHT -> 'append' means existing
     ;; fontification is merged with the new
       append))
   )
 'append)

(font-lock-add-keywords
 'latex-mode
 '(
   ("\\(\\\\vtAlpha\\|\\\\vtBeta\\|\\\\vtTheta\\|\\\\vtEpsilon\\|\\\\vtSigma\\|\\\\vtDelta\\|\\\\vtTau\\|\\\\vtGamma\\|\\\\vtOne\\|\\\\vtZero\\)" ;; Matcher
    ;; MATCH-HIGHLIGHT
    (0 ;; number of the subexpression of MATCHER to be highlighted
     (when (funcall prettify-symbols-compose-predicate
                    (match-beginning 0)
                    (match-end 0)
                    (match-string 0))
       'darcamo/latex-math-vector-or-matrix-face)
     ;; OVERRIDE argument of MATCH-HIGHLIGHT -> 'append' means existing
     ;; fontification is merged with the new
     append))
   )
 'append)


(defun darcamo/add-vector-and-matrix-prettify-symbol-letter (s)
  "This will call 'add-to-list' function to add a pretty symbol for '\\vtS and \\mtS'"
  (interactive "P")
  (add-to-list 'prettify-symbols-alist `(,(concat "\\vt" (capitalize s)) . ,(downcase s) ) )
  (add-to-list 'prettify-symbols-alist `(,(concat "\\mt" (capitalize s)) . ,(capitalize s) ) )
  )

(defun darcamo/add-blackboard-prettify-symbol-math-field (s)
  "This will call 'add-to-list' function to add a pretty symbol for '\\bbS"
  (interactive "P")
  ;; The name of most characters double-struck version is "MATHEMATICAL
  ;; DOUBLE-STRUCK CAPITAL X", where "X" is the character. However, for some
  ;; reason the unicode name for a few of them is in the form "DOUBLE-STRUCK
  ;; CAPITAL X". The characters with this shorter name version are: C H N P Q R Z
  (if (member s '("C" "H" "N" "P" "Q" "R" "Z") )
      (add-to-list 'prettify-symbols-alist `(,(concat "\\bb" s) . ,(char-to-string (char-from-name (concat "DOUBLE-STRUCK CAPITAL " s)))))
    (add-to-list 'prettify-symbols-alist `(,(concat "\\bb" s) . ,(char-to-string (char-from-name (concat "MATHEMATICAL DOUBLE-STRUCK CAPITAL " s)))))
    ))


(defun darcamo/add-vector-and-matrix-prettify-symbol-greek (name unicode-value)
  "This will call 'add-to-list' function to add a pretty symbol for '\\vtName' with 'unicode-value'"
  (interactive "P")
  (add-to-list 'prettify-symbols-alist `(,(concat "\\vt" (capitalize name)) . ,unicode-value) )
  )

;; A list
(defvar darcamo/latin-letters-list '("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" ))


(setq LaTeX-mode-hook
      (function (lambda ()
                  (outline-minor-mode t)
                  (setq ispell-filter "tex")

                  ;; Minor-mode that highlights the symbol under
                  ;; point throughout the buffer
                  (highlight-symbol-mode)

                  ;; Set pretiffy symbols for \\vt? and \\mt? for all latin letters
                  (mapc 'darcamo/add-vector-and-matrix-prettify-symbol-letter darcamo/latin-letters-list)
                  (mapc 'darcamo/add-blackboard-prettify-symbol-math-field darcamo/latin-letters-list)

                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "alpha" "α")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "beta" "β")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "theta" "θ")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "epsilon" "ε")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "sigma" "σ")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "delta" "δ")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "tau" "τ")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "gamma" "γ")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "one" "1")
                  (darcamo/add-vector-and-matrix-prettify-symbol-greek "zero" "0")

                  (setq prettify-symbols-unprettify-at-point t)
                  (prettify-symbols-mode)
                  ))
      )



(with-eval-after-load "latex"
  ;; Extra indentation for lines beginning with an item.
  (setq LaTeX-item-indent 0)

  ;; List of regexps matching suffixes of files to be deleted.
  (setq LaTeX-clean-intermediate-suffixes (quote ("\\.aux" "\\.bbl" "\\.blg" "\\.brf" "\\.fot" "\\.glo" "\\.gls" "\\.idx" "\\.ilg" "\\.ind" "\\.lof" "\\.log" "\\.lot" "\\.out" "\\.toc" "\\.url" "\\.snm" "\\.nav" "\\.fdb_latexmk" "\\.run\\.xml" "\\.fls" "\\.bcf")))

  ;; Add the .synctex.gz file to the list of files to be cleared by the
  ;; "Clear All" command
  (add-to-list 'LaTeX-clean-output-suffixes "\\.synctex\\.gz")

  ;; ;; Used for fold-mode in latex
  ;; (setq TeX-fold-macro-spec-list (quote (("[f]" ("footnote")) ("[c]" ("cite")) ("[l]" ("label")) ("[r]" ("ref" "pageref")) ("[i]" ("index")) ("*" ("item")) ("..." ("dots")) (1 ("part" "chapter" "section" "subsection" "subsubsection" "paragraph" "subparagraph" "part*" "chapter*" "section*" "subsection*" "subsubsection*" "paragraph*" "subparagraph*" "emph" "textit" "textsl" "textmd" "textrm" "textsf" "texttt" "textbf" "textsc" "textup" "ac" "acf" "acs" "acp" "acsp" "acfp" "acused")) (2 ("textcolor")))))

  ;; (setq font-latex-user-keyword-classes (quote (("textcolor{red}" ("textcolor{red}") (:foreground "red") (command 1)) ("textcolor{blue}" ("textcolor{blue}") (:foreground "blue") (command 1)) ("acronym" ("ac" "acf" "acs" "acl" "acp" "acsp" "aclp" "acfp" "acused") (:foreground "blue") (command 1)) ("acronym2" ("acro") nil (command 2)))))

  ;; ;; Set this to nil and Auctex won't fontify subscript and superscript
  ;; ;; strings. I prefer nil because I don't like to change the width of the
  ;; ;; fonts
  ;; (setq font-latex-fontify-script nil)

  )





;; Abbrev table
;; (add-hook 'LaTeX-mode-hook (lambda ()
;;                              (setq abbrev-mode t)
;;                              (flycheck-mode t)
;;                              (setq local-abbrev-table TeX-mode-abbrev-table)))


(add-hook 'LaTeX-mode-hook (lambda ()
                             (indent-guide-mode t)))


;; Use Latexmk with Auctex
(add-hook 'LaTeX-mode-hook (lambda ()
                             (push
                              '("Latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
                                :help "Run Latexmk on file")
                              TeX-command-list)))



;; Veja o que tem de interessante
;; https://tecosaur.github.io/emacs-config/config.html#editor-visuals



;; Veja o uso do CDLatex
