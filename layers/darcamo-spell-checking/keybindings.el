(global-set-key [f7] 'ispell)
(global-set-key [f12] 'ispell-word)

;; Use Ctrl + f12 to lookup the definition of the word at point in the
;; Cambridge dictionary and Ctrl + Shift + f12 to lookup for synonyms in
;; www.thesaurus.com
(global-set-key [C-f12]   'lookup-word-definition)
(global-set-key [C-S-f12] 'lookup-synonym)
(global-set-key [M-f12] 'thesaurus-choose-synonym-and-replace)
