;; Pegue de Dan Davidson
;; [[wl:%Org-Mode:"darcamo@gmail.com"/clear@imap.gmail.com:993!#8739yzuyac.fsf@stats.ox.ac.uk][Email from Dan Davison: Re: {Orgmode} Embedding org-sy]]

(defun darlan/set-up-outline-minor-mode (local-outline-regexp)
  "Set the outline-regex to local-outline-regexp"
  (set (make-local-variable 'outline-regexp) local-outline-regexp)
  (outline-minor-mode t)
  )
