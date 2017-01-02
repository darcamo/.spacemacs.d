
;; xxxxxxxxxx Miscellaneous xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; ;; Asks for confirmation when leaving Emacs
;; ;;(setq confirm-kill-emacs 'yes-or-no-p)

;; Deleta região selecionada quando tecla DEL ou digita algum texto
(delete-selection-mode 1)

;; ;; Treat 'y' or <CR> as yes, 'n' as no.
;; (fset 'yes-or-no-p 'y-or-n-p)

;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



;; xxxxxxxxxx Abbrevs xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(add-to-list 'auto-mode-alist '("\\.abbrev_defs\\'" . emacs-lisp-mode))
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



;; ;; xxxxx Save backup files (files endind with ~) to specific directory xxxxxxxxx
;; (setq backup-directory-alist
;;       `(("." . ,(expand-file-name
;;                  (concat user-emacs-directory "backups")))))
;; ;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx






;; xxxxxxxxxx Pretty Page Break xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; Spacemacs already has this activated
;; TIPS:
;; - Use "C-q C-l" to add a page break
;; - Use "C-x C-p" to select the current page
;; - Use "C-x [" or "C-x ]" to move from pages
;; (add-to-list 'page-break-lines-modes 'c++-mode)
;; (add-to-list 'page-break-lines-modes 'python-mode)
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
