(define-skeleton darlan/org-auto-insert-skeleton
  "Insert a template skeleton for a new Org-mode file into current buffer.
                    This only makes sense for empty buffers."
  nil
  "#+TITLE:"
  (darlan/change-to-space (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))) \n
  "#+AUTHOR:Darlan Cavalcante Moreira
      ,#+EMAIL:darcamo@gmail.com
      ,#+SETUPFILE: ~/.emacs.d/lisp/org-setup-file-template/setup.org

      ,* Some Header

      " \n)

(define-auto-insert "\\.org" 'darlan/org-auto-insert-skeleton)
