(add-hook 'bibtex-mode-hook
          (lambda ()
            (darlan/set-up-outline-minor-mode "@")))
