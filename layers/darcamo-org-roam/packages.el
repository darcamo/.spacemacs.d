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
  '(org-roam
    company-org-roam
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


(defun darcamo-org-roam/init-org-roam ()
  (use-package org-roam
    :hook
    (after-init . org-roam-mode)
    :custom
    (org-roam-directory "/home/darlan/org/org-roam-notes/")
    :init
    (progn
      (spacemacs/declare-prefix "ar" "org-roam")
      (spacemacs/set-leader-keys
        "arl" 'org-roam
        "art" 'org-roam-dailies-today
        "arf" 'org-roam-find-file
        "arg" 'org-roam-graph
        "arj" 'org-roam-jump-to-index)

      (spacemacs/declare-prefix-for-mode 'org-mode "mr" "org-roam")
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "rl" 'org-roam
        "rt" 'org-roam-dailies-today
        "rb" 'org-roam-switch-to-buffer
        "rf" 'org-roam-find-file
        "ri" 'org-roam-insert
        "rg" 'org-roam-graph
        "rj" 'org-roam-jump-to-index)

      (setq org-roam-capture-templates '(
                                         ("d" "default" plain #'org-roam-capture--get-point "%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+SETUPFILE: ~/.spacemacs.d/org-mode-setup/org-roam-setup.org\n\n" :unnarrowed t)
                                         ("D" "Doutorado" plain #'org-roam-capture--get-point "%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+SETUPFILE: ~/.spacemacs.d/org-mode-setup/org-roam-setup.org\n#+ROAM_TAGS: §Doutorado\n\n- Links :: [[file:20200623165210-doutorado.org][Doutorado]]\n\n" :unnarrowed t)
                                         )
            org-roam-graph-exclude-matcher "index.org"
            org-roam-graph-extra-config '(("rankdir" . "LR"))  ; Default is top-down but left-right works better
            )

      (use-package org-roam-protocol :after org-roam)
      ))
  )

(defun darcamo-org-roam/init-company-org-roam ()
  (use-package company-org-roam
    ;; :straight (:host github :repo "org-roam/company-org-roam")
    :ensure t
    :config
    (push 'company-org-roam company-backends))
  )


(defun darcamo-org-roam/init-org-roam-server ()
  (use-package org-roam-server
    :ensure t
    :bind ([f6] . org-roam-find-file)
    :config
    (setq org-roam-server-host "127.0.0.1"
          org-roam-server-port 8080
          org-roam-server-export-inline-images t
          org-roam-server-authenticate nil
          org-roam-server-network-arrows nil
          org-roam-server-network-label-truncate t
          org-roam-server-network-label-truncate-length 60
          org-roam-server-network-label-wrap-length 20
          ))
  )


;;; packages.el ends here
