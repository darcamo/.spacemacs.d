
(defun darlan/set-highlight-symbol-key-bindings ()
  "Set the key-bindings for the highlight-symbol minor mode."
  (interactive)
  (local-set-key "\M-n" 'highlight-symbol-next)
  (local-set-key "\M-p" 'highlight-symbol-prev)
  (local-set-key "\M-N" 'highlight-symbol-next-in-defun)
  (local-set-key "\M-P" 'highlight-symbol-prev-in-defun)
  )



;; xxxxxxxxxx Muda o comportamento de C-w e M-w xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position
                                      2))
     )))

;; spacemacs has a different keybinding for C-w, but there is a command to kill
;; the whole line with C-S-<backspace>
;;
;; (defadvice kill-region (before slick-cut activate compile)
;;   "When called interactively with no active region, kill a single line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
