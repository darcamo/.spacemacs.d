;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  ;; xxxxxxxxxxxxxxx mu4e Configuration xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(with-eval-after-load "mu4e"
  (setq mu4e-use-fancy-chars t
        mu4e-headers-draft-mark     '("D" . "⚒")  ; draft
        mu4e-headers-seen-mark      '("S" . "☑")  ; seen
        mu4e-headers-unseen-mark    '("u" . "☐")  ; unseen
        mu4e-headers-unread-mark    '("u" . "☐")  ; unread
        mu4e-headers-flagged-mark   '("F" .  "⚵") ; flagged
        mu4e-headers-new-mark       '("N" .  "✱") ; new
        mu4e-headers-replied-mark   '("R" . "↵")  ; replied
        mu4e-headers-passed-mark    '("P" . "⇉")  ; passed
        mu4e-headers-encrypted-mark '("x" . "⚷")  ; encrypted
        mu4e-headers-signed-mark    '("s" . "✍") ; signed
        mu4e-headers-trashed-mark   '("T" . "⏚") ; Trashed
        mu4e-headers-attach-mark    '("a" . "⚓") ;; attach
        )

  (set-default 'mu4e-contexts
               `( ,(make-mu4e-context
                    :name "Pessoal"
                    :enter-func (lambda () (mu4e-message "Entering Pessoal context"))
                    :leave-func (lambda () (mu4e-message "Leaving Pessoal context"))
                    ;; we match based on the contact-fields of the message
                    :match-func (lambda (msg)
                                  (when msg
                                    (mu4e-message-contact-field-matches msg
                                                                        :to "darcamo@gmail.com")))
                    :vars '((user-mail-address  . "darcamo@gmail.com"  )
                            (user-full-name     . "Darlan Cavalcante Moreira")
                            (mu4e-sent-folder   . "/gmail/[Gmail].E-mails enviados")
                            (mu4e-drafts-folder . "/gmail/[Gmail].Rascunhos")
                            (mu4e-trash-folder  . "/gmail/[Gmail].Lixeira")
                            ;; ( mu4e-compose-signature .
                            ;;   (concat
                            ;;     "Alice Derleth\n"
                            ;;     "Lauttasaari, Finland\n"))
                            ))
                  ,(make-mu4e-context
                    :name "Trabalho"
                    :enter-func (lambda () (mu4e-message "Switch to the Work context"))
                    :leave-func (lambda () (mu4e-message "Leaving Work context"))
                    :match-func (lambda (msg)
                                  (when msg
                                    (mu4e-message-contact-field-matches msg
                                                                        :to "darlan@gtel.ufc.br")))
                    :vars '((user-mail-address  . "darlan@gtel.ufc.br")
                            (user-full-name     . "Darlan Cavalcante Moreira")
                            (mu4e-sent-folder   . "/gtel/[Gmail].E-mails enviados")
                            (mu4e-drafts-folder . "/gtel/[Gmail].Rascunhos")
                            (mu4e-trash-folder  . "/gtel/[Gmail].Lixeira")
                            ))
                  ))

  ;; start with the first (default) context;
  ;; default is to ask-if-none (ask when there's no context yet, and none match)
  (setq mu4e-context-policy 'pick-first)

  ;; compose with the current context is no context matches;
  ;; default is to ask
  ;; (setq mu4e-compose-context-policy nil)


  ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-get-mail-command "mbsync all")

  ;; ;; Set the mail-user-agent to the mu4e-user-agent.
  ;; ;; With this if you type the usual keybinding "C-x m" emacs will use the
  ;; ;; mu4e:compose mode
  ;; (if (boundp 'mail-user-agent)
  ;;     (setq mail-user-agent 'mu4e-user-agent))

  ;; Keybindings
  ;; (bind-key [backspace] 'scroll-down-command mu4e-headers-mode-map)
  ;; (bind-key [backspace] 'scroll-down-command mu4e-view-mode-map)
  ;; (bind-key [end] 'move-end-of-line mu4e-view-mode-map)
  ;; (bind-key [home] 'move-beginning-of-line mu4e-view-mode-map)

  ;; (setq mu4e-account-alist
  ;;       '(("gmail"
  ;;          ;; Under each account, set the account-specific variables you want.
  ;;          (mu4e-sent-messages-behavior delete)
  ;;          (mu4e-drafts-folder "/gmail/[Gmail].Rascunhos")
  ;;          (user-mail-address "darcamo@gmail.com")
  ;;          (user-full-name "Darlan Cavalcante Moreira")
  ;;          (mu4e-trash-folder "/gmail/[Gmail].Lixeira")
  ;;          (mu4e-sent-folder "/gmail/[Gmail].E-mails enviados")
  ;;          )
  ;;         ("gtel"
  ;;          ;; Under each account, set the account-specific variables you want.
  ;;          (mu4e-sent-messages-behavior delete)
  ;;          (mu4e-drafts-folder "/gtel/[Gmail].Rascunhos")
  ;;          (user-mail-address "darlan@gtel.ufc.br")
  ;;          (user-full-name "Darlan Cavalcante Moreira")
  ;;          (mu4e-trash-folder "/gtel/[Gmail].Lixeira")
  ;;          (mu4e-sent-folder "/gtel/[Gmail].E-mails enviados")
  ;;          )
  ;;         ))
  ;; ;; Reset mail account to the first one in mu4e-account-alist
  ;; (mu4e/mail-account-reset)


  ;;rename files when moving
  ;;NEEDED FOR MBSYNC
  (setq mu4e-change-filenames-when-moving t)

  ;;set up queue for offline email
  ;;use mu mkdir  ~/Maildir/queue to set up first
  (setq smtpmail-queue-mail nil  ;; start in normal mode
        smtpmail-queue-dir   "~/Maildir/queue/cur")

  ;; Actions
  ;; (add-to-list 'mu4e-headers-actions
  ;;              '("View in Browser" . mu4e-action-view-in-browser) t)

  ;; Bookmarks -> access with 'j' + letter
  (setq mu4e-maildir-shortcuts
        '( ("/gmail/Inbox"               . ?i)
           ("/gmail/[Gmail].E-mails enviados"   . ?e)
           ("/gmail/[Gmail].Lixeira"       . ?l)
           ;; ("/gmail/[Gmail].Todos os e-mails"    . ?t)
           ("/gtel/Inbox"               . ?I)
           ("/gtel/[Gmail].E-mails enviados"   . ?E)
           ("/gtel/[Gmail].Lixeira"       . ?L)
           ;; ("/gtel/[Gmail].Todos os e-mails"    . ?T)
           ("/gtel/ResearchGate"       . ?r)
           ("/gtel/Call of Papers"       . ?c)
           ;; ("/gmail/Stanford"       . ?s)
           ))

  ;; Bookmarks
  (add-to-list 'mu4e-bookmarks
               '("size:5M..500M" "Big messages" ?b))

  (add-to-list 'mu4e-bookmarks
               '("maildir:/gmail/Inbox flag:unread" "Gmail Inbox (unread)" ?i))

  (add-to-list 'mu4e-bookmarks
               '("maildir:/gtel/Inbox flag:unread" "GTEL Inbox (unread)" ?I))

  (add-to-list 'mu4e-bookmarks
               '("maildir:/gmail/Newsletter.IPython flag:unread" "IPython (unread)" ?p))

  (add-to-list 'mu4e-bookmarks
               '("maildir:\"/gmail/Newsletter.Numpy and Scipy\" flag:unread" "Numpy and Scipy (unread)" ?n))

  (add-to-list 'mu4e-bookmarks
               '("maildir:/gmail/Newsletter.Org-Mode flag:unread" "Org-Mode (unread)" ?o))

  (add-to-list 'mu4e-bookmarks
               '("maildir:\"/gmail/Stanford\" flag:unread" "Stanford (unread)" ?s))

  (add-to-list 'mu4e-bookmarks
               '("flag:unread AND NOT flag:trashed AND NOT maildir:/gtel/[Gmail].Lixeira AND NOT maildir:/Gmail/[Gmail].Lixeira" "Unread messages" ?u))

  (setq mu4e-user-mailing-lists '(("numpy-discussion.scipy.org" . "Numpy")
                                  ("ipython-dev.python.org" . "IPython")
                                  ("ipython-dev.scipy.org" . "IPython")
                                  ("dea-ufv.listas.ufv.br" . "Graça Freitas")
                                  ("moradoresparccezanne.googlegroups.com" . "Parc Cezanne")
                                  ("grupogestorparccezanne.googlegroups.com" . "Grupo Gestor"))
        )
  ;; xxxxxxxxxx End of mu4e Configuration xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  )
