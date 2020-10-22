;;; packages.el --- darcamo-calibre layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
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
;; added to `darcamo-calibre-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-calibre/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-calibre/pre-init-PACKAGE' and/or
;;   `darcamo-calibre/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-calibre-packages
  '(
    calibredb
    )
  "The list of Lisp packages required by the darcamo-calibre layer.

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

(defun darcamo-calibre/init-calibredb ( )
  (use-package calibredb
    :ensure t
    :config
    (setq calibredb-root-dir "~/Dropbox/Calibre Library")
    (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
    (setq calibredb-size-show t)  ;; Show the file size of each book
    (setq calibredb-format-all-the-icons t) ;; show file format icons with all-the-icons

    ;; Org-ref support: https://github.com/chenyanming/calibredb.el#configure-to-support-org-ref
    (setq calibredb-ref-default-bibliography (concat (file-name-as-directory calibredb-root-dir) "catalog.bib"))
    (with-eval-after-load 'org-ref
      (add-to-list 'org-ref-default-bibliography calibredb-ref-default-bibliography)
      (setq org-ref-get-pdf-filename-function 'org-ref-get-mendeley-filename)
      )
    )
  )

;;; packages.el ends here
