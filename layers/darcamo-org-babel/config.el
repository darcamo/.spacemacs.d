

(with-eval-after-load 'org

  ;; General Configuration
  ;; turn-off confirmation when evaluating babel blocks
  (setq org-confirm-babel-evaluate nil)

  ;; If set to t, TAB works natively in code blocks (Deixa o TAB muito lento)
  (setq org-src-tab-acts-natively nil)

  ;; Native font lock for src blocks
  ;;(setq org-src-fontify-natively t)


  ;; Load Languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     ;; (R . nil)
     (ditaa . t)
     ;; (dot . nil)
     (emacs-lisp . t)
     ;; (gnuplot . t)
     (haskell . t)
     ;; (ocaml . nil)
     (python . t)
     ;; ipython can be a better option then standard python
     ;;(ipython . t)
     ;; (C . t)
     ;; (ruby . nil)
     ;; (screen . nil)
     (shell . t)
     ;; (sql . nil)
     ;; (sqlite . nil)
     (octave . t)
     (matlab . t)
     ;; (latex . t)
     ;; (plantuml . t)
     (java . t)
     ))

  ;; Change this to the appropriated jar location
  (setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0.11.jar")
  )

