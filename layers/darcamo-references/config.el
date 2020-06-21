
;; Bibtex Set-up
(add-hook 'bibtex-mode-hook
          (lambda ()
            (darlan/set-up-outline-minor-mode "@")))


(setq bibtex-comma-after-last-field t)


;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; Set-up Org-Ref
(setq org-ref-notes-directory "~/Dropbox/org/references/notes"
      org-ref-bibliography-notes "~/Dropbox/org/references/articles.org"
      org-ref-default-bibliography '("~/Dropbox/org/references/articles.bib")
      org-ref-pdf-directory "~/Dropbox/org/references/pdfs/")


;; If you use helm-bibtex as the citation key completion method you should set these variables too.
(setq bibtex-completion-bibliography "~/Dropbox/org/references/articles.bib"
      bibtex-completion-library-path "~/Dropbox/org/references/pdfs"
      bibtex-completion-notes-path "~/Dropbox/org/references/articles.org")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (start-process "open" "*open*" "open" fpath)))
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
