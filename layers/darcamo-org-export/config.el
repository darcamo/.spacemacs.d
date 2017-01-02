
;; Org Default Backends
(add-to-list 'org-export-backends 'md)
(add-to-list 'org-export-backends 'odt)


;; MathJax configuration (for HTML export)
(setq org-html-mathjax-options
      '((path "file:///home/darlan/Dropbox/MathJax-master/MathJax.js?config=default")
        (scale "100")
        (align "center")
        (indent "2em")
        (mathml nil)))
