
(with-eval-after-load 'latex
  (define-key LaTeX-mode-map [f5] 'latex-skeleton-acronym)
  (define-key LaTeX-mode-map [C-f5] 'latex-skeleton-math-left-right-symbol)
  (define-key LaTeX-mode-map (kbd "<C-S-f5>") 'my-latex-textcolor-red)
  (define-key LaTeX-mode-map [f9] 'tex-all)
  ;; Define C-f9 to the compile command. This is useful when you
  ;; work with latex and Makefiles
  (define-key LaTeX-mode-map [C-f9] 'compile)
  (define-key LaTeX-mode-map [f10] 'TeX-view)
  ;; (define-key LaTeX-mode-map "\C-\M-n" 'outline-next-visible-heading)
  ;; (define-key LaTeX-mode-map "\C-\M-p" 'outline-previous-visible-heading)
  (define-key LaTeX-mode-map (kbd "<S-M-return>") 'dar/LaTeX-insert-item-inverse-behavior)

  ;; Enable key bindings (M-p and M-p) for navigation
  ;; (highlight-symbol-nav-mode)
  )

(with-eval-after-load 'pdf-view
    (define-key pdf-view-mode-map [f9] 'tex-all)  ; We also want to compile when
                                        ; we are view the pdf
  )
