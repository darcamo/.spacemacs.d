(defun latex-skeleton-ac (acronym)
  "Ask for an acronym and inserts \\ac{acronym}. You probably want to call latex-skeleton-acronym instead."
  (interactive "MAcronym: ")
  (insert "\\ac{" acronym "}"))

(defun latex-skeleton-acronym ()
  "Surround current word with \\ac{} if mark is active of prompts for an acronym and insert \ac{acronym}."
  (interactive)
  (let (pos1 pos2 acronym)
    (if (and transient-mark-mode
             mark-active)
        (progn (setq pos1 (region-beginning) pos2 (region-end))
               (setq acronym (buffer-substring pos1 pos2))
               (delete-region pos1 pos2)
               (goto-char pos1)
               (insert "\\ac{" acronym "\}")
               )
      (latex-skeleton-ac (read-from-minibuffer "Acronym: "))
      )))


(defun latex-skeleton-math-left-right ( left-symbol right-symbol)
  "Inserts \"\\left left-symbol \\right right-symbol\" and the cursor will be between \"\\left-symbol and \\right\"."
  (let ((region "") pos)
    (insert "\\left " left-symbol " ")
    (setq pos (point))
    (insert " " region " \\right " right-symbol)
    (goto-char pos))
  )

(defun latex-skeleton-math-left-right-symbol ()
  "Inserts \"\left left-symbol \right right-symbol\". If mark is active surround
  the active region with it."
  (interactive)
  (let (left-symbol right-symbol pos1 pos2 region)
    (setq left-symbol (read-from-minibuffer "Left Symbol: ")
          right-symbol (read-from-minibuffer "Right Symbol: "))

    (if (and transient-mark-mode
             mark-active)
        (progn (setq pos1 (region-beginning) pos2 (region-end))
               (setq region (buffer-substring pos1 pos2))
               (delete-region pos1 pos2)
               (goto-char pos1)
               (latex-skeleton-math-left-right left-symbol right-symbol)
               (insert region)
               )
      (latex-skeleton-math-left-right left-symbol right-symbol))
    ))





;; Function to run latex on the master file
(defun tex-all (arg)
  "Compile the latex file (or its master).

This will either run latex/build from spacemacs layer, or
TeX-command-master (from auctex) with a 'Latex' argument."
  (interactive "P")
  (if (fboundp 'latex/build)
      ;; If the function latex/build exist (it is defined in spacemacs LaTeX
      ;; layer) then we use it to compile our latex file
      (latex/build)
    ;; If the function latex/build does not exist then we use standard Auctex
    ;; functions and variables
    (let ((TeX-command-force "Latex"))
      ;;(TeX-save-document (TeX-master-file))
      (basic-save-buffer)
      (TeX-command-master arg)
      )
    )
  )

(defun my-latex-textcolor-red ()
  "Surround current region with \textcolor{red}{ } if mark is active or prompts for a text and insert \textcolor{red}{acronym}."
  (interactive)
  (let (pos1 pos2 text)
    (if (and transient-mark-mode
             mark-active)
        (my-latex-surround-textcolor-red (region-beginning) (region-end))
      (insert "\\textcolor{red}{" (read-from-minibuffer "Text in red: ") "}")
      )))

(defun my-latex-surround-textcolor-red (beg end)
  "Surround the region with \textcolor{red}{ }"
  (interactive "r")
  (save-restriction
    (narrow-to-region beg end)
    (goto-char (point-min))
    (insert "\\textcolor{red}{")
    (goto-char (point-max))
    (insert "}")))

;; Bound this to S-M-return
(defun dar/LaTeX-insert-item-inverse-behavior ()
  "Similar to LaTeX-insert-item, but reverse the behavior of the
        LaTeX-beamer-item-overlay-flag variable. That is if
        LaTeX-beamer-item-overlay-flag is t then LaTeX-insert-item will
        ask for an overlay specifications, while
        LaTeX-insert-item-inverse-behavior will not and vice-versa."
  (interactive)
  ;; We only want to change LaTeX-beamer-item-overlay-flag locally in the
  ;; dar/LaTeX-insert-item-inverse-behavior function
  (let (LaTeX-beamer-item-overlay-flag (not LaTeX-beamer-item-overlay-flag))
    (LaTeX-insert-item))
  )
