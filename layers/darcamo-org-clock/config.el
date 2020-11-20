(require 'org-clock)

(with-eval-after-load 'org-clock
  ;; Change task state to STARTED when clocking in
  (setq org-clock-in-switch-to-state 'my-clock-change-state)

  ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)

  ;; When equal to "t", the current clocked task is included in clock reports
  (setq org-clock-report-include-clocking-task t)
  )
