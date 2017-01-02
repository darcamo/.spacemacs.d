;; Helper functions used in some yasnippets snippets

;; Provides some useful functions, including 'string-utils-trim-whitespace' which is used in ,y "insert-comment-block-end" function.
;; (use-package string-utils
;;   :ensure t)

;; This method is used in the 'comment' yasnippets template
(defun darlan/get-comment-block-start ()
  "Insert the correct comment start string for a block comment.
  This method is used in the 'comment' yasnippets template."
  (interactive)
  (if (equal ";" comment-start)
      ;; For emacs-lisp mode, we want two ';' symbols.
      ";;"
    ;; For all the other major modes, the line below inserts the correct
    ;; comment-start.
    (string-utils-trim-whitespace comment-start)
    )
  )

;; This method is used in the 'comment' yasnippets template
(defun darlan/get-comment-block-end ()
  "Insert the correct comment end string for a block comment.
  This method is used in the 'comment' yasnippets template."
  (interactive)
  (string-utils-trim-whitespace comment-end)
  )



;; Fill with comment
(defun fill-with-comment(&optional character)
  "Insert as many comment characters as necessary to go untill
      fill-column."
  (interactive)
  (when (null character)
    (setq character "x"))
  (let (current beginning)
    (delete-horizontal-space)
    (setq current (point))
    (beginning-of-line)
    (setq beginning (point))
    (goto-char current)

    (setq number (- fill-column (- current beginning)))

    (if (not (= current beginning))
        (progn
          (insert " ")
          (setq number (- number 1)))
      )
    (setq character (string-to-char character))
    (insert-char character number )
    )
  )



;; Get user name and e-mail address
(defun darlan/get-user-name-and-email ()
  "Get the user full name and e-mail address from the variables
      'user-full-name' and 'user-mail-address'. This is useful for
      yasnippets. You can use this function in your snippets and if you
      need to change the email address for a project, for example, just
      change the variable 'user-mail-address' in a file variable or a
      directory variable, instead of changing the snippets."
  (interactive)
  (concat user-full-name " <" user-mail-address ">")
  )


