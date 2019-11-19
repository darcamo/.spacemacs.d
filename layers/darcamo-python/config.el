(add-hook 'python-mode-hook (lambda ()
                              ;; (set (make-local-variable 'outline-regexp) local-outline-regexp)
                              (setq outline-regexp "# %%")
                              (outline-minor-mode)
                              ))

