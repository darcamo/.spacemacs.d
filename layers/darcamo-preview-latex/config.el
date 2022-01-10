;; Muda a escala das fórmulas de latex geradas para o preview-latex e para o exporte para html
(setq org-format-latex-options (quote (:foreground default :background default :scale 1.7 :html-foreground "Black" :html-background "Transparent" :html-scale 1.7 :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))))

;; Change the default latex packages
;; (setq org-latex-default-packages-alist
;;       '(("AUTO" "inputenc" t)
;;         ("T1" "fontenc" t)
;;         ;; ("" "fixltx2e" nil)  ;; This package is not necessary anymore
;;         ("" "graphicx" t)
;;         ("" "longtable" nil)
;;         ("" "float" nil)
;;         ("" "wrapfig" nil)
;;         ("" "soul" t)
;;         ("" "textcomp" t)
;;         ("" "marvosym" t)
;;         ;; ("" "wasysym" t) ;; Removed, since it conflicts with something in
;;         ;;                  ;; my MathDefinitions package.
;;         ("" "MathDefinitions" t)  ;; My custom latex package. Latex must be
;;         ;; able to find this package.
;;         ("" "latexsym" t)
;;         ("" "amssymb" t)
;;         ("" "hyperref" nil)
;;         ("" "tikz" nil)  ;; If tikz is enabled in latex fragments the
;;         ;; equations will be rendered in black even when
;;         ;; the Emacs background is dark
;;         "\\tolerance=1000"))


;; Add MathDefinitions and tikz packages to the list of default latex packages
(with-eval-after-load 'org
  (add-to-list 'org-latex-default-packages-alist '("" "MathDefinitions" t) t)
  (add-to-list 'org-latex-default-packages-alist '("" "tikz" nil) t)
  )

;; Faz com que o commando \vec seja conhecido para o preview latex
(setq org-preview-latex-image-directory "~/tmp/ltxpng/")
