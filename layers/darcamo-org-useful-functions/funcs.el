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

(defun my-find-references-org-heading nil
  (interactive)
  (find-file "~/org/references/articles.org")
  )

(defun my-find-articles-org-heading nil
  "Same as my-find-references-org-heading"
  (interactive)
  (find-file "~/org/references/articles.org")
  )

(defun my-find-notas-org-heading nil
  (interactive)
  (find-file "~/org/notas.org")
  )

(defun my-find-stanford-org-heading nil
  (interactive)
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
  (find-file "~/org/ufc46-NAIVE.org")
  )

(defun my-find-iab-org-heading nil
  (interactive)
  (find-file "~/org/ufc49-IAB.org")
  )

(defun my-find-financas-org-heading nil
  (interactive)
                                        ;(my-find-org-heading "Finanças")
  (find-file "~/org/Financas.org")
  ;;(org-id-open "Novembro2020" nil)
  )

(defun my-find-financas-heading-by-id (value)
  (require 'org-id)
  (org-id-open (concat (get-current-month) (get-current-year) value) nil)
  (recenter-top-bottom 0)
  )

(defun my-find-gastos-org-heading nil
  (interactive)
  (require 'org-id)
  (my-find-financas-heading-by-id "")
  )

(defun my-find-gastos-alimentacao-org-heading nil
  (interactive)
  (my-find-financas-heading-by-id "Alimentação")
  )

(defun my-find-gastos-contas-org-heading nil
  (interactive)
  (my-find-financas-heading-by-id "Contas")
  )

(defun my-find-gastos-entretenimento-org-heading nil
  (interactive)
  (my-find-financas-heading-by-id "Entretenimento")
  )

(defun my-find-gastos-carro-org-heading nil
  (interactive)
  (my-find-financas-heading-by-id "Carro")
  )

(defun my-find-gastos-diversos-org-heading nil
  (interactive)
  (my-find-financas-heading-by-id "Diversos")
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



;; Functions to surround some text with an org-mode macro for red color
;; You need the org-macros.setup file or to manyally add the macro below to your org-mode file
;; #+MACRO: color @@html:<span style="color: $1">$2</span>@@@@latex:\textcolor{$1}{$2}@@@@odt:<text:span text:style-name="$1">$2</text:span>@@

(defun my-org-textcolor-red-macro ()
  "Surround current region with {{{color(red, content)}}} if mark is active or prompts for a text and insert {{{color(red, the text)}}}."
  (interactive)
  (let (pos1 pos2 text)
    (if (and transient-mark-mode
             mark-active)
        (my-org-surround-textcolor-red-macro (region-beginning) (region-end))
      (insert "{{{color(red," (read-from-minibuffer "Text in red: ") ")}}}")
      )))

(defun my-org-surround-textcolor-red-macro (beg end)
  "Surround the region with \textcolor{red}{ }"
  (interactive "r")
  (save-restriction
    (narrow-to-region beg end)
    (goto-char (point-min))
    (insert "{{{color(red,")
    (goto-char (point-max))
    (insert ")}}}")))


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
