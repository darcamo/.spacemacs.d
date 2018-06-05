(defun darcamo-set-c-mode-common-keybindings ()
  (local-set-key [M-f9] 'darlan-save-and-compile) ;; Ask for the target name and compile it
  (local-set-key [f9] 'darlan-save-and-compile-last-target)  ;; Recompile the last target
  (local-set-key [f10] 'darlan-run-last-target)
  (local-set-key [M-f10] 'darlan-run-last-target-with-arguments)
  (local-set-key [C-f9] 'darlan-save-and-compile-single-file)  ;; Compile only the current source file
  (local-set-key [S-f9] 'darlan-generate-documentation)  ;; Generate the doxygen documentation
  (local-set-key [C-S-f9] 'darlan-open-doxygen-generated-index)
  (local-set-key (kbd "M-n") 'highlight-symbol-next)
  (local-set-key (kbd "M-p") 'highlight-symbol-prev)
  )

(add-hook 'c-mode-common-hook 'darcamo-set-c-mode-common-keybindings)
