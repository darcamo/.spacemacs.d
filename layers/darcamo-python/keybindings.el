
;; Add breakpoint with pudb
(define-key python-mode-map [C-f8] 'python-insert-breakpoint)
(define-key python-mode-map [C-S-f8] 'pudb-add-breakpoint)

;; Open ipython terminal
(define-key python-mode-map [C-f11] 'ipython-terminal-default-dir)
(define-key python-mode-map [M-f11] 'ipython-qtconsole-default-dir)

;; Run a python file
(define-key python-mode-map [f9] 'my-python-compile)
(define-key python-mode-map [S-f9] 'kill-compilation)
