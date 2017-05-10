
(with-eval-after-load "tex"
  ;; Set auctex-mode for tex files.
  (add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

  ;; (setq TeX-auto-save t)
  ;; (setq TeX-parse-self t)

  ;; I often use \include or \input in my latex documents
  (setq-default TeX-master nil)

  ;; (setq reftex-plug-into-AUCTeX t)

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
                  ;; Add my local auctex style file folder to the path
                  ;; (add-auctex-folder-to-path)

                  ;; (load-library "beamer") ; If beamer is not found, add the
                  ;;                         ; auctex styles folder to the
                  ;;                         ; load path (TeX-add-style-hook
                  ;;                         ; "beamer" 'my-beamer-mode)
                  (turn-on-reftex)
                  (local-set-key [f5] 'latex-skeleton-acronym)
                  (local-set-key [C-f5] 'latex-skeleton-math-left-right-symbol)
                  (local-set-key (kbd "<C-S-f5>") 'my-latex-textcolor-red)
                  (local-set-key [f6] 'my-save-and-compile)
                  (local-set-key [f9] 'tex-all)
                  ;; Define C-f9 to the compile command. This is useful when you
                  ;; work with latex and Makefiles
                  (local-set-key [C-f9] 'compile)
                  (local-set-key [f10] 'TeX-view)
                  ;; (local-set-key "\C-\M-n" 'outline-next-visible-heading)
                  ;; (local-set-key "\C-\M-p" 'outline-previous-visible-heading)
                  (local-set-key (kbd "<S-M-return>") 'dar/LaTeX-insert-item-inverse-behavior)
                  (darlan/set-outline-key-bindings)
                  (outline-minor-mode t)
                  (setq ispell-filter "tex")

                  ;; Minor-mode that highlights the symbol under
                  ;; point throughout the buffer
                  (highlight-symbol-mode)
                  (darlan/set-highlight-symbol-key-bindings)

                  ;; ;; Activates my beamer minor mode if the file name is "presentation.tex"
                  ;; (if (string-equal (file-name-nondirectory buffer-file-name) "presentation.tex")
                  ;;     (beamer-mode))
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

  ;; (setq TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && ps2pdf %f && evince %s.pdf") ("^dvi$" ("^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^\\(?:a5\\(?:comb\\|paper\\)\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^\\(?:a5\\(?:comb\\|paper\\)\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "evince %s.pdf") ("^html?$" "." "netscape %o"))))


  ;; (setq font-latex-user-keyword-classes (quote (("textcolor{red}" ("textcolor{red}") (:foreground "red") (command 1)) ("textcolor{blue}" ("textcolor{blue}") (:foreground "blue") (command 1)) ("acronym" ("ac" "acf" "acs" "acl" "acp" "acsp" "aclp" "acfp" "acused") (:foreground "blue") (command 1)) ("acronym2" ("acro") nil (command 2)))))

  ;; ;; Set this to nil and Auctex won't fontify subscript and superscript
  ;; ;; strings. I prefer nil because I don't like to change the width of the
  ;; ;; fonts
  ;; (setq font-latex-fontify-script nil)

  ;; ;; I want to use pdflatex by default
  ;; (set-default 'TeX-PDF-mode t)

  ;; (set-default 'TeX-source-correlate-mode t)

  ;; (set-default 'TeX-fold-mode t)
  )





;; Abbrev table
(define-abbrev-table 'TeX-mode-abbrev-table nil)
(add-hook 'LaTeX-mode-hook (lambda ()
                             (setq abbrev-mode t)
                             (setq local-abbrev-table TeX-mode-abbrev-table)))


(add-hook 'LaTeX-mode-hook (lambda ()
                             (indent-guide-mode t)))


;; Use Latexmk with Auctex
(add-hook 'LaTeX-mode-hook (lambda ()
                             (push
                              '("Latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
                                :help "Run Latexmk on file")
                              TeX-command-list)))
