;;; packages.el --- darcamo-ycmd layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Darlan cavalcante Moreira <darcamo@gmail.com>
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
;; added to `darcamo-ycmd-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-ycmd/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-ycmd/pre-init-PACKAGE' and/or
;;   `darcamo-ycmd/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-ycmd-packages
  '(
    deferred
    request-deferred
    ycmd
    company-ycmd
    flycheck-ycmd
    ;;ycmd-eldoc
    )
  "The list of Lisp packages required by the darcamo-ycmd layer.

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

(defun darcamo-ycmd/init-deferred()
  (use-package deferred
    :ensure t)
  )

(defun darcamo-ycmd/init-request-deferred()
  (use-package request-deferred
    :ensure t)
  )

(defun darcamo-ycmd/init-ycmd()
  (add-to-list 'load-path "/home/darlan/Programas_Locais/emacs-ycmd")
  (require 'ycmd)

  (set-variable 'ycmd-server-command '("python" "/home/darlan/Programas_Locais/ycmd/ycmd"))
  (add-hook 'c++-mode-hook 'ycmd-mode)
  )

(defun darcamo-ycmd/init-company-ycmd()
  (use-package company-ycmd
    :ensure t
    :config
    (company-ycmd-setup)
    (add-hook 'c++-mode-hook 'company-ycmd-setup))
  )

(defun darcamo-ycmd/init-flycheck-ycmd()
  (use-package flycheck-ycmd
    :ensure t
    :config
    (flycheck-ycmd-setup)
    (add-hook 'c++-mode-hook 'flycheck-ycmd-setup))
  )


;; (defun darcamo-ycmd/init-ycmd-eldoc()
;;   (require 'ycmd-eldoc)
;;   (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup)
;;   )
