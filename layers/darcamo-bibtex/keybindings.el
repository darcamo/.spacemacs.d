(add-hook 'bibtex-mode-hook
          (lambda () (local-set-key [f10] 'org-ref-open-bibtex-pdf))
          )
