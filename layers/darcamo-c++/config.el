;; (setq c-c++-enable-clang-support t)

;; ;; Open .h files in C++ mode by default
;; (setq-default dotspacemacs-configuration-layers
;;               '((c-c++ :variables
;;                        c-c++-default-mode-for-headers 'c++-mode)))


;; ;; When compiling you can pass a numeric argument to compile in parallel
;; Add this as a directory variable in the project
;; (set-default 'helm-make-build-dir "cmake-build-debug")


;; If the indentation is wrong at some place, put the cursor there and use "C-c
;; C-o" to find-out the offset and the name of the syntactical element under the
;; cursor. Example: put the cursor in the "{" in a function definition and use
;; "C-c C-o". Emacs will tell that the syntactical element is "defun-open". Now,
;; see the help for the c-offsets-alist variable and look for defun-open to see
;; what it is. Using this you can known how to adapt a style to your needs.
;;
;; Copied stroustrup style add add the "innamespace . 0"
(c-add-style "darcamo"
             '((c-doc-comment-style . javadoc)
               (c-basic-offset . 4)
               (c-comment-only-line-offset . 0)
               (c-offsets-alist
                (statement-block-intro . +)
                (substatement-open . 0)
                (substatement-label . 0)
                (label . 0)
                (statement-cont . +)
                (innamespace . 0))))

;; Set default style to stroustrup
(with-eval-after-load 'cc-vars
  (push '(c-mode . "darcamo") c-default-style)
  (push '(c++-mode . "darcamo") c-default-style)
  )
