;; find aspell and hunspell automatically
(cond
 ;; try hunspell at first
 ;; if hunspell does NOT exist, use aspell
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "english")  ;; en_US
  (setq ispell-local-dictionary-alist
        ;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
        ;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
        '(
          ("english" "[[:alpha:]]" "[^[:alpha:]]" "[']" t ("-d" "en_US") nil utf-8)
          ("brasileiro" "[[:alpha:]]" "[^[:alpha:]]" "[']" t ("-d" "pt_BR") nil utf-8)
          )))


 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  ;; (set-default 'ispell-local-dictionary "english")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))))



;; Spell checking in org-mode files
;; Make spell checking ignore PROPERTIES and LOGBOOK drawers
(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
;; Make spell checking ignore SRC blocks
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))



