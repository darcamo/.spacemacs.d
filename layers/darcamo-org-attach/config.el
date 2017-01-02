;; The "attach" link type that I defined in my main gtd file uses the
;; org-attach-expand function.
(autoload 'org-attach-expand "org-attach.el")

;; Only defined after org-attach is loaded
(setq org-attach-store-link-p 'attached)

(setq org-confirm-elisp-link-not-regexp
      (regexp-opt '("org-open-file" "browse-dir-sftp" "browse-dir")))
