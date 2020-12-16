;;; packages.el --- darcamo-org-agenda layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Darlan Cavalcante Moreira <darlan@darlan-G75VX>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `darcamo-org-agenda-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-org-agenda/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-org-agenda/pre-init-PACKAGE' and/or
;;   `darcamo-org-agenda/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-org-agenda-packages
  '(
    org-super-agenda
    )
  "The list of Lisp packages required by the darcamo-org-agenda layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun darcamo-org-agenda/init-org-super-agenda ()
  (use-package org-super-agenda
    :ensure t
    :config
    (setq org-super-agenda-groups '(
                                    (:name "Canceladas"
                                           :todo "CANC"
                                           :order 500)
                                    (:name "Tarefas Concluídas"
                                           :todo "DONE"
                                           ;; :and (:regexp "State \"DONE\""
                                           ;;               )
                                           :face (:foreground "gray40")
                                           :order 1) ;; Any item without order has a value of zero
                                    (
                                     :name "Started"
                                     ;; :time-grid t
                                     :todo "STARTED")
                                    (
                                     :name "Importantes"
                                           :priority "A")
                                    (:name "WAIT"
                                           ;; :time-grid t
                                           :todo "WAIT"
                                           )
                                    (:name "Atrasadas"
                                           :deadline past)
                                    (:name "GTEL"
                                           :category "GTEL"
                                           )
                                    (:name "Estudos"
                                           :category "Estudos"
                                           :order 50)
                                    (:name "Someday"
                                           :tag "Someday"
                                           :order 100
                                           ; :face (:foreground "gray40")
                                           )
                                    (:name "Finanças"
                                           :tag "Finanças"
                                           :order 150
                                           )
                                    (:name "References"
                                           :category "References"
                                           :order 200)
                                    (:auto-category t)
                                    ))
    (setq org-super-agenda-header-separator "")
    (org-super-agenda-mode)
    )
  )

;;; packages.el ends here
