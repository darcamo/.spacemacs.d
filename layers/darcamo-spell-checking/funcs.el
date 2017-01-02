;; lookup-word-definition
;; Dicionário do babylon
;; http://online.babylon.com/cgi-bin/trans.cgi?layout=uol.txt&lang=ptg&word=WORD
;; MUDE A FUNÇÃO PARA QUE SE FORNECER UM ARGUMENTO ELE USE O DICIONÁRIO DO BABYLON

;; The functions lookup-word-definition and lookup-wikipedia were copied from
;; http://xahlee.org/emacs/emacs_lookup_ref.html
(defun lookup-word-definition ()
  "Look up the current word's definition in a browser.
                If a region is active (a phrase), lookup that phrase."
  (interactive)
  ;; I want to use w3m as the browser to look-up definition but not set it to default browser
  (let (myword myurl (browse-url-browser-function 'w3m-browse-url))
    (setq myword
          (if (and transient-mark-mode mark-active)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))

    (setq myword (replace-regexp-in-string " " "%20" myword))
    ;; (setq myurl (concat "http://dictionary.cambridge.org/results.asp?searchword=" myword))
    (setq myurl (concat "http://online.babylon.com/cgi-bin/trans.cgi?layout=uol.txt&lang=ptg&word=" myword))
    (browse-url myurl)
    ;; (w3m-browse-url myurl) ;; if you have w3m and w3 installed
    ;; (shell-command (concat "open -a opera " myurl))
    ;; use diff browser in OSX

    ;; alternative ref site url
    ;; http://en.wiktionary.org/wiki/
    ;; http://dictionary.reference.com/browse/
    ))



;; Synonyms (Lookup in a browser)
(defun lookup-synonym ()
  "Look up the current word's synonyms in a browser.
        If a region is active (a phrase), lookup that phrase."
  (interactive)
  (let (myword myurl)
    (setq myword
          (if (and transient-mark-mode mark-active)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))

    (setq myword (replace-regexp-in-string " " "_" myword))
    (setq myurl (concat "http://thesaurus.reference.com/browse/" myword))
    (browse-url myurl)
    ))
