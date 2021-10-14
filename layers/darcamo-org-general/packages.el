;;; packages.el --- darcamo-org-general layer packages file for Spacemacs.
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
;; added to `darcamo-org-general-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-org-general/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-org-general/pre-init-PACKAGE' and/or
;;   `darcamo-org-general/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-org-general-packages
  '(
    ;; org-special-block-extras
    )
  "The list of Lisp packages required by the darcamo-org-general layer.

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


;; (defun darcamo-org-general/init-org-special-block-extras ( )
;;   (use-package org-special-block-extras
;;     :ensure t
;;     :hook (org-mode . org-special-block-extras-mode)
;;     ;; :custom
;;     ;; (org-special-block-extras--docs-libraries
;;     ;;  '("~/org-special-block-extras/documentation.org")
;;     ;;  "The places where I keep my ‘#+documentation’")
;;     ;; ;; (org-special-block-extras-fancy-links
;;     ;; ;; nil "Disable this feature.")
;;     :config
;;     ;; Use short names like ‘defblock’ instead of the fully qualified name
;;     ;; ‘org-special-block-extras--defblock’
;;     ;; (org-special-block-extras-short-names)
;;     )
;;   )

;;; packages.el ends here
