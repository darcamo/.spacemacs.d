;; Templates

;; Veja o E-mail [[wl:%25Newsletter/Org-Mode!#80wrgxs3yg.fsf@somewhere.org][Email from Sebastien Vauban: Re: {O} Feature request: two-l]]
(setq org-capture-templates
      `(
        ;; xxxxx Start Capture a new tasks xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        ("t" "Adiciona nova tarefa")
        ("tt" "Nova Tarefa rápida (refile depois)" entry
         (file+headline "refile.org" "Inbox")
         (file "~/.emacs.d/lisp/org-capture-templates/new_task.org"))
        ("tp" "Tarefa do Projeto UFC.45" entry
         (id "UFC45Tarefas")
         (file "~/.emacs.d/lisp/org-capture-templates/new_task.org"))
        ("td" "Tarefa do Doutorado" entry
         (file+headline "doutorado.org" "Lista de Tarefas")
         (file "~/.emacs.d/lisp/org-capture-templates/new_task.org"))
        ("tc" "Tarefa dentro do clock atual" entry
         (clock)
         (file "~/.emacs.d/lisp/org-capture-templates/new_task.org"))
        ;; xxxxx End Capture a new tasks xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        ;;
        ;; xxxxx Start Capture new notes xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        ("n" "Notas" entry
         (file+headline "notas.org" "Notas diversas")
         "* %^{Título da Nota} %^g\n  %i%?\n  %a")
        ("e" "Nota de um E-Mail" entry
         (file+headline "notas.org" "Notas diversas")
         "* %^{Título da Nota} %^G\n  %i%?\n  \n  Assunto do E-mail: %:subject\n  De: %:from\n  %a")
        ;; ("o" "TOC do IEEE" entry
        ;;  (file+headline "gtd.org" "Lista de Tarefas")
        ;;  "* TODO Ver o TOC recebido em %u :TOC:\n  Links no E-Mail:\n  %?\n  \n  Assunto do E-mail: %:subject\n  %a")
        ("b" "Blog" entry
         (file+datetree "blog.org")
         "* %^{Título do Post} %^G\n  %t\n  %a\n\n  %i%?\n"
         :empty-lines 1)
        ;; xxxxx End Capture new notes xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        ;;
        ;; xxxxx Start Capture expenses data created with tasker xxxxxxxxxx
        ("f" "Adiciona novo gasto")
        ("fa" "Gasto com alimentação" table-line
         (id ,(get-me-an-org-id-for-the-month "Alimentação"))
         "%(concat \"|\" mytemplatevalue)"
         :table-line-pos "II-1"
         :immediate-finish t)
        ("fc" "Gasto com contas" table-line
         (id ,(get-me-an-org-id-for-the-month "Contas"))
         "%(concat \"|\" mytemplatevalue)"
         :table-line-pos "II-1"
         :immediate-finish t)
        ("ft" "Gasto com o carro ou transporte" table-line
         (id ,(get-me-an-org-id-for-the-month "Carro"))
         "%(concat \"|\" mytemplatevalue)"
         :table-line-pos "II-1"
         :immediate-finish t)
        ("fe" "Gasto com Entretenimento" table-line
         (id ,(get-me-an-org-id-for-the-month "Entretenimento"))
         "%(concat \"|\" mytemplatevalue)"
         :table-line-pos "II-1"
         :immediate-finish t)
        ("fd" "Gasto diversos" table-line
         (id ,(get-me-an-org-id-for-the-month "Diversos"))
         "%(concat \"|\" mytemplatevalue)"
         :table-line-pos "II-1"
         :immediate-finish t)
        ;; xxxxx End Capture expenses data created with tasker xxxxxxxxxxxx
        ;;
        ;; xxxxx Start Org-contacts xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        ("c" "Add a new contact" entry
         (file+headline "contacts.org" "New Contacts")
         (file "~/.emacs.d/lisp/org-capture-templates/new_contact.org")
         :kill-buffer t)
        ;; xxxxx End Org-contacts xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        ))



;; Capture in other frame

;; Função que peguei na lista do org-mode
;; [[wl:%25Newsletter/Org-Mode!#877ha9nfgy.fsf@ginnungagap.bsc.es][Email from Lluís: {O} org-capture-other-frame]]
;; #########################################################################
;; # I've made a little function to launch org-capture on another frame,   #
;; # which is very handy when plugged into a hotkey and working with other #
;; # applications.                                                         #
;; #                                                                       #
;; # It lacks some settings that I already have active system wide (like   #
;; # no scrollbars, no toolbar and the like), so you should probably tune  #
;; # those (a defcustom for the frame parameters should suffice).          #
;; #                                                                       #
;; # In any case, tell me (directly, as I'm not not subscribed) if you're  #
;; # going to install this into org-mode. Otherwise I'll upload the        #
;; # snippet into emacs wiki:                                              #
;; #########################################################################

;; *Para usar, basta chamar a função my-org-capture-other-frame*
;; Para usar fora do emacs (com emacs --daemon rodando) tente algo como
;; : emacsclient -d $DISPLAY -e '(my-org-capture-other-frame)'
(defun my-org-capture-other-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "Org-Capture")
                (width  . 120)
                (height .  20)
                (menu-bar-lines . 0)
                (tool-bar-lines . 0)
                (auto-lower . nil)
                (auto-raise . t)))
  (select-frame-by-name "Org-Capture")
  (if (condition-case nil
          (progn (org-capture) t)
        (error nil))
      (delete-other-windows)
    (my-org-capture-other-frame-cleanup)))

(defun my-org-capture-other-frame-cleanup ()
  "Close the Org-Capture frame."
  (if (equal "Org-Capture" (frame-parameter nil 'name))
      (delete-frame)))
(add-hook 'org-capture-after-finalize-hook 'my-org-capture-other-frame-cleanup)
