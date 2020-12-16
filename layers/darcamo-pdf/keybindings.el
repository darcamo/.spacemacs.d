(with-eval-after-load 'pdf-view
  ;; Set "g" as keybinding to "pdf-view-goto-page" when viewing pdfs
  (define-key pdf-view-mode-map "g" 'pdf-view-goto-page)
  (define-key pdf-view-mode-map (kbd "<C-mouse-4>") 'pdf-view-enlarge)
  (define-key pdf-view-mode-map (kbd "<C-mouse-5>") 'pdf-view-shrink)
  (define-key pdf-view-mode-map (kbd "<S-mouse-4>") '(lambda () (interactive) (image-backward-hscroll 4)))
  (define-key pdf-view-mode-map (kbd "<S-mouse-5>") '(lambda () (interactive) (image-forward-hscroll 4)))
  )
