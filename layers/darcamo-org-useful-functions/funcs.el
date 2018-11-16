;; Quick Access to projects
(defun my-find-org-heading (projectName)
  (let (heading org-indirect-buffer-display)
    (setq heading (concat "* " projectName))
    (setq org-indirect-buffer-display 'current-window)
    (if (buffer-exists projectName)
        (switch-to-buffer projectName)
      ;; Else
      (progn
        (find-file "~/org/gtd.org")
        (goto-char (point-min))
        (search-forward heading)
        (org-tree-to-indirect-buffer)
        (rename-buffer projectName)
        (org-overview)
        (show-children)
        )
      )
    )
  )

(defun my-find-gtd-org-heading nil
  (interactive)
  (find-file "~/org/gtd.org")
  )

(defun my-find-relatorio-atividades-org-heading nil
  (interactive)
  ;; (org-id-goto "RelatorioUFC35Wiki")
  (find-file "~/org/RelatoriosDeAtividade/RelatoriosDeAtividade.org")
  )

(defun my-find-doutorado-org-heading nil
  (interactive)
                                        ;(my-find-org-heading "Doutorado")
  (find-file "~/org/doutorado.org")
  )

(defun my-find-stanford-org-heading nil
  (interactive)
                                        ;(my-find-org-heading "Doutorado")
  (find-file "~/org/Stanford.org")
  )

(defun my-find-ufc32-org-heading nil
  (interactive)
  ;; (my-find-org-heading "UFC.32")
  (find-file (concat org-directory "/ufc32.org"))
  )

(defun my-find-ufc35-org-heading nil
  (interactive)
  ;; (my-find-org-heading "UFC.35")
  (find-file (concat org-directory "/ufc35.org"))
  )

(defun my-find-ufc42-org-heading nil
  (interactive)
  ;; (my-find-org-heading "UFC.42")
  (find-file (concat org-directory "/ufc42.org"))
  )

(defun my-find-ufc45-org-heading nil
  (interactive)
  ;; (my-find-org-heading "UFC.45")
  (find-file (concat org-directory "/ufc45.org"))
  )

(defun my-find-naive-org-heading nil
  (interactive)
  (find-file "~/org/naive.org")
  )

(defun my-find-financas-org-heading nil
  (interactive)
                                        ;(my-find-org-heading "Finanças")
  (find-file "~/org/Financas.org")
  )

(defun my-find-senhas-org-heading nil
  (interactive)
                                        ;(my-find-org-heading "Senhas")
  (require 'org-crypt)
  (find-file "~/org/Senhas.org")
  )

(defun my-find-carro-org-heading nil
  (interactive)
                                        ;(my-find-org-heading "Carro")
  (find-file "~/org/Carro.org")
  )

(defun my-find-calendario-org-heading nil
  (interactive)
  (my-find-org-heading "Calendário")
  )

(defun my-find-gtelbook-org-heading nil
  (interactive)
  (org-id-goto "LivroGTEL2013")
  )

(defun my-find-artigo-revista-org-heading nil
  (interactive)
  (org-id-goto "ArtMagazineExtInt")
  )



;; Transpose a Table
(defun org-transpose-table-at-point ()
  "Transpose orgmode table at point, eliminate hlines"
  (interactive)
  (let ((contents
         (apply #'mapcar* #'list
                ;; remove 'hline from list
                (remove-if-not 'listp
                               ;; signals error if not table
                               (org-table-to-lisp)))))
    (delete-region (org-table-begin) (org-table-end))
    (insert (mapconcat (lambda(x) (concat "| " (mapconcat 'identity x " | " ) "  |\n" ))
                       contents ""))
    (org-table-align)))



;; Get full path of a file relative to the current file
(defun fullpath-relative-to-current-file (file-relative-path)
          "Returns the full path of FILE-RELATIVE-PATH, relative to file location where this function is called.

        Example: If you have this line
         (fullpath-relative-to-current-file \"../xyz.el\")
        in the file at
         /home/mary/emacs/emacs_lib.el
        then the return value is
         /home/mary/xyz.el
        Regardless how or where emacs_lib.el is called.

        This function solves 2 problems.

         1. If you have file A, that calls the `load' on a file at B, and
            B calls 'load' on file C using a relative path, then Emacs
            will complain about unable to find C. Because, emacs does not
            switch current directory with 'load'.

            To solve this problem, when your code only knows the relative
            path of another file C, you can use the variable
            `load-file-name' to get the current file's full path, then
            use that with the relative path to get a full path of the
            file you are interested.

         2. To know the current file's full path, emacs has 2 ways:
            `load-file-name' and `buffer-file-name'. If the file is
            loaded by 'load', then load-file-name works but
            buffer-file-name doesn't. If the file is called by
            `eval-buffer', then load-file-name is nil. You want to be
            able to get the current file's full path regardless the file
            is run by 'load' or interactively by 'eval-buffer'."
          (concat (file-name-directory (or load-file-name buffer-file-name)) file-relative-path)
        )
