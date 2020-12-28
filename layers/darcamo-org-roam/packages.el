;;; packages.el --- darcamo-org-roam layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Darlan Cavalcante Moreira <darlan@darlan-desktop>
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
;; added to `darcamo-org-roam-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-org-roam/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-org-roam/pre-init-PACKAGE' and/or
;;   `darcamo-org-roam/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-org-roam-packages
  '(
    org-roam-bibtex
    org-roam-server)
  "The list of Lisp packages required by the darcamo-org-roam layer.

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

(defun darcamo-org-roam/init-org-roam-server ()
  (use-package org-roam-server
    :ensure t
    :defer t
    :bind ([f6] . org-roam-find-file)
    :config
    (message "darcamo-org-roam carregado")
    (setq org-roam-server-host "127.0.0.1"
          org-roam-server-port 8080
          org-roam-server-export-inline-images t
          org-roam-server-authenticate nil
          org-roam-server-network-arrows nil
          org-roam-server-network-label-truncate t
          org-roam-server-network-label-truncate-length 60
          org-roam-server-network-label-wrap-length 20
          )
    ))

(defun darcamo-org-roam/init-org-roam-bibtex ( )
  (use-package org-roam-bibtex
    :ensure t
    :after org-roam
    :defer t
    :hook (org-roam-mode . org-roam-bibtex-mode)
    )
  )

;;; packages.el ends here
