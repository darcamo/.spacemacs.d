;;; packages.el --- darcamo-lsp layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Darlan Cavalcante Moreira <darlan@darlan-notebook>
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
;; added to `darcamo-lsp-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-lsp/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-lsp/pre-init-PACKAGE' and/or
;;   `darcamo-lsp/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-lsp-packages
  '(
    lsp-mode
    company-lsp  ;; Note that company-lsp was dropped in "lsp-mode 7.0"
    lsp-ui
    )
  "The list of Lisp packages required by the darcamo-lsp layer.

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

(defun darcamo-lsp/init-lsp-mode ()
  (use-package lsp-mode
    :ensure t)
  )

(defun darcamo-lsp/init-company-lsp ()
  (with-eval-after-load 'company
    (use-package company-lsp
      :ensure t
      :config
      (add-hook 'c++-mode-hook
                (lambda ()
                  (set (make-local-variable 'company-backends) '(company-lsp))))
      (add-hook 'c-mode-common-hook
                (lambda ()
                  (set (make-local-variable 'company-backends) '(company-lsp))))
      (setq company-lsp-cache-candidates nil)
      (setq company-transformers nil)

      ;; (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)
      )
    )
  )

(defun darcamo-lsp/init-lsp-ui ()
  (use-package lsp-ui
    :ensure t
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    (setq lsp-ui-doc-include-signature t)
    (setq lsp-ui-sideline-show-symbol t)
    (setq lsp-ui-sideline-show-hover nil)  ;; Too much pollution if enabled
    )
  )


;;; packages.el ends here
