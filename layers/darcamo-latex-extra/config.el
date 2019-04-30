
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


(setq LaTeX-mode-hook
      (function (lambda ()
                  (outline-minor-mode t)
                  (setq ispell-filter "tex")

                  ;; Minor-mode that highlights the symbol under
                  ;; point throughout the buffer
                  (highlight-symbol-mode)

                  ;; Activates my beamer minor mode if the file name is "presentation.tex"
                  (if (string-equal (file-name-nondirectory buffer-file-name) "presentation.tex")
                      (beamer-mode))
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
(define-abbrev-table 'TeX-mode-abbrev-table nil)
(add-hook 'LaTeX-mode-hook (lambda ()
                             (setq abbrev-mode t)
                             (flycheck-mode t)
                             (setq local-abbrev-table TeX-mode-abbrev-table)))


(add-hook 'LaTeX-mode-hook (lambda ()
                             (indent-guide-mode t)))


;; Use Latexmk with Auctex
(add-hook 'LaTeX-mode-hook (lambda ()
                             (push
                              '("Latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
                                :help "Run Latexmk on file")
                              TeX-command-list)))
