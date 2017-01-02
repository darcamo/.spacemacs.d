;; Normalmente isso não é necessário, já que o emacs pega o locale do
;; sistema quando essa variável não é setada. No entanto como estou com o
;; laptop em francês é melhor setar aqui para deixar as datas do org-mode
;; em português mesmo no laptop.
(setq system-time-locale "pt_BR.UTF-8")

;; Make Emacs use UTF-8 in files, filenames, terminal, etc..
(set-language-environment 'UTF-8)
