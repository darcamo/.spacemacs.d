(set-default 'tab-width 4)

(add-hook
 'prog-mode-hook
 (lambda ()
   (add-to-list 'prettify-symbols-alist '("<=" . "≤"))
   (add-to-list 'prettify-symbols-alist '(">=" . "≥"))
   (setq prettify-symbols-unprettify-at-point t)
   (prettify-symbols-mode)
   )
 )
