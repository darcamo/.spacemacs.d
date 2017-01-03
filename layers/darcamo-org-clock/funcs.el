
;; General Configuration
(defun my-clock-change-state (state)
  "If state is 'CYCLIC' return 'CYCLIC'. If it is any other todo keyword return
        'STARTED'. This is useful to set in the variable org-clock-in-switch-to-state."
  (interactive)
  (if (equal state "CYCLIC")
      (message "CYCLIC")
    (message "STARTED")
    )
  )


;; Automaticamente muda uma tarefa para STARTED se uma subtarefa for mudada p/ STARTED
;; Pegue em http://doc.norang.ca/org-mode.html#sec-15-44

;; Mark parent tasks as started
(defvar bh/mark-parent-tasks-started nil)

(defun bh/mark-parent-tasks-started ()
  "Visit each parent task and change TODO states to STARTED"
  (unless bh/mark-parent-tasks-started
    (when (equal org-state "STARTED")
      (let ((bh/mark-parent-tasks-started t))
        (save-excursion
          (while (org-up-heading-safe)
            (when (member (nth 2 (org-heading-components)) (list "TODO" "NEXT"))
              (org-todo "STARTED"))))))))

(add-hook 'org-after-todo-state-change-hook 'bh/mark-parent-tasks-started 'append)
