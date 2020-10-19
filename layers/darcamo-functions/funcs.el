
;; Got from http://stackoverflow.com/questions/17325713/looking-for-a-replace-in-string-function-in-elisp
(defun darlan-replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))



(defun darlan/list-of-strings-p (arg)
  "Return t if arg is a list of strings"
  (every 'stringp arg)
  )


(defun darlan/string-to-ascii (string)
      "Change a string containing unicode characters to the
        equivalent ascii string. Note that not all characters are
        replaced, only the ones I usually don't want."
      (s-replace-all
       '(
         ("“" . "\"")
         ("”" . "\"")
         ("→" . "->")
         ("–" . "-")
         ("—" . "-")
         ("…" . "...")
         ("’" . "'")
         ("‘" . "'")
         )
       string)
      )

    (defun darlan/string-to-ascii-region (beg end)
      "Change the selected text containing unicode characters to the
        equivalent text in ascii. Note that not all characters are
        replaced, only the ones I usually don't want."
      (interactive "r")
      (let (replacement)
        (save-restriction
          (narrow-to-region beg end)
          (save-excursion
            (setq replacement (darlan/string-to-ascii (buffer-substring beg end)))
            (delete-region beg end)
            (goto-char beg)
            (insert replacement)))))


      (defun darlan/surround-region (beg end leftPart rightPart)
        "Surround a region with the content of the leftPart and
      rightPart variables."
        (interactive "r")
        (save-restriction
          (narrow-to-region beg end)
          (goto-char (point-min))
          (insert leftPart)
          (goto-char (point-max))
          (insert rightPart)))

      (defun darlan/org-surround-inline-math (beg end)
        "Surround a region with single dollar signs"
        (interactive "r")
        (darlan/surround-region beg end "$" "$"))

      (defun darlan/surround-region-dowim (leftPart rightPart)
        "Surround a region with the content of the leftPart and
      rightPart variables. If the region is not active, the region
      between the current point and the point given by forward-word
      will be used."
        (interactive)
        (let (beg end)
          (if (and transient-mark-mode
                   mark-active)
              ;; Region active code
              (progn (setq beg (region-beginning) end (region-end))
                     (darlan/surround-region beg end leftPart rightPart)
                     )
            ;; Region inactive code: beg = current point, end = end of the word
            (progn
              (setq beg (point))
              (forward-word)
              (setq end (point))
              (darlan/surround-region beg end leftPart rightPart)
              )
            )
          )
        )

      (defun darlan/surround-with-command ()
        "Usefull to surround a region with a command (in MATLAB shell
      buffers, for instance). If the command if not provided it will be
      asked in the minibuffer."
        (interactive)
        (let (command rightPart leftPart)
          (setq command (read-from-minibuffer "Command Name: "))
          (setq leftPart (concat command "("))
          (setq rightPart ")")
          (darlan/surround-region-dowim leftPart rightPart)
          )
        )



(defun browse-doi-url (url)
  "Open the url corresponding to the specified DOI number in the browser"
  (interactive "sDoi Number: ")
  (browse-url (concat "http://dx.doi.org/" url)))



(defun toggle-current-window-dedication ()
  (interactive)
  (let* ((window    (selected-window))
         (dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not dedicated))
    (message "Window %sdedicated to %s"
             (if dedicated "no longer " "")
             (buffer-name))))



;; Time functions
(defun replace-nth-element (lista index valor)
  "Replace the elemented pointed by 'index' in the list 'lista'
        with the value of 'value'"
  (replace lista (list valor) :start1 index)
  )

(defun get-current-year()
  (interactive)
  (format-time-string "%Y" (current-time))
  )

(defun get-current-month()
  (interactive)
  (capitalize (format-time-string "%B" (current-time)))
  )

(defun get-me-an-org-id-for-the-month (categoryName)
  "Used only in my template for the finances of the month. It
        return a suitable ID for the month sub-headline."
  (interactive)
  (concat (get-current-month) (get-current-year) categoryName)
  )

(defun get-today-org-time-stamp ()
  "Insert a time-stamp for today in the same format org-mode uses
        for inactive timestamps."
  (interactive)
  (format-time-string "[%Y-%m-%d %a]" (current-time))
  )


(defun get-previous-month()
  (interactive)
  (capitalize (format-time-string "%B"
                                  ;; decode-time retorna uma lista especificando a data/hora atual na forma
                                  ;; (SEC MINUTE HOUR DAY MONTH YEAR DOW DST ZONE). Depois substituo o dia
                                  ;; por 0. Com isso ao aplicar encode-time e em seguida format-time-string
                                  ;; eu vou pegar o mês anterior ao invés do mez atual (funciona até mesmo
                                  ;; para janeiro).
                                  (apply 'encode-time ( replace-nth-element (decode-time) 3 0))
                                  ))
  )

(defun get-previous-month-year()
  "Get the year of the previous month. This will be equal to the current yar except when we are in january"
  (interactive)
  (capitalize (format-time-string "%Y"
                                  ;; decode-time retorna uma lista especificando a data/hora atual na forma
                                  ;; (SEC MINUTE HOUR DAY MONTH YEAR DOW DST ZONE). Depois substituo o dia
                                  ;; por 0. Com isso ao aplicar encode-time e em seguida format-time-string
                                  ;; eu vou pegar o ano do mês anterior (igual ao ano atual, exceto se
                                  ;; estivermos em janeiro, quando ele retorna o ano anterior)
                                  (apply 'encode-time ( replace-nth-element (decode-time) 3 0))
                                  ))
  )



(defun get-filemanager-fullpath ()
  "Return the path to nautilus, if installed, or to pcmanfm. If
 neither is installed, return nil."
  (setq filemanager (executable-find "nautilus"))
  (if (equal filemanager nil)
      (setq filemanager (executable-find "pcmanfm")))
  filemanager
  )

;; Browse Directory
(defun browse-dir (dir-as-string)
  (start-process-shell-command
   "browse"
   "*scratch*"
   ;; Trocar nautilus por pcmanfm para o lxde
   (concat (get-filemanager-fullpath) " " (concat "\"" (expand-file-name dir-as-string) "\""))))

;; Use essa para abrir links sftp com o nautilus, como sftp://darlan@ssh.gtel.ufc.br/home/gtels0/projetos/ufc32
(defun browse-dir-sftp (dir-as-string)
  (start-process-shell-command
   "browse"
   "*scratch*"
   (concat (get-filemanager-fullpath) " --no-desktop " dir-as-string)))

(defun browse-default-dir ()
  "Open Nautilus in the default directory, which is the directory
              of the file associated with the current buffer."
  (interactive)
  (browse-dir default-directory))

(defun browse-default-dir-in-emacs ()
  "Open the default directory in emacs with dired, which is the
              directory of the file associated with the current buffer."
  (interactive)
  (dired default-directory))




(defun get-terminal-fullpath ()
  "Return the path to the installed terminal emulator.

First it will try the tilix terminal emulator. If not installed
it will try gnome-terminal and if that is not installed it will
then try lxterminal."
  (setq terminal (executable-find "tilix"))
  (if (equal terminal nil)
      (setq terminal (executable-find "gnome-terminal")))
  (if (equal terminal nil)
      (setq terminal (executable-find "lxterminal")))
  terminal
  )

(defun gnome-terminal-dir (dir-as-string)
  "Open terminal in the provided directory"
  (start-process-shell-command
   "browse"
   "*scratch*"
   ;; (concat (get-terminal-fullpath) " " (concat "--working-directory \"" (expand-file-name dir-as-string) "\""))
   (concat (get-terminal-fullpath))
   ))

(defun gnome-terminal-default-dir ()
  "Open terminal in the default directory, which is the directory
of the file associated with the current buffer."
  (interactive)
  (gnome-terminal-dir default-directory))



;; Ver PDF
(defun ver-pdf-no-evince (pdf)
  (start-process-shell-command
   "evince"
   "*scratch*"
   (concat "evince " pdf)))


(defun ver-pdf-no-acroread (pdf)
  (start-process-shell-command
   "acroread"
   "*scratch*"
   (concat "acroread " pdf)))

;; You need to have a script called pdfxchange
(defun ver-pdf-no-pdfxchange (pdf)
  (start-process-shell-command
   "pdfxchange"
   "*scratch*"
   (concat "pdfxchange " pdf)))



;; Abrir no OpenOffice
(defun abrir-no-openoffice (documento)
  (start-process-shell-command
   "openoffice"
   "*scratch*"
   (concat "libreoffice.org -o " "\"" documento "\"")))



;; Ver vídeo
(defun ver-arquivo-de-video (video-file)
  (start-process-shell-command
   "vlc"
   "*scratch*"
   (concat "vlc " (surround-with-quotes video-file)))
  )

(defun surround-with-quotes (filename)
  "Surround a given filename with quotes. This is useful to pass that file name to functions to be executed in the shell, since we would have to scape some characters otherwise."
  (message (concat "\"" filename "\""))
  )



;; Run shell command from given folder
(defun run-shell-command-from-folder (command folder)
  "Run a given command from the specified folder."
  (interactive)
  ;; (let (var1)
  ;;   (setq var1 some)

  ;;   )
  (start-process-shell-command
   command
   "*scratch*"
   ;; (concat "/usr/bin/nautilus --no-desktop " (concat "\"" (expand-file-name dir-as-string) "\""))
   (concat "cd " (expand-file-name folder) " && " command)
   )
  )



;; Test if a buffer exists
(defun buffer-exists (bufname)
  (not
   (eq nil (get-buffer bufname))
   )
  )



;; Dictionaries / Synonyms / Wikipedia



;; Wikipedia
(defun lookup-wikipedia ()
  "Look up the word's in Wikipedia.
              This command generates a url for Wikipedia.com and switches you
              to browser. If a region is active (a phrase), lookup that
              phrase."
  (interactive)
  (let (myword myurl)
    (setq myword
          (if (and transient-mark-mode mark-active)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))

    (setq myword (replace-regexp-in-string " " "_" myword))
    (setq myurl (concat "http://en.wikipedia.org/wiki/" myword))
    (browse-url myurl)
    ))


;; Check system type (Linux or Windows)
;; Check if system is GNU/Linux
(defun system-type-is-linux ()
  (interactive)
  "Return true if system"
  (string-equal system-type "gnu/linux")
  )

;; Check if system is Windows
(defun system-type-is-XP ()
  (interactive)
  "Return true if system"
  (string-equal system-type "windows-nt")
  )



;; whitespace <-> Underline
(defun darlan/change-to-space (arg)
  "Remove underline e substitui por um espaço"
  (replace-regexp-in-string "_" " " arg))

(defun darlan/change-to-underline (arg)
  "Remove um espaço e substitui por um underline"
  (replace-regexp-in-string " " "_" arg))

(defun darlan/change-to-label (start end)
  "Remove os espaços e muda para lower case. Isso é útil para transformar um caption de uma figura em algo útil para o label dela, por exemplo"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (search-forward " " nil t) (replace-match "_" nil t))

      ;; Ate aqui já substituiu espaços por underlines. Agora vamos colocar em lowercase
      (let ((label (downcase (buffer-substring-no-properties start end))))
        (delete-region start end)
        (goto-char (point-min))
        (insert label)
        )
      )
    )
  )



;; Find duplicated words in a buffer
(defun darlan/find-duplicated-words ()
  "Search forward for for a duplicated word."
  (interactive)
  (message "Searching for for duplicated words ...")
  (push-mark)
  ;; This regexp is not perfect
  ;; but is fairly good over all:
  (if (re-search-forward
       "\\b\\([^@ \n\t]+\\)[ \n\t]+\\1\\b" nil 'move)
      (message "Found duplicated word.")
    (message "End of buffer")))



;; ;; Autoremote
;; ;; This will read the file "my-autoremote-key.el.gpg", which define the
;; ;; variable 'my-cellphone-autoremote-key' and set my autoremote key (a
;; ;; string) to it.
;; ;;
;; ;; Note that I have disabled reading gpg files during emacs initialization
;; ;; to increese initialization time. Thus, we run this in after-init-hook
;; (add-hook 'after-init-hook
;;           '(lambda ()
;;              (load-file "~/.emacs.d/my-autoremote-key.el.gpg")
;;              ))

;; ;; org-link-escape is used to "urlify" the message
;; ;; url-retrieve-synchronously is used to send the autoremote request
;; (defun darlan/send-region-to-moto-x-cellphone-clipboard (start end)
;;   "Send text to Moto X clipboard through Autoremote"
;;   (interactive "r")
;;   (let (mensagem)
;;     (if (and transient-mark-mode
;;              mark-active)
;;         (progn (setq start (region-beginning) end (region-end))
;;                (setq mensagem (buffer-substring start end))
;;                )
;;       (setq mensagem (read-from-minibuffer "Texto para enviar: "))
;;       )
;;     (url-retrieve-synchronously
;;      (concat (concat "http://autoremotejoaomgcd.appspot.com/sendmessage?key=" my-cellphone-autoremote-key "&message=copy=:=" mensagem) "&ttl=30")
;;      )))



;; Get a safe filename from a string
;; These two functions were obtained from
;; https://lists.gnu.org/archive/html/help-gnu-emacs/2012-07/msg00146.html
;; I renamed them only to make it easier to find them with smex and change
;; them to interactive
(defun darlan/alphanumericp (ch)
  (find ch "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"))


(defun darlan/clean-filename (name)
  (interactive "sNome ")
  (setq m(remove-if-not (lambda (ch) (or (darlan/alphanumericp ch) (find ch "-_.")))
                        (substitute ?- 32 name)))
  (message m)
  )
