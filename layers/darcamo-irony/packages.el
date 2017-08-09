;;; packages.el --- darcamo-irony layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Darlan cavalcante Moreira <darlan@darlan-VirtualBox>
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
;; added to `darcamo-irony-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-irony/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-irony/pre-init-PACKAGE' and/or
;;   `darcamo-irony/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-irony-packages
  '(
    irony
    company-irony
    company-irony-c-headers
    )
  "The list of Lisp packages required by the darcamo-irony layer.

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

(defun darcamo-irony/init-irony ()
  (use-package irony
    :ensure t
    :diminish irony-mode
    :config
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'objc-mode-hook 'irony-mode)

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

    ;; Clion put the cmake files (including compile_commands.json) into the
    ;; "cmake-build-debug" directory
    (with-eval-after-load 'irony-cdb
      (add-to-list 'irony-cdb-search-directory-list "cmake-build-debug")
      )
    )
  )


(defun darcamo-irony/init-company-irony ()
  (use-package company-irony
    :ensure t
    :config
    ;; (with-eval-after-load 'irony
    ;;   (with-eval-after-load 'company
    ;;     '(add-to-list 'company-backends 'company-irony)
    ;;     ))

    (add-hook 'c++-mode-hook
              (lambda ()
                (set (make-local-variable 'company-backends) '(company-irony))))
    (add-hook 'c-mode-common-hook
              (lambda ()
                (set (make-local-variable 'company-backends) '(company-irony))))
    )
  )


(defun darcamo-irony/init-company-irony-c-headers ()
  (use-package company-irony-c-headers
    :ensure t
    :config
    (eval-after-load 'company
      '(add-to-list
        'company-backends '(company-irony-c-headers company-irony)))
    )
  )

;;; packages.el ends here
