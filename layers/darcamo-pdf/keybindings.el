(with-eval-after-load 'pdf-view
  (define-key pdf-view-mode-map "c" 'pdf-continuous-scroll-mode)
  (define-key pdf-view-mode-map "i" 'pdf-view-midnight-minor-mode)
  (define-key pdf-view-mode-map [f9] 'tex-all)  ; We want to compile when viewing the PDF
  (define-key pdf-view-mode-map [f10] '(lambda () (interactive) (ver-pdf-no-evince (concat (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".pdf"))))
  (define-key pdf-view-mode-map [S-f10] '(lambda () (interactive) (eaf-open (concat (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".pdf"))))

  ;; Set "g" as keybinding to "pdf-view-goto-page" when viewing pdfs
  (define-key pdf-view-mode-map "g" 'pdf-view-goto-page)
  (define-key pdf-view-mode-map (kbd "<C-mouse-4>") 'pdf-view-enlarge)
  (define-key pdf-view-mode-map (kbd "<C-mouse-5>") 'pdf-view-shrink)
  (define-key pdf-view-mode-map (kbd "<S-mouse-4>") '(lambda () (interactive) (image-backward-hscroll 4)))
  (define-key pdf-view-mode-map (kbd "<S-mouse-5>") '(lambda () (interactive) (image-forward-hscroll 4)))
  )
