;;; packages.el --- darcamo-usability layer packages file for Spacemacs.
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
;; added to `darcamo-usability-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `darcamo-usability/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `darcamo-usability/pre-init-PACKAGE' and/or
;;   `darcamo-usability/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst darcamo-usability-packages
  '(
    windmove
    ;; bookmark+
    goto-last-change
    buffer-move
    rainbow-mode
    iedit
    git-gutter
    comment-dwim-2
    discover-my-major
    multiple-cursors
    ace-mc                              ; Ace-Multiple-Cursors
    highlight-symbol
    adaptive-wrap ;; used when visual-line-mode is activated
    focus  ;; Dim the font color of text in surrounding sections when active
    )
  "The list of Lisp packages required by the darcamo-usability layer.

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

(defun darcamo-usability/init-windmove ()
  (windmove-default-keybindings 'shift)
  )

;; (defun darcamo-usability/init-bookmark+ ()
;;   ;; (use-package bookmark+
;;   ;;   :ensure t
;;   ;;   :defer nil)
;;   (require 'bookmark+)
;;   ;; (autoload 'bookmark-bmenu-list "bookmark+.el" nil t)
;;   ;; (autoload 'bookmark-set "bookmark+.el" nil t)
;;   )

;; Note that a better alternative is using helm-filtered-bookmarks with
;; keybinding M-m f b
(defun darcamo-usability/init-goto-last-change ()
  (global-set-key (kbd "C-x C-n") 'goto-last-change)
  )

(defun darcamo-usability/init-buffer-move ()
  )

(defun darcamo-usability/init-rainbow-mode ()
  )

(defun darcamo-usability/init-iedit ()
  )

(defun darcamo-usability/init-git-gutter ()
  (use-package git-gutter
    :ensure t
    :config
    (global-git-gutter-mode +1)
    ;; The default is " GitGutter", but I don't want to waste
    ;; space in the modeline with that
    (setq git-gutter:lighter ""))
  )

(defun darcamo-usability/init-comment-dwim-2 ()
  (use-package comment-dwim-2
    :ensure t
    :config
    (global-set-key (kbd "M-;") 'comment-dwim-2)
    (setq comment-dwim-2--inline-comment-behavior 'reindent-comment))
  )

(defun darcamo-usability/init-discover-my-major ()
  (use-package discover-my-major
    :ensure t
    :bind
    ;; Discover Major mode keybindings with 'discover-my-major'
    ("C-h C-m" . discover-my-major)
    )
  )

(defun darcamo-usability/init-multiple-cursors ()
  (use-package multiple-cursors
    :ensure t
    :bind
    ("C-S-c C-S-c" . mc/edit-lines)
    ("C-S-c C-S-l" . mc/mark-all-like-this)
    ("C->" . mc/mark-next-like-this)
    ("C-<" . mc/mark-previous-like-this)
    )
  )

(defun darcamo-usability/init-ace-mc ()
  (use-package ace-mc
    :ensure t
    :config
    (global-set-key (kbd "C-)") 'ace-mc-add-multiple-cursors)
    (global-set-key (kbd "C-M-)") 'ace-mc-add-single-cursor)
    )
  )

(defun darcamo-usability/init-highlight-symbol ()
  )

(defun darcamo-usability/init-adaptive-wrap ()
  (use-package adaptive-wrap
    :ensure t)
  )

(defun darcamo-usability/init-focus ()
  (use-package focus
    :ensure t
    :config
    (global-set-key [C-f8] 'focus-mode)
    (global-set-key [C-S-f8] #'(lambda () (interactive) (focus-mode) (focus-read-only-mode)))
    )
  )


;;; packages.el ends here
