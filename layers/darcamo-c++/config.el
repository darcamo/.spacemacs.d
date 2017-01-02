;; (setq c-c++-enable-clang-support t)

;; ;; Open .h files in C++ mode by default
;; (setq-default dotspacemacs-configuration-layers
;;               '((c-c++ :variables
;;                        c-c++-default-mode-for-headers 'c++-mode)))


;; ;; When compiling you can pass a numeric argument to compile in parallel
;; Add this as a directory variable in the project
;; (set-default 'helm-make-build-dir "cmake-build-debug")

;; Set default style to stroustrup
(with-eval-after-load 'cc-vars
  (push '(c-mode . "stroustrup") c-default-style)
  (push '(c++-mode . "stroustrup") c-default-style)
  )

;; Note: You can define your own style using "c-add-style" function
;; See this video (https://www.youtube.com/watch?v=OjbkCEkboA8&app=desktop) around 20minutes

;; See the same video around 28 minutes for auto-completion
;; 1 - Install cc_args.py
;; 2 - bla bla
