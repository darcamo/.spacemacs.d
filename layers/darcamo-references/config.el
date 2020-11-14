
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
;; Change org-ref-ref-face to a better color for dark background
(with-eval-after-load 'org-ref
  (set-face-attribute 'org-ref-ref-face nil :foreground "gold")
  )
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; Change keybindings for org-ref-next key and org-ref-previous key
(with-eval-after-load 'org-ref
  ;; First remove C-right and C-left from org-ref-cite-keymap so that they don't
  ;; overwrite the keybinding from in the global keymap. They were originally
  ;; assigned to the org-ref-next-key and org-ref-previous-key
  (define-key org-ref-cite-keymap [C-right] nil)
  (define-key org-ref-cite-keymap [C-left] nil)

  ;; Add org-ref-next-key and org-ref-previous-key to other keybinding
  (define-key org-ref-cite-keymap (kbd "M-p") 'org-ref-previous-key)
  (define-key org-ref-cite-keymap (kbd "M-n") 'org-ref-next-key)
  )

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

