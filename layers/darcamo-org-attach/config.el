;; The "attach" link type that I defined in my main gtd file uses the
;; org-attach-expand function.
(autoload 'org-attach-expand "org-attach.el")
(autoload 'org-attach-expand-link "org-attach.el")

;; Define an "attach:" link abbreviation
(with-eval-after-load 'org
  (add-to-list 'org-link-abbrev-alist '("attach" . org-attach-expand-link))
  )

(with-eval-after-load 'org-attach
  ;; Only defined after org-attach is loaded
  (setq org-attach-store-link-p 'attached)

  (setq org-confirm-elisp-link-not-regexp
        (regexp-opt '("org-open-file" "browse-dir-sftp" "browse-dir")))
  )
