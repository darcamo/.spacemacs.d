;; Muda a escala das fórmulas de latex geradas para o preview-latex e para o exporte para html
(setq org-format-latex-options (quote (:foreground default :background default :scale 1.7 :html-foreground "Black" :html-background "Transparent" :html-scale 1.7 :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))))

;; convert LaTeX fragments to images when exporting to HTML
(setq org-export-with-LaTeX-fragments nil)

;; Change the default latex packages
(setq org-latex-default-packages-alist
      '(("AUTO" "inputenc" t)
        ("T1" "fontenc" t)
        ("" "fixltx2e" nil)
        ("" "graphicx" t)
        ("" "longtable" nil)
        ("" "float" nil)
        ("" "wrapfig" nil)
        ("" "soul" t)
        ("" "textcomp" t)
        ("" "marvosym" t)
        ;; ("" "wasysym" t) ;; Removed, since it conflicts with something in
        ;;                  ;; my MathDefinitions package.
        ("" "MathDefinitions" t)  ;; My custom latex package. Latex must be
        ;; able to find this package.
        ("" "latexsym" t)
        ("" "amssymb" t)
        ("" "hyperref" nil)
        ("" "tikz" nil)  ;; If tikz is enabled in latex fragments the
        ;; equations will be rendered in black even when
        ;; the Emacs background is dark
        "\\tolerance=1000"))

;; Faz com que o commando \vec seja conhecido para o preview latex
;; (setq org-format-latex-header (concat org-format-latex-header "\n\\renewcommand{\\vec}[1]{\\mathbf{#1}}"))
;; ;; Faz com que o commando \mat seja conhecido para o preview latex
;; (setq org-format-latex-header (concat org-format-latex-header "\n\\newcommand{\\mat}[1]{\\mathbf{#1}}"))
;; ;; Faz com que o commando \set seja conhecido para o preview latex
;; (setq org-format-latex-header (concat org-format-latex-header "\n\\newcommand{\\Set}[1]{\\mathbb{#1}}"))
(setq org-latex-preview-ltxpng-directory "~/tmp/ltxpng/")
