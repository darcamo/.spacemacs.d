;;; packages.el --- darcamo-references layer packages file for Spacemacs.
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
;; added to `darcamo-references-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-references/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-references/pre-init-PACKAGE' and/or
;;   `darcamo-references/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-references-packages
  '(
    ;; interleave
    org-noter
    )
  "The list of Lisp packages required by the darcamo-references layer.

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


;; (defun darcamo-references/init-interleave ()
;;   (use-package interleave
;;     :ensure t
;;     )
;;   )

;; Key-bindings for Interleave Package
;; |-------+---------------------------------------------+--------------------|
;; | Key   | Description                                 | Availability       |
;; |-------+---------------------------------------------+--------------------|
;; | n     | Go to next page                             | PDF Buffer         |
;; | p     | Go to previous page                         | PDF Buffer         |
;; | SPC   | Scroll up                                   | PDF Buffer         |
;; | S-SPC | Scroll down                                 | PDF Buffer         |
;; | DEL   | Scroll down                                 | PDF Buffer         |
;; | i     | Insert new notes/go to notes                | PDF Buffer         |
;; | q     | Quit interleave-mode                        | PDF Buffer         |
;; | M-.   | Go to page of currently visible notes       | PDF and Org Buffer |
;; | M-p   | Go to the page of the previous set of notes | PDF and Org Buffer |
;; | M-n   | Go to the page of the next set of notes     | PDF and Org Buffer |
;; |-------+---------------------------------------------+--------------------|


(defun darcamo-references/init-org-noter ()
  (use-package org-noter
    :ensure t
    :defer t
    :config
    (setq org-noter-default-notes-file-names '("articles.org"))
    )
  )



;;; packages.el ends here
