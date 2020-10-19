
;; Bibtex Set-up
(add-hook 'bibtex-mode-hook
          (lambda ()
            (darlan/set-up-outline-minor-mode "@")))

(with-eval-after-load 'bibtex
  (bibtex-set-dialect 'biblatex))

(setq bibtex-comma-after-last-field t)


;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; Set-up Org-Ref
(setq org-ref-notes-directory "~/Dropbox/org/references/notes"
      org-ref-bibliography-notes "~/Dropbox/org/references/articles.org"
      org-ref-default-bibliography '("~/Dropbox/org/references/articles.bib" "~/Dropbox/org/references/articles_without_notes.bib")
      org-ref-pdf-directory "~/Dropbox/org/references/pdfs/")


;; If you use helm-bibtex as the citation key completion method you should set these variables too.
(setq bibtex-completion-bibliography "~/Dropbox/org/references/articles.bib"
      bibtex-completion-library-path "~/Dropbox/org/references/pdfs"
      bibtex-completion-notes-path "~/Dropbox/org/references/articles.org")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (call-process "evince" nil 0 nil fpath)))
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; Search inside PDF files (using pdfgrep) from org-ref
;;
;; Note that you can already do this with helm-find-files (use =M-a= to mark files and then 
(with-eval-after-load 'org-ref
  (defun org-ref-grep-pdf (&optional _candidate)
    "Search pdf files of marked CANDIDATEs."
    (interactive)
    (let ((keys (helm-marked-candidates))
          (get-pdf-function org-ref-get-pdf-filename-function))
      (helm-do-pdfgrep-1
       (-remove (lambda (pdf)
		          (string= pdf ""))
	            (mapcar (lambda (key)
		                  (funcall get-pdf-function key))
		                keys)))))

  (helm-add-action-to-source "Grep PDF" 'org-ref-grep-pdf helm-source-bibtex 4)

  (setq helm-bibtex-map
        (let ((map (make-sparse-keymap)))
          (set-keymap-parent map helm-map)
          (define-key map (kbd "C-s") (lambda () (interactive)
				                        (helm-run-after-exit 'org-ref-grep-pdf)))
          map))

  (push `(keymap . ,helm-bibtex-map) helm-source-bibtex)
  )
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

