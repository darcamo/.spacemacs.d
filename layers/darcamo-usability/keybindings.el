(global-set-key [f2]              'delete-window)
(global-set-key [f3]              'bury-buffer) ; put the current buffer at the end of the buffer list
(global-set-key [C-f3]            'unbury-buffer) ; change the buffert at the end of the buffer list to the current buffer
(global-set-key [f4]              'kill-this-buffer) ;C-x k
(global-set-key [f11]             'browse-default-dir)
(global-set-key [S-f11]   'browse-default-dir-in-emacs)
(global-set-key [C-S-f11]   'gnome-terminal-default-dir)
(global-set-key "\C-z"            'eshell)
(global-set-key "\M-z"            'ansi-term)
(global-set-key "\C-co"    'other-frame) ; When there are multiple frames, change to another frame
(global-set-key "\C-cr"    'revert-buffer)
(global-set-key (kbd "M-Q") 'unfill-paragraph)

;; Use "pause" to set a window as dedicated
(global-set-key [pause] 'toggle-current-window-dedication)

;; Note that the default keybind can also be used, which is "C-x c i"
(global-set-key (kbd "M-i") 'helm-semantic-or-imenu)
(global-set-key (kbd "M-I") 'imenu)  ;; Use Alt+Shift+i for standard imenu





;; Expand region keybinding
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-M-=") 'er/contract-region)

(with-eval-after-load 'pdf-view
  (define-key pdf-view-mode-map "c" 'pdf-continuous-scroll-mode)
  (define-key pdf-view-mode-map "i" 'pdf-view-midnight-minor-mode)
  )

;;  ;; Highlight symbol
;; (with-eval-after-load 'highlight-symbol
;;   (define-key highlight-symbol-nav-mode-map "\M-n" 'highlight-symbol-next)
;;   (define-key auto-highlight-symbol-mode-map "\M-p" 'highlight-symbol-prev)
;;   (define-key auto-highlight-symbol-mode-map "\M-N" 'highlight-symbol-next-in-defun)
;;   (define-key auto-highlight-symbol-mode-map "\M-P" 'highlight-symbol-prev-in-defun)
;;   )
