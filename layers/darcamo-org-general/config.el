;; T0D0 Keywords and colors
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)"  "|" "DONE(d!)" "DELE(e@)")
        (sequence "|" "CANC(c@)")
        (sequence "STARTED" "|")
        (sequence "CYCLIC" "|")
        (sequence "PROJ" "SOMEDAY" "|" "FINALIZADO" "CANC")
        (sequence "|" "FINALIZADO") ; Para compras na internet após receber o produto e qualificar
        ;; (sequence "TODO(t) STARTED WAIT(w@/!) | PUBLISHED(p) REJECTED(r@/!)")
        ))



;; Faces of some tags (ATTACH tag)
(setq org-tag-faces '(("ATTACH" :inherit org-done :box nil :underline t :height 1.2)))
                                        ;(setq org-tag-faces '(("ATTACH" :inherit org-done :box (:line-width 3 :background "red" :color "yellow" :style released-button) :underline t)))

;; By default both org-code and org-vertavim faces just inherit from the shadow
;; face. This makes them undistinguishable. Let's modify the color of the
;; org-code face to something different
(with-eval-after-load 'org-faces
  (set-face-attribute 'org-code nil :foreground "indian red")
  ;; Background color of my theme is gray14 and I'm choosing a value just a bit
  ;; brighter than it, such that the drawer is very discrete
  (set-face-attribute 'org-drawer nil :foreground "gray28")
  (set-face-attribute 'org-footnote nil :foreground "firebrick1")

  (with-eval-after-load 'color
    ;; Background color of src blocks will be slightly darken than default
    ;; background
    (set-face-attribute 'org-block nil :background
                        ;; (color-darken-name
                        ;;  (face-attribute 'default :background) 2)
                        "gray16"
                        )

    ;; Change background of the begin line and underline it
    (set-face-attribute 'org-block-begin-line nil
                        ;; :background (color-saturate-name (face-attribute 'default :background) 15)
                        :underline t)

    ;; Change background of the begin line and overline it
    ;;
    ;; Note that usually org-block-end-line inherits from org-block-begin-line,
    ;; but since we don't want the underline we set in org-block-begin-line we
    ;; change it to inherit from org-meta-line (which org-block-end-line inherits
    ;; from)
    (set-face-attribute 'org-block-end-line nil
                        ;; :background (color-saturate-name (face-attribute 'default :background) 10)
                        :inherit 'org-meta-line
                        :overline t)
    )
  )


;; Some pretty symbols
(add-hook
 'org-mode-hook
 (lambda ()
   (add-to-list 'prettify-symbols-alist '("<->" . "⬌"))
   (add-to-list 'prettify-symbols-alist '("->" . "➜"))
   (add-to-list 'prettify-symbols-alist '("<-" . "⬅"))
   (add-to-list 'prettify-symbols-alist '("[ ]" . "☐"))
   (add-to-list 'prettify-symbols-alist '("[X]" . "☑"))
   (add-to-list 'prettify-symbols-alist '("[-]" . "❍"))
   (setq prettify-symbols-unprettify-at-point t)
   (prettify-symbols-mode)
   )
 )


;; Allow unicode non-breaking space before and after org-mode emphasis
;;
;; By default it is not allowed and something like "/text/ bla" the "text" would
;; not be in italics. Here we change org-emphasis-regexp-components to allow " "
;; before and after org-mode emphasis.
;; See this question https://stackoverflow.com/questions/1218238/how-to-make-part-of-a-word-bold-in-org-mode
(with-eval-after-load 'org
  (setcar org-emphasis-regexp-components "-[:space:]('\"{ ")
  (setcar (nthcdr 1 org-emphasis-regexp-components) "-[:space:].,:!?;'\")}\\[ ")
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  )



;; General
(setq org-directory "~/org")

;; Change C-a and C-e behaviour in org-mode
(setq org-special-ctrl-a/e t)

;; To follow links with RET, rather than a 2 key combo
;; (setq org-return-follows-link t)

;; Usa o org-mode para arquivos README
(add-to-list 'auto-mode-alist '("README$" . org-mode))

;; Usa o org-mode para arquivos com extensão
(add-to-list 'auto-mode-alist '("\.org_archive$" . org-mode))

;; ;; Empty lines finish the list
;; (setq org-list-empty-line-terminates-plain-lists nil)

;; Number of empty lines needed to keep an empty line between collapsed
;; trees. If the number is negative, and the number of empty lines is at least
;; -N, all empty lines are shown.
;; (setq org-cycle-separator-lines -2)

;; Indica se uma linha em branco deve ser inserida antes de um heading, mas não
;; antes de uma lista. O ideal é usar auto, mas parece não funcionar direito
(setq org-blank-before-new-entry
      '((heading . auto) (plain-list-item . nil)))

;; Set to "t" to hide leading stars in org files by default
(setq org-hide-leading-stars t)

;; tell org-mode to use the default system programn to open open office documents
(setq org-file-apps (quote (
                            (auto-mode . emacs)
                            (directory . emacs)
                            ("\\.mm\\'" . default)
                            ("\\.x?html?\\'" . default)
                            ("pdf" . "evince %s")
                            ("\\.pdf::\\([0-9]+\\)\\'" . "evince -p %1 %s")  ;; Link containing a specific page
                            ("\\.od[s|p|t]" . default)
                            ("xmind" . "xmind-zen %s")
                            )))

;; When editing source code (with C-c ') Show edit buffer in the
;; current window, keeping all other windows.
(setq org-src-window-setup 'current-window)

;; (setq org-archive-default-command 'org-archive-to-archive-sibling)

;; The column to which tags should be indented in a headline. If this
;; number is positive, it specifies the column.  If it is negative, it
;; means that the tags should be flushright to that column.  For example,
;; -80 works well for a normal 80 character screen.
;;
;; We use the value -85 here because in org-mode we set the value of fill-column
;; to 90. Then we need 3 characters for the ellipsis and a bit more because the
;; "ATTACH" tag uses a larger font size.
(setq org-tags-column -85)

(add-hook 'org-mode-hook
          (lambda ()
            (setq fill-column 90)))

;; ;; Enable visual-line-mode in all org-mode buffers
;; (add-hook 'org-mode-hook 'visual-line-mode)

;; Disallow editing invisible parts (folded headlines) to avoid accidental
;; modifications.
(setq org-catch-invisible-edits 'error)

;; Non-nil means single character alphabetical bullets are allowed.
(setq org-list-allow-alphabetical t)



;; Appearance
;; Change the face of the ellipsis that represent folded text. I like
;; something with a slightly different color so that I can spot the
;; ellipsis easily
(setq org-ellipsis (quote org-column))

;; Increase the font size by setting the font height to 150
;; but only if I'am in my G75 computer.
;; (if (string-equal (system-name) "darlan-G75VX")
;;   (set-face-attribute 'default nil :height 150))



;; Logging
;; insert state change notes and time stamps into a drawer called LOGBOOK
(setq org-log-into-drawer t)



;; Properties
;; Set global properties such that you do not need a line such as
;; #+PROPERTY: Effort_ALL 0 0:10 0:20 0:30 1:00 2:00 3:00 4:00 8:00
;; in the beginning of each org file.
(setq org-global-properties
      '(("Effort_ALL". "0 0:10 0:20 0:30 1:00 1:30 2:00 3:00 4:00 5:00 6:00 7:00 8:00")))



;; Persistent Tags
(setq org-tag-persistent-alist
      '(
        ("Tarcísio" . ?t) ("Charles" . ?c) ("Igor" . ?i) ("Yuri" . ?y) ("Gabor" . ?G) ("ignore" . ?I) ("Ericsson" . ?e)
        (:startgroup . nil) ("Home" . ?h) ("GTEL" . ?g) (:endgroup . nil) ("Doutorado" . ?d) ("noexport" . ?n)
        ("Errands" . ?E) (:startgroup . nil) ("Someday" . ?s) ("NextActions" . ?N) (:endgroup . nil) ("crypt" . ?C) ("Projeto" . ?p) ("Leituras" . ?l)
        ))



;; Outline Minor Mode
(add-hook 'org-mode-hook
          (lambda ()
            (outline-minor-mode t)
            ))



;; Speed Commands
;; Enable speed-commands
;; Non-nil means, activate single letter commands at beginning of a headline.
;; Press "?" in the beginning of a headline to see the available commands.
(setq org-use-speed-commands t)

(with-eval-after-load "org"
  (add-to-list 'org-speed-commands
               '("d" org-decrypt-entry))
  (add-to-list 'org-modules 'org-tempo t)  ;; org-tempo add completions for "<KEY" to create blocks. See
  (add-to-list 'org-modules 'org-inlinetask t)  ;; org-tempo add completions for "<KEY" to create blocks. See
  )



;; Only the headline with the tag is a project. Any children are part of the
;; project and not project themselves.
(with-eval-after-load "org"
  (add-to-list 'org-tags-exclude-from-inheritance "Projeto")
  )

;; Stuck Projects
;; Let's assume that you, in your own way of using Org mode, identify
;; projects with a tag "ProjTasks", and that you use a TODO keyword MAYBE
;; to indicate a project that should not be considered yet. Let's further
;; assume that the TODO keyword DONE marks finished projects, and that NEXT
;; and TODO indicate next actions. The tag "ProjInfo" indicates that the
;; headline is a information headline and should not be counted. Finally,
;; if the project contains the special word "IGNORE" anywhere, it should
;; not be listed either. In this case you would start by identifying
;; eligible projects with a tags/todo match1 ‘+ProjTasks/-MAYBE-DONE’, and
;; then check for TODO, NEXT, ProjInfo, and IGNORE in the subtree to identify
;; projects that are not stuck. The correct customization for this is
(setq org-stuck-projects
      '("+Projeto-Someday/-MAYBE-DONE-FINALIZADO-CANC" ("NEXT" "TODO" "STARTED") ("ProjInfo")
        "\\<IGNORE\\>"))



;; Integration with Windmove
(add-hook 'org-shiftup-final-hook
          'windmove-up)

(add-hook 'org-shiftdown-final-hook
          'windmove-down)

(add-hook 'org-shiftright-final-hook
          'windmove-right)

(add-hook 'org-shiftleft-final-hook
          'windmove-left)



;; Category Icons
;; /home/darlan/Org-mode-dev/Icons_For_Category
;; ~/.emacs.d/Icons_For_Org-Mode_Category
(setq org-agenda-category-icon-alist
      '(
        ;("Papers" "/home/darlan/Programas_Locais/Emacs-trunk/etc/images/print.xpm" nil nil :ascent center)
        ("Papers" "/usr/share/icons/Humanity/mimes/24/application-pdf.svg" nil nil :ascent  center)
        ("Doutorado" "~/.spacemacs.d/Icons_For_Org-Mode_Category/registry-book.svg" nil nil :ascent  center)
        ("Book" "~/.spacemacs.d/Icons_For_Org-Mode_Category/registry-book.svg" nil nil :ascent  center)
        ("Carro" "~/.spacemacs.d/Icons_For_Org-Mode_Category/car.svg" nil nil :ascent  center)
        ("Escrever" "~/.spacemacs.d/Icons_For_Org-Mode_Category/write.svg" nil nil :ascent  center)
        ("Estudos" "~/.spacemacs.d/Icons_For_Org-Mode_Category/estudos.svg" nil nil :ascent  center)
        ("gtd" "~/.spacemacs.d/Icons_For_Org-Mode_Category/gtd.svg" nil nil :ascent  center)
        ("Supelec\\|Francês" "~/.spacemacs.d/Icons_For_Org-Mode_Category/Flag_of_France.svg" nil nil :ascent  center)
        ("Refile" "~/.spacemacs.d/Icons_For_Org-Mode_Category/refile.svg" nil nil :ascent  center)
        ("IAB\\|GTEL\\|NAIVE\\|UFC.32\\|UFC.35\\|UFC.42" "~/.spacemacs.d/Icons_For_Org-Mode_Category/gtel.svg" nil nil :ascent  center)
        ("Patent" "~/.spacemacs.d/Icons_For_Org-Mode_Category/gtel25x25.png" nil nil :ascent  center)
        ("Projeto" "~/.spacemacs.d/Icons_For_Org-Mode_Category/project.svg" nil nil :ascent  center)
        ("Cíclicas" "~/.spacemacs.d/Icons_For_Org-Mode_Category/recycle.svg" nil nil :ascent center)
        ("Compras\\|Finanças" "~/.spacemacs.d/Icons_For_Org-Mode_Category/gold_coins.svg" nil nil :ascent center)
        ("Someday" "~/.spacemacs.d/Icons_For_Org-Mode_Category/Global_thinking.svg" nil nil :ascent center)
        ("Stanford" "~/.spacemacs.d/Icons_For_Org-Mode_Category/graduate.svg" nil nil :ascent center)
        ("Notas" "~/.spacemacs.d/Icons_For_Org-Mode_Category/notes.svg" nil nil :ascent center)
        ("References" "~/.spacemacs.d/Icons_For_Org-Mode_Category/estudos.svg" nil nil :ascent  center)
        ("Eventos" "~/.spacemacs.d/Icons_For_Org-Mode_Category/event.svg" nil nil :ascent  center)
       ))



;; Org-bibtex
(setq org-bibtex-prefix "BIB_")
(setq org-bibtex-export-arbitrary-fields t)
;; (setq org-bibtex-autogen-keys)
