
(with-eval-after-load 'org

  ;; General
  (setq org-agenda-inhibit-startup t)

  ;; Vc pode incluir cada arquivo individualmente ou usar o comando abaixo para incluir todos
  ;; Including all org files from a directory into the agenda
  ;; (setq org-agenda-files (file-expand-wildcards "~/org/*.org"))
  ;; (setq org-agenda-files (quote ("~/org")))
  (setq org-agenda-files "~/org/org-agenda-files.org")

  ;; The notas.org file is not included in the agenda files, but I still want
  ;; to search it
  (setq org-agenda-text-search-extra-files
        (append
         '("~/org/escrever.org" "~/org/notas.org" "~/org/supelec/supelec.org")
         (directory-files "~/org/OrgWiki/" t "^[^.#].*\\.\\(org$\\|org_archive$\\)")
         )
        )

  ;; Set refile targets to the agenda files
  (setq org-refile-targets (quote ((org-agenda-files :maxlevel . 1)
                                   ("~/org/notas.org" :tag . "REFILE"))))

  ;; Use outline-path when refiling
  (setq org-refile-use-outline-path (quote file))

  ;; Non-nil means complete the outline path in hierarchical steps. We don't
  ;; want that, since we will use the refile with helm.
  (setq org-outline-path-complete-in-steps nil)

  ;; Faz com que tarefas escalonadas ou com deadlines não apareçam na lista
  ;; de todos (C-c a t)
  ;; (setq org-agenda-todo-ignore-with-date t)

  ;; Non-nil means, restore window configuration open exiting agenda.  Before
  ;; the window configuration is changed for displaying the agenda, the
  ;; current status is recorded.  When the agenda is exited with `q' or `x'
  ;; and this option is set, the old state is restored.
  (setq org-agenda-restore-windows-after-quit t)

  (setq org-tag-alist '((:startgrouptag)
                        ("Year")
                        (:grouptags)
                        ("{20[0-9][0-9]}")
                        (:endgrouptag)))


  ;; My agenda super-agenda groups -> Used in my custom command to show the agenda
    (setq my-agenda-org-super-agenda-groups '(
                                    (:name "Tarefas Concluídas"
                                           :todo "DONE"
                                           ;; :and (:regexp "State \"DONE\""
                                           ;;               )
                                           :face (:foreground "gray40")
                                           :order 200) ;; Any item without order has a value of zero
                                    (
                                     :name "Started"
                                           :todo "STARTED")
                                    (
                                     :name "Importantes"
                                           :priority "A"
                                           :face "bold")
                                    (:name "Atrasadas"
                                           :deadline past)
                                    (:name "Demais Tarefas"
                                           :anything t)
                                    ))

  ;; Custom agenda views
  (setq org-agenda-custom-commands
        '(
          ("a" "Agenda" (
                         (agenda "" ((org-super-agenda-groups my-agenda-org-super-agenda-groups)))
                         (tags-todo "NextActions" ((org-agenda-overriding-header "Task with tag NextActions")))
                         )
           )

          ("n" "Escolher tarefas para adicionar tag NextActions" todo "" (
                                                                          (org-agenda-todo-ignore-scheduled 'all)
                                                                          (org-agenda-filter-preset '("-NextActions" "-Finanças"))
                                                                          ))

                ;; ("c" "Clock" tags-todo "CLOCK")
                ;; ("E" "NextActions" tags-todo "NextActions")
                ;; ("N" . "Procura em notas.org")
                ;; ("Nw" search ""
                ;;  ((org-agenda-files '("~/org/notas.org"))
                ;;   (org-agenda-text-search-extra-files nil)))
                ;; ("Nt" tags ""
                ;;  ((org-agenda-files '("~/org/notas.org"))
                ;;   (org-agenda-text-search-extra-files nil)))
                ;; ("w" . "Procura na Wiki no org")
                ;; ("ww" search ""
                ;;  ((org-agenda-files '("~/org/OrgWiki/"))
                ;;   (org-agenda-text-search-extra-files '("~/org/notas.org"))))
                ;; ("wt" tags ""
                ;;  ((org-agenda-files '("~/org/OrgWiki/"))
                ;;   (org-agenda-text-search-extra-files '("~/org/notas.org"))))
                ("d" "Upcoming deadlines" agenda ""
                 ((org-agenda-time-grid nil)
                  (org-deadline-warning-days 365)
                  (org-agenda-entry-types '(:deadline))
                  ))
                ;; ("P" "Papers para Ler" tags-todo "+CATEGORY=\"LeituraDePapers\"")
                ("p" "Lista de Projetos" tags-todo "Projeto" ((org-use-tag-inheritance nil)))
                ("S" "Started Tasks" todo "STARTED" ((org-agenda-todo-ignore-with-date nil) (org-agenda-todo-ignore-scheduled nil)))
                ("W" "Tasks waiting on something" todo "WAIT" ((org-agenda-todo-ignore-with-date nil) (org-agenda-todo-ignore-scheduled nil)))
                ("R" "Refile New Notes and Tasks" tags "REFILE" ((org-agenda-todo-ignore-with-date nil) (org-agenda-todo-ignore-scheduled nil)))
                ;; ("g" "Agenda GTEL (exclui Francês e Home e Supélec)" agenda "" ((org-agenda-filter-preset (quote ("-Home" "-Francês" "-Supelec" "-Finanças")))))
                ;; ("f" "Agenda do Francês" agenda "" ((org-agenda-filter-preset (quote ("+Francês")))))
                ;; ("A" "Relatório de Atividades" agenda "" ((org-agenda-filter-preset (quote ("-Francês" "-Finanças" "-Revistas" "-Congressos" "-Feriado" "-Aniversários" "-CLOCK"))) (org-agenda-start-with-log-mode t) (org-agenda-archives-mode 'tree) (org-agenda-ndays 31)) "teste_relatorio.html")
                ("F" "Agenda das Finanças" agenda "" ((org-agenda-filter-preset (quote ("+Finanças")))))
                ;; Abaixo um exemplo de prefix key. Note que a primeira linha
                ;; (uma con-cell) serve para setar uma descrição para a
                ;; prefix key "h" e não é obrigatória.
                ;; ("h" . "HOME+Name tags searches") ; description for "h" prefix
                ;; ("hl" tags "+home+Lisa")
                ;; ("hp" tags "+home+Peter")
                ;; ("hk" tags "+home+Kim")
                ))



  ;; Agenda Sorting
  (setq org-agenda-sorting-strategy
        '(
          (agenda habit-down category-down time-up priority-down)
          (todo category-down priority-down)
          (tags priority-down category-keep)
          (search category-keep)
          )
        )


  ;; Enable origami-mode in org-agenda
  (with-eval-after-load 'org-super-agenda
  ;; Note that origami package is installed by the spacemacs-editing layer
  (define-key org-super-agenda-header-map (kbd "<tab>") 'origami-toggle-node)
  ;; (define-key org-super-agenda-header-map (kbd "C-M-p") 'origami-previous-fold)
  ;; (define-key org-super-agenda-header-map (kbd "C-M-n") 'origami-next-fold)
  (add-hook 'org-agenda-mode-hook 'origami-mode)
  )



  ;; Customise some of the org-agenda faces
  (set-face-attribute 'org-agenda-date nil :height 1.5 :foreground "Orange")
  (set-face-attribute 'org-agenda-date-today nil :foreground "Gold")


  ) ;; End of eval after load
