;;; packages.el --- darcamo-rtags layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Darlan Cavalcante Moreira <darcamo@gmail.com>
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
;; added to `darcamo-rtags-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-rtags/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-rtags/pre-init-PACKAGE' and/or
;;   `darcamo-rtags/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-rtags-packages
  '(;;cmake-ide
    rtags
    helm-rtags
    company-rtags
    flycheck-rtags)
  "The list of Lisp packages required by the darcamo-rtags layer.

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


;; (defun darcamo-rtags/init-cmake-ide ()
;;   (use-package cmake-ide
;;     :config
;;     (cmake-ide-setup)))

(defun darcamo-rtags/init-rtags ()
  (add-to-list 'load-path "/home/darlan/Programas_Locais/rtags/src")
  ;; (require 'rtags)
  (use-package rtags
    :pin manual
    :config
    (setq rtags-autostart-diagnostics t
          rtags-completions-enabled t
          ;; rtags-use-helm t
          )
    (rtags-enable-standard-keybindings)
    (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
    (add-hook 'c++-mode-common-hook 'rtags-start-process-unless-running)
    (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
    )
  )

(defun darcamo-rtags/init-helm-rtags ()
  ;; (require 'helm-rtags)
  (use-package helm-rtags
    :pin manual)
  )

(defun darcamo-rtags/init-flycheck-rtags ()
  ;; (require 'flycheck-rtags)
  (use-package flycheck-rtags
    :pin manual)
  )

(defun darcamo-rtags/init-company-rtags ()
  (with-eval-after-load 'company
    ;; (require 'company-rtags)

    ;; (add-hook 'c++-mode-hook
    ;;           (lambda ()
    ;;             (set (make-local-variable 'company-backends) '(company-rtags))))
    ;; (add-hook 'c-mode-common-hook
    ;;           (lambda ()
    ;;             (set (make-local-variable 'company-backends) '(company-rtags))))
    (use-package company-rtags
      :pin manual
      :config
      (add-hook 'c++-mode-hook
                (lambda ()
                  (set (make-local-variable 'company-backends) '(company-rtags))))
      (add-hook 'c-mode-common-hook
                (lambda ()
                  (set (make-local-variable 'company-backends) '(company-rtags)))))
    )
  )

  ;; (use-package rtags
  ;;   :config
  ;;   (setq rtags-autostart-diagnostics t
  ;;         rtags-completions-enabled t
  ;;         rtags-use-helm t)

  ;;   (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
  ;;   (add-hook 'c++-mode-common-hook 'rtags-start-process-unless-running)
                                        ; See https://github.com/Andersbakken/rtags/issues/832
    ;; (use-package helm-rtags :ensure t)
    ;; ;; (push '(company-rtags)
    ;; ;;       company-backends-c-mode-common)
    ;; ;; (push 'company-rtags company-backends)
    ;; (rtags-enable-standard-keybindings)
    ;; (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running))
  ;; (use-package flycheck-rtags
  ;;   :ensure rtags)

  ;; (with-eval-after-load 'company
  ;;   (require 'company-rtags)

  ;;   (add-hook 'c++-mode-hook
  ;;             (lambda ()
  ;;               (set (make-local-variable 'company-backends) '(company-rtags))))
  ;;   (add-hook 'c-mode-common-hook
  ;;             (lambda ()
  ;;               (set (make-local-variable 'company-backends) '(company-rtags))))
  ;;   )
  ;;)


;;; packages.el ends here
