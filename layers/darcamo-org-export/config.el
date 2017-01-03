
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
