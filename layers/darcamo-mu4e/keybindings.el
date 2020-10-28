
(with-eval-after-load 'mu4e-view
  (define-key mu4e-view-mode-map [home] 'beginning-of-line)
  (define-key mu4e-view-mode-map [end] 'end-of-line)
  )

(with-eval-after-load 'xwidget
  (define-key xwidget-webkit-mode-map (kbd "q") '(lambda () (interactive) (quit-window) (mu4e~view-quit-buffer)))
  )
