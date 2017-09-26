(global-set-key "\C-xB" 'org-ido-switchb)

;; Note that the default keybind can also be used, which is "C-x c i"
(global-set-key (kbd "M-i") 'helm-semantic-or-imenu)
(global-set-key (kbd "M-I") 'imenu)  ;; Use Alt+Shift+i for standard imenu


;; Local Keybinding
(add-hook
 'org-mode-hook
 (lambda ()
   (local-set-key [f6] 'darlan/org-surround-inline-math)
   (local-set-key [C-f6] 'org-insert-example-block)
   (local-set-key [f5] 'org-toggle-latex-fragment)
   (local-set-key [C-M-return] 'org-meta-return)

   ;; (local-set-key "\C-xye" 'yas/expand)
   ;; (local-set-key "\C-xyn" 'yas/next-field)
   ;; (local-set-key [tab] 'yas/expand)
   ;; In org  "|" is used for tables. Let's change boxquote-side
   ;; then to "!"
   ;;(setq boxquote-side "! ")
   )
 )
