;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxx mu4e Configuration xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(with-eval-after-load "mu4e"
  (setq mu4e-use-fancy-chars t
        mu4e-headers-draft-mark     '("D" . "⚒")  ; draft
        mu4e-headers-seen-mark      '("S" . "☑")  ; seen
        mu4e-headers-unseen-mark    '("u" . "☐")  ; unseen
        mu4e-headers-unread-mark    '("u" . "☐")  ; unread
        mu4e-headers-flagged-mark   '("F" .  "⋆") ; flagged ⚵
        mu4e-headers-new-mark       '("N" .  "✱") ; new
        mu4e-headers-replied-mark   '("R" . "↵")  ; replied
        mu4e-headers-passed-mark    '("P" . "⇉")  ; passed
        mu4e-headers-encrypted-mark '("x" . "🔑")  ; encrypted ⚷
        mu4e-headers-signed-mark    '("s" . "✍") ; signed
        mu4e-headers-trashed-mark   '("T" . "⏚") ; Trashed
        mu4e-headers-attach-mark    '("a" . "📎") ;; attach ⚓
        )


  ;; Hide the "Indexing..." messages (they interfere with the minibuffer)
  (setq mu4e-hide-index-messages t)

  ;; Olhe a configuração em https://tecosaur.github.io/emacs-config/config.html#sending-mail
  ;; xxxxxxxxxx SMTP Configuration xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  ;; Note that some of the variable values will be replaced during a mu4e
  ;; context switch and here we set the default values
  (with-eval-after-load "smtpmail"
    (setq message-send-mail-function 'smtpmail-send-it
          message-sendmail-f-is-evil t
          starttls-use-gnutls t
          ;; smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
          ;;smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg")
          ;; ;; smtpmail-default-smtp-server only has effect if you specify it
          ;; ;; before loading the smtpmail library.
          ;; smtpmail-default-smtp-server "smtp.gmail.com"
          smtpmail-smtp-user "darcamo@gmail.com"
          smtpmail-smtp-server "smtp.gmail.com"
          smtpmail-smtp-service 465
          smtpmail-stream-type 'ssl
          ;; smtpmail-debug-info t
          )

    ;; Determines what mu4e does with sent messages. Since we use gmail, which
    ;; already stores the sent messages, we set this to 'delete so that we do
    ;; not get a duplicated message
    (setq mu4e-sent-messages-behavior 'delete)

    ;; SMTP Queue
    (setq smtpmail-queue-mail  nil  ;; start in non-queuing mode
          smtpmail-queue-dir   "~/Maildir/queue/cur")
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
                                                                         '(:to :cc :bcc) "darcamo@gmail.com")))
                    :vars '((user-mail-address  . "darcamo@gmail.com"  )
                            (user-full-name     . "Darlan Cavalcante Moreira")
                            (smtpmail-smtp-user . "darcamo@gmail.com")
                            (mu4e-sent-folder   . "/gmail/[Gmail].E-mails enviados")
                            (mu4e-drafts-folder . "/gmail/[Gmail].Rascunhos")
                            (mu4e-trash-folder  . "/gmail/[Gmail].Lixeira")
                            (message-signature-file . "~/.signature")
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
                                                                        '(:to :cc :bcc) "darlan@gtel.ufc.br")))
                    :vars '((user-mail-address  . "darlan@gtel.ufc.br")
                            (user-full-name     . "Darlan Cavalcante Moreira")
                            (smtpmail-smtp-user . "darlan@gtel.ufc.br")
                            (mu4e-sent-folder   . "/gtel/[Gmail].E-mails enviados")
                            (mu4e-drafts-folder . "/gtel/[Gmail].Rascunhos")
                            (mu4e-trash-folder  . "/gtel/[Gmail].Lixeira")
                            (message-signature-file . "~/.signature_gtel")
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

  ;; Set the mail-user-agent to the mu4e-user-agent.
  ;; With this if you type the usual keybinding "C-x m" emacs will use the
  ;; mu4e:compose mode
  (if (boundp 'mail-user-agent)
      (setq mail-user-agent 'mu4e-user-agent))

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

  ;; Don't change to next message when scrolling at the end of a message
  (setq mu4e-view-scroll-to-next nil)

  ;; Actions
  (add-to-list 'mu4e-view-actions
               '("View in Browser" . mu4e-action-view-in-browser) t)

  (add-to-list 'mu4e-view-actions
               '("wxidget" . mu4e-action-view-with-xwidget) t)

  ;; ;; Set to 't' to use Gnus’ article view, instead of mu4e internal viewer
  ;; (setq mu4e-view-use-gnus t)

  ;; Whether to base the body display on the html-version.
  (setq mu4e-view-prefer-html t)


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
           ;; ("/gtel/ResearchGate"       . ?r)
           ("/gtel/Call of Papers"       . ?c)
           ;; ("/gmail/Stanford"       . ?s)
           ))


  ;; Bookmarks -> access with 'b' + letter
  (add-to-list 'mu4e-bookmarks
               '(:name "Big messages" :query "size:5M..500M" :key ?b))

  (add-to-list 'mu4e-bookmarks
               '(:name "Gmail Inbox (unread)" :query "maildir:/gmail/Inbox flag:unread" :key ?i))

  (add-to-list 'mu4e-bookmarks
               '(:name "GTEL Inbox (unread)" :query "maildir:/gtel/Inbox flag:unread" :key ?I))

  ;; (add-to-list 'mu4e-bookmarks
  ;;              '(:name "IPython (unread)" :query "maildir:/gmail/Newsletter.IPython flag:unread NOT flag:trashed" :key ?p))

  ;; (add-to-list 'mu4e-bookmarks
  ;;              '(:name "Numpy and Scipy (unread)" :query "list:numpy-discussion.* flag:unread NOT flag:trashed" :key ?n))

  (add-to-list 'mu4e-bookmarks
               '(:name "From Medium (unread)" :query "from:\"medium.com\" flag:unread NOT flag:trashed" :key ?m))

  (add-to-list 'mu4e-bookmarks
               '(:name "From Facebook (unread)" :query "from:\"facebook\" flag:unread NOT flag:trashed" :key ?f))

  (add-to-list 'mu4e-bookmarks
               '(:name "From Quora (unread)" :query "from:\"quora\" flag:unread NOT flag:trashed" :key ?q))

  (add-to-list 'mu4e-bookmarks
               '(:name "From Empiricus (unread)" :query "empiricus flag:unread NOT flag:trashed" :key ?e))

  (add-to-list 'mu4e-bookmarks
               '(:name "Graça Freitas (unread)" :query "list:dea-ufv.listas.ufv.br flag:unread NOT flag:trashed" :key ?g))

  ;; (add-to-list 'mu4e-bookmarks
  ;;              '(:name "Org-Mode (unread)" :query "list:emacs-orgmode.gnu.org flag:unread NOT flag:trashed" :key ?o))

  ;; Note that mu4e already comes with a bookmark for unread messages. We
  ;; replaced it just to add the condition of not being a GMAIL trash folder
  (add-to-list 'mu4e-bookmarks
               '(:name "Unread messages" :query "flag:unread AND NOT flag:trashed AND NOT maildir:/gtel/[Gmail].Lixeira AND NOT maildir:/Gmail/[Gmail].Lixeira" :key ?u))

  (add-to-list 'mu4e-bookmarks
               '(:name "Importantes (de um ano pra cá)" :query "flag:flagged NOT flag:trashed date:1y.." :key ?s))

  (add-to-list 'mu4e-bookmarks
               '(:name "Importantes (todas)" :query "flag:flagged NOT flag:trashed" :key ?S))



  (setq mu4e-user-mailing-lists '(
                                  ("todos.gtel.ufc.br" . "GTEL-Todos")
                                  ("numpy-discussion.python.org" . "Numpy")
                                  ("numpy-discussion.scipy.org" . "Numpy")
                                  ("ipython-dev.python.org" . "IPython")
                                  ("ipython-dev.scipy.org" . "IPython")
                                  ("dea-ufv.listas.ufv.br" . "Graça Freitas")
                                  ("moradoresparccezanne.googlegroups.com" . "Parc Cezanne")
                                  ("grupogestorparccezanne.googlegroups.com" . "Grupo Gestor"))
        )

  ;; Alert for new e-mails
  ;; (with-eval-after-load 'mu4e-alert
  ;;   ;; Enable Desktop notifications
  ;;   (mu4e-alert-set-default-style 'notifications))

  ;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  ;; xxxxxxxxxx End of mu4e Configuration xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  ;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  )
