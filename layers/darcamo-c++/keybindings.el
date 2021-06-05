(with-eval-after-load 'cc-mode
  (define-key c++-mode-map [M-f9] 'darlan-save-and-compile) ;; Ask for the target name and compile it
  (define-key c++-mode-map [f9] 'darlan-save-and-compile-last-target)  ;; Recompile the last target
  (define-key c++-mode-map [f10] 'darlan-run-last-target)
  (define-key c++-mode-map [M-f10] 'darlan-run-last-target-with-arguments)
  (define-key c++-mode-map [C-f9] 'darlan-save-and-compile-single-file)  ;; Compile only the current source file
  (define-key c++-mode-map [S-f9] 'darlan-generate-documentation)  ;; Generate the doxygen documentation
  (define-key c++-mode-map [C-S-f9] 'darlan-open-doxygen-generated-index)

  ;; Enable key bindings (M-p and M-p) for navigation
  (add-hook 'c-mode-hook 'highlight-symbol-nav-mode)
  )

(with-eval-after-load 'cmake-mode
  (define-key cmake-mode-map [M-f9] 'darlan-save-and-compile) ;; Ask for the target name and compile it
  (define-key cmake-mode-map [f9] 'darlan-save-and-compile-last-target)  ;; Recompile the last target
  (define-key cmake-mode-map [f10] 'darlan-run-last-target)
  (define-key cmake-mode-map [M-f10] 'darlan-run-last-target-with-arguments)
  (define-key cmake-mode-map [C-f9] 'darlan-save-and-compile-single-file)  ;; Compile only the current source file
  (define-key cmake-mode-map [S-f9] 'darlan-generate-documentation)  ;; Generate the doxygen documentation
  (define-key cmake-mode-map [C-S-f9] 'darlan-open-doxygen-generated-index)

  ;; Enable key bindings (M-p and M-p) for navigation
  (add-hook 'c++-mode-hook 'highlight-symbol-nav-mode)
  )
