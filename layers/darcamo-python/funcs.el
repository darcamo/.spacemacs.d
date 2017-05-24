

;; Pegue em http://wwwx.cs.unc.edu/~gb/wp/blog/2008/03/15/running-python-from-within-emacs/
;; Com essa função você pode rodar um script python usando o compile buffer
;; (make-local-variable 'py-master-file)
(defun my-python-compile ()
  "Use compile to run python programs. If the py-master-file variable is set, run that file. If not, run the file associated with the current buffer."
  (interactive)
  (save-buffer)
  (setq python-command-with-options "python -W ignore ")
  (if ; If the variable py-master-file exists we are using python-mode.el
      (boundp 'py-master-file)
      (if ; In that case, we will run the file pointed by py-master-file or
          ; the file associated with the current buffer
          (eq py-master-file nil)
          (compile (concat python-command-with-options (buffer-file-name)) nil)
        (compile (concat python-command-with-options py-master-file) nil)
        )
    ;; If py-master-file does not exist we are using the default python.el
    ;; from emacs and we will run the file associated with the current
    ;; buffer
    (compile (concat python-command-with-options (buffer-file-name)) nil)
    ))



;; Open IPython and IPython Qt Console in the current folder

(defun ipython-terminal-dir (dir-as-string)
  (start-process-shell-command
   "browse"
   "*scratch*"
   (concat "/usr/bin/gnome-terminal --working-directory " (concat "\"" (expand-file-name dir-as-string) "\"" " -e ipython")))
  )

(defun ipython-terminal-default-dir ()
  "Open ipython terminal in the default directory, which is the
directory of the file associated with the current buffer."
  (interactive)
  (ipython-terminal-dir default-directory))

(defun ipython-qtconsole-dir (dir-as-string)
  (message (concat "cd " (concat "" (expand-file-name dir-as-string) "" " && /usr/bin/ipython qtconsole")))
  (start-process-shell-command
   "browse"
   "*scratch*"
   ;; (concat "cd " (concat "\"" (expand-file-name dir-as-string) "\"" " && \"/usr/bin/ipython\""))
   (concat "cd " (concat "" (expand-file-name dir-as-string) "" " && /usr/bin/ipython qtconsole"))
   )
  )

(defun ipython-qtconsole-default-dir ()
  "Open ipython qtconsole in the default directory, which is the
directory of the file associated with the current buffer."
  (interactive)
  (ipython-qtconsole-dir default-directory))



;; Debug helpers

(defun python--add-debug-highlight ()
  "Adds a highlighter for use by `python--pdb-breakpoint-string'"
  (highlight-lines-matching-regexp "## DEBUG ##\\s-*$" 'hi-red-b)
  )

(add-hook 'python-mode-hook 'python--add-debug-highlight)

(defvar python--pdb-breakpoint-string "import pudb; pudb.set_trace()  ## DEBUG ##"
  "Python breakpoint string used by `python-insert-breakpoint'")

(defun python-insert-breakpoint ()
  "Inserts a python breakpoint using `pdb'"
  (interactive)
  (back-to-indentation)
  ;; this preserves the correct indentation in case the line above
  ;; point is a nested block
  (split-line)
  (insert python--pdb-breakpoint-string))

(defadvice compile (before ad-compile-smart activate)
  "Advises `compile' so it sets the argument COMINT to t
if breakpoints are present in `python-mode' files"
  (when (derived-mode-p major-mode 'python-mode)
    (save-excursion
      (save-match-data
        (goto-char (point-min))
        (if (re-search-forward (concat "^\\s-*" python--pdb-breakpoint-string "$")
                               (point-max) t)
            ;; set COMINT argument to `t'.
            (ad-set-arg 1 t))))))

;; Add breakpoints in pudb
(setq pudb-bp-file (expand-file-name "~/.config/pudb/saved-breakpoints-2.7"))
(defun pudb-add-breakpoint ()
  (interactive)
  (append-to-file
   (concat "b " buffer-file-name ":"
           (nth 1 (split-string (what-line))) "\n")
   nil pudb-bp-file))
