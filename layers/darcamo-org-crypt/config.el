(autoload 'org-decrypt-entry "org-crypt.el" "Decrypt the content of the current headline." t)
(autoload 'org-decrypt-entries "org-crypt.el" "Decrypt all entries in the current buffer." t)
(autoload 'org-encrypt-entry "org-crypt.el" "Encrypt the content of the current headline." t)
(autoload 'org-encrypt-entries "org-crypt.el" "Encrypt all top-level entries in the current buffer." t)

(with-eval-after-load "org-crypt"
  ;; Automatically encrypts everything that has the tag "crypt"
  ;; when you save the file
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance (quote ("crypt" "Projeto")))
  ;; darcamo@gmail.com (see in the seahorse program)
  (setq org-crypt-key "15798E79")

  ;; Possible values:
  ;; t        : Disable auto-save-mode for the current buffer
  ;;            prior to decrypting an entry.
  ;; nil      : Leave auto-save-mode enabled.
  ;;            This may cause data to be written to disk unencrypted!
  ;; 'ask     : Ask user whether or not to disable auto-save-mode
  ;;            for the current buffer.
  ;; 'encrypt : Leave auto-save-mode enabled for the current buffer,
  ;;            but automatically re-encrypt all decrypted entries
  ;;            *before* auto-saving.
  ;;            NOTE: This only works for entries which have a tag
  ;;            that matches `org-crypt-tag-matcher'.
  (setq org-crypt-disable-auto-save t)
  )
