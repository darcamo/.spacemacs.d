;; Define a jupyter notebook mode derived from javascript mode
(define-derived-mode jupyter-notebook-mode
  javascript-mode "Jupyter-Notebook-Mode"
  ;; Functions and definitions for derived mode

  ;; I don't want to modify the file manually by mistake. Let's start in
  ;; read-only mode
  (read-only-mode)

  ;; TODO: Add code for imenu to inputs and outputs
  )


;; Tell Emacs to open files with the extension .ipynb jupyter-notebook-mode
(add-to-list 'auto-mode-alist '("\.ipynb$" . jupyter-notebook-mode))
