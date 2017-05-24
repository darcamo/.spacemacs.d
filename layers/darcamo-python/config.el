(defun my-python-mode-hook ()
  ;; Run the program in the compilation buffer
  (local-set-key [f9] 'my-python-compile)
  (local-set-key [S-f9] 'kill-compilation))

(add-hook 'python-mode-hook 'my-python-mode-hook)


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "<C-f11>") 'ipython-terminal-default-dir)
            (local-set-key (kbd "<M-f11>") 'ipython-qtconsole-default-dir)
            ))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key [C-f8] 'python-insert-breakpoint)
            (local-set-key [C-S-f8] 'pudb-add-breakpoint)
            ))
