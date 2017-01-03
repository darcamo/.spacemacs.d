
(with-eval-after-load 'org

  ;; General

  ;; Vc pode incluir cada arquivo individualmente ou usar o comando abaixo para incluir todos
  ;; Including all org files from a directory into the agenda
  ;; (setq org-agenda-files (file-expand-wildcards "~/Muse/org/*.org"))
                                        ;(setq org-agenda-files (quote ("~/Muse/org")))
  (setq org-agenda-files "~/Muse/org/org-agenda-files.org")

  ;; The notas.org file is not included in the agenda files, but I still want
  ;; to search it
  (setq org-agenda-text-search-extra-files
        (append
         '("~/Muse/org/notas.org" "~/Muse/org/supelec.org")
         (directory-files "~/Muse/OrgWiki/" t "^[^.#].*\\.\\(org$\\|org_archive$\\)")
         )
        )

  ;; Set refile targets to the agenda files
  (setq org-refile-targets (quote ((org-agenda-files :maxlevel . 3))))

  ;; Use outline-path when refiling
  (setq org-refile-use-outline-path (quote file))

  ;; Non-nil means complete the outline path in hierarchical steps. We don't
  ;; want that, since we will use the refile with helm.
  (setq org-outline-path-complete-in-steps nil)

  ;; Faz com que tarefas escalonadas ou com deadlines não apareçam na lista
  ;; de todos (C-c a t)
  (setq org-agenda-todo-ignore-with-date t)

  ;; Non-nil means, restore window configuration open exiting agenda.  Before
  ;; the window configuration is changed for displaying the agenda, the
  ;; current status is recorded.  When the agenda is exited with `q' or `x'
  ;; and this option is set, the old state is restored.
  (setq org-agenda-restore-windows-after-quit t)



  ;; Custom agenda views
  (setq org-agenda-custom-commands
        (quote (
                ("n" "Agenda and NextActions"
                 ((agenda "")
                  (tags-todo "NextActions")
                  ))
                ("c" "Clock" tags-todo "CLOCK")
                ("E" "NextActions" tags-todo "NextActions")
                ("N" . "Procura em notas.org")
                ("Nw" search ""
                 ((org-agenda-files '("~/Muse/org/notas.org"))
                  (org-agenda-text-search-extra-files nil)))
                ("Nt" tags ""
                 ((org-agenda-files '("~/Muse/org/notas.org"))
                  (org-agenda-text-search-extra-files nil)))
                ("w" . "Procura na Wiki no org")
                ("ww" search ""
                 ((org-agenda-files '("~/Muse/OrgWiki/"))
                  (org-agenda-text-search-extra-files '("~/Muse/org/notas.org"))))
                ("wt" tags ""
                 ((org-agenda-files '("~/Muse/OrgWiki/"))
                  (org-agenda-text-search-extra-files '("~/Muse/org/notas.org"))))
                ;; ("w" "Wiki search" search ""
                ;;  ((org-agenda-files '("~/Muse/OrgWiki/"))
                ;;   (org-agenda-text-search-extra-files '("~/Muse/org/notas.org"))))
                ("d" "Upcoming deadlines" agenda ""
                 ((org-agenda-time-grid nil)
                  (org-deadline-warning-days 365)
                  (org-agenda-entry-types '(:deadline))
                  ))
                ;; ("P" "Papers para Ler" tags-todo "+CATEGORY=\"LeituraDePapers\"")
                ("p" "Lista de Projetos" tags "Projeto" ((org-use-tag-inheritance nil)))
                ("S" "Started Tasks" todo "STARTED" ((org-agenda-todo-ignore-with-date nil) (org-agenda-todo-ignore-scheduled nil)))
                ("W" "Tasks waiting on something" todo "WAIT" ((org-agenda-todo-ignore-with-date nil) (org-agenda-todo-ignore-scheduled nil)))
                ("R" "Refile New Notes and Tasks" tags "REFILE" ((org-agenda-todo-ignore-with-date nil) (org-agenda-todo-ignore-scheduled nil)))
                ("g" "Agenda GTEL (exclui Francês e Home e Supélec)" agenda "" ((org-agenda-filter-preset (quote ("-Home" "-Francês" "-Supelec" "-Finanças")))))
                ;; ("f" "Agenda do Francês" agenda "" ((org-agenda-filter-preset (quote ("+Francês")))))
                ("A" "Relatório de Atividades" agenda "" ((org-agenda-filter-preset (quote ("-Francês" "-Finanças" "-Revistas" "-Congressos" "-Feriado" "-Aniversários" "-CLOCK"))) (org-agenda-start-with-log-mode t) (org-agenda-archives-mode 'tree) (org-agenda-ndays 31)) "teste_relatorio.html")
                ("F" "Agenda das Finanças" agenda "" ((org-agenda-filter-preset (quote ("+Finanças")))))
                ;; Abaixo um exemplo de prefix key. Note que a primeira linha
                ;; (uma con-cell) serve para setar uma descrição para a
                ;; prefix key "h" e não é obrigatória.
                ;; ("h" . "HOME+Name tags searches") ; description for "h" prefix
                ;; ("hl" tags "+home+Lisa")
                ;; ("hp" tags "+home+Peter")
                ;; ("hk" tags "+home+Kim")
                )))



  ;; Agenda Sorting
  (setq org-agenda-sorting-strategy
        '(
          (agenda habit-down category-down time-up priority-down)
          (todo category-down priority-down)
          (tags priority-down category-keep)
          (search category-keep)
          )
        )


  ) ;; End of eval after load
