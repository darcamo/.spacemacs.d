(global-set-key [f7] 'ispell)
(global-set-key [S-f7] 'ispell-region)
(global-set-key [C-f7] 'darcamo/toggle-ispell-dictionary)
(global-set-key [f12] 'ispell-word)

;; Use Ctrl + f12 to lookup the definition of the word at point in the
;; Cambridge dictionary and Ctrl + Shift + f12 to lookup for synonyms in
;; www.thesaurus.com
(global-set-key [C-f12]   'lookup-word-definition)
(global-set-key [C-S-f12] 'lookup-synonym)
;; (global-set-key [M-f12] 'thesaurus-choose-synonym-and-replace)
(global-set-key [M-f12] 'synosaurus-choose-and-replace)


;; In any programming mode, change the F7 keybinding to be a programming
;; specific function that only spellchecks comments and strings
(define-key prog-mode-map [f7] 'ispell-comments-and-strings)
