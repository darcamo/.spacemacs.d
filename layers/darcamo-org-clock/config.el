(require 'org-clock)

(with-eval-after-load 'org-clock
  ;; Change task state to STARTED when clocking in
  (setq org-clock-in-switch-to-state 'my-clock-change-state)

  ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)

  ;; When equal to "t", the current clocked task is included in clock reports
  (setq org-clock-report-include-clocking-task t)
  )


;; Change the color of the mode-line box to "green" when clock-in a task and to
;; "red" when clock-out
(add-hook 'post-command-hook
          (lambda ()
            (let ((color (cond ((org-clocking-p) "green")
                               (t "red"))))
              (set-face-attribute 'mode-line nil :box `(:line-width 1 :color ,color))
              )))
