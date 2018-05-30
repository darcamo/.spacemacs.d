;;; packages.el --- darcamo-cquery layer packages file for Spacemacs.
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
;; added to `darcamo-cquery-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-cquery/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-cquery/pre-init-PACKAGE' and/or
;;   `darcamo-cquery/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-cquery-packages
  '(
    lsp-mode
    cquery
    company-lsp
    lsp-ui
    )
  "The list of Lisp packages required by the darcamo-cquery layer.

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

(defun darcamo-cquery/init-lsp-mode ()
  (use-package lsp-mode
    :ensure t)
  )

(defun cquery//enable ()
  (condition-case nil
      (lsp-cquery-enable)
    (user-error nil)))

(defun darcamo-cquery/init-cquery ()
  (use-package cquery
    :ensure t
    :commands lsp-cquery-enable
    :init (add-hook 'c-mode-common-hook #'cquery//enable)
    :config
    (setq cquery-executable "/usr/bin/cquery")
    (setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack"))

    ;; Semantic highlight
    (setq cquery-sem-highlight-method 'font-lock)
    ;; (cquery-use-default-rainbow-sem-highlight)

    (with-eval-after-load 'projectile
      (setq projectile-project-root-files-top-down-recurring
            (append '("compile_commands.json"
                      ".cquery")
                    projectile-project-root-files-top-down-recurring))
      (add-to-list 'projectile-globally-ignored-directories ".cquery_cached_index"))
    )
  )

(defun darcamo-cquery/init-company-lsp ()
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

      ;; (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)
      )
    )
  )

(defun darcamo-cquery/init-lsp-ui ()
  (use-package lsp-ui
    :ensure t
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    (setq lsp-ui-doc-include-signature t)
    (setq lsp-ui-sideline-show-symbol t)
    )
  )

;;; packages.el ends here
