;;; packages.el --- darcamo-mu4e layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
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
;; added to `darcamo-mu4e-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-mu4e/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-mu4e/pre-init-PACKAGE' and/or
;;   `darcamo-mu4e/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-mu4e-packages
  '(mu4e-jump-to-list
    org-msg
    mu4e-views
    )
  "The list of Lisp packages required by the darcamo-mu4e layer.

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

(defun darcamo-mu4e/init-mu4e-jump-to-list ()
  ;; allows to select and view mailing lists automatically using existing
  ;; List-ID headers in your mu database.
  ;;
  ;; Just press "l" in the headers view and any mailing list you've subscribed
  ;; to will be automatically discovered and presented in recency order. No
  ;; setup or refiling necessary.
  (use-package mu4e-jump-to-list
    :ensure t)
  )

(defun darcamo-mu4e/init-org-msg ()
  ;; allows to select and view mailing lists automatically using existing
  ;; List-ID headers in your mu database.
  ;;
  ;; Just press "l" in the headers view and any mailing list you've subscribed
  ;; to will be automatically discovered and presented in recency order. No
  ;; setup or refiling necessary.
  (use-package org-msg
    :ensure t
    :config
    (setq
     org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil tex:dvipng \\n:t"
	 org-msg-startup "hidestars indent inlineimages"
	 org-msg-greeting-fmt "\nHi *%s*,\n\n"
	 org-msg-greeting-name-limit 3
	 org-msg-text-plain-alternative t
	 org-msg-signature "

 Regards,

 #+begin_signature
 -- *Darlan* \\\\
 #+end_signature")
    (org-msg-mode)
    )
  )

(defun darcamo-mu4e/init-mu4e-views ()
  (use-package mu4e-views
    :ensure t
    :after mu4e
    :defer nil
    :bind (:map mu4e-headers-mode-map
	            ("v" . mu4e-views-mu4e-select-view-msg-method) ;; select viewing method
	            ("M-n" . mu4e-views-cursor-msg-view-window-down) ;; from headers window scroll the email view
	            ("M-p" . mu4e-views-cursor-msg-view-window-up) ;; from headers window scroll the email view
                ("f" . mu4e-views-toggle-auto-view-selected-message) ;; toggle opening messages automatically when moving in the headers view
	            )
    :config
    (setq mu4e-views-completion-method 'ivy) ;; use ivy for completion
    (setq mu4e-views-default-view-method "html") ;; make xwidgets default
    (mu4e-views-mu4e-use-view-msg-method "html") ;; select the default
    (setq mu4e-views-next-previous-message-behaviour 'stick-to-current-window) ;; when pressing n and p stay in the current window
    (setq mu4e-views-auto-view-selected-message t)
    )
  )


;;; packages.el ends here
