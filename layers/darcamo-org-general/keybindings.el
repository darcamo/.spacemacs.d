;; (global-set-key "\C-xB" 'org-ido-switchb)

;; Note that the default keybind can also be used, which is "C-x c i"
(global-set-key (kbd "M-i") 'helm-semantic-or-imenu)
(global-set-key (kbd "M-I") 'imenu)  ;; Use Alt+Shift+i for standard imenu


;; Local Keybinding
(add-hook
 'org-mode-hook
 (lambda ()
   (define-key org-mode-map [C-M-return] 'org-meta-return)
   (define-key org-mode-map [f8] 'org-toggle-link-display)
   (define-key org-mode-map [S-f8] 'org-toggle-inline-images)

   ;; This will open a PDF file with the same name of the org-mode file
   ;; Useful when you are exporting the org-mode buffer to PDF
   (define-key org-mode-map [f10] #'(lambda () (interactive) (find-file (concat (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".pdf"))))
   (define-key org-mode-map [S-f10] #'(lambda () (interactive) (find-file (concat (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".html"))))
   (define-key org-mode-map [S-f10] #'(lambda () (interactive) (ver-pdf-no-evince (concat (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".pdf"))))
   (define-key org-mode-map [C-f10] #'(lambda () (interactive) (browse-url (concat (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".html"))))
   ;; (define-key org-mode-map "\C-xye" 'yas/expand)
   ;; (define-key org-mode-map "\C-xyn" 'yas/next-field)
   ;; (define-key org-mode-map [tab] 'yas/expand)
   ;; In org  "|" is used for tables. Let's change boxquote-side
   ;; then to "!"
   ;;(setq boxquote-side "! ")

   ;; xxxxx Enable Drag-stuff when not in an org-mode heading xxxxxxxxxxxxxxxxxx
   ;; If cursor is in a headline or in a list item, use default org-mode
   ;; function, otherwise use drag-stuff function
   (define-key org-mode-map (kbd "<M-up>")
     (lambda ()
       (interactive)
       (call-interactively
        (if (or (org-at-heading-p) (org-at-item-p) )
            'org-metaup
          'drag-stuff-up))))

   ;; If cursor is in a headline or in a list item, use default org-mode
   ;; function, otherwise use drag-stuff function
   (define-key org-mode-map (kbd "<M-down>")
     (lambda ()
       (interactive)
       (call-interactively
        (if (or (org-at-heading-p) (org-at-item-p) )
            'org-metadown
          'drag-stuff-down))))

   ;; If cursor is in a headline or in a list item, use default org-mode
   ;; function, otherwise use drag-stuff function
   (define-key org-mode-map (kbd "<M-right>")
     (lambda ()
       (interactive)
       (call-interactively
        (if (or (org-at-heading-p) (org-at-item-p) )
            'org-metaright
          'drag-stuff-right))))

   ;; If cursor is in a headline or in a list item, use default org-mode
   ;; function, otherwise use drag-stuff function
   (define-key org-mode-map (kbd "<M-left>")
     (lambda ()
       (interactive)
       (call-interactively
        (if (or (org-at-heading-p) (org-at-item-p) )
            'org-metaleft
          'drag-stuff-left))))
   )
 ;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 )




