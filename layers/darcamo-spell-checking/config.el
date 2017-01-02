
;; Default Dictionary
;; English as default for spell checking
(set-default 'ispell-local-dictionary "english")



;; Spell checking in org-mode files
;; Make spell checking ignore PROPERTIES and LOGBOOK drawers
(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
;; Make spell checking ignore SRC blocks
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))



