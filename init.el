;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(graphviz
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; helm
     ;; lua
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup nil
                      auto-completion-enable-help-tooltip t)
     (templates :variables
                templates-private-directory "~/.spacemacs.d/templates"
                templates-use-default-templates nil
                auto-insert-query nil)
     ;; trocar define-skeleton por templates

     ;; rust  ;; Added in when a toml file was opened
     better-defaults
     ;; spotify
     emacs-lisp
     (git :variables
          magit-repository-directories '(("/home/darlan/git_files" . 1))
          magit-diff-refine-hunk (quote all)
          )
     ;; github ;; See github layer documentation before enabling

     ;; Use "M-m a /" to search
     ;; (search-engine :variables
     ;;                search-engine-config-list '((ieeexplore
     ;;                                             :name "IEEE Xplore"
     ;;                                             :url "https://ieeexplore.ieee.org/search/searchresult.jsp?newsearch=true&queryText=%s"
     ;;                                             :keywords (:docstring "Search in IEEE Xplore"))))
     markdown
     ;; (neotree :variables neo-theme 'icons)
     (org :variables
          ;; org-indent-mode t
          org-enable-reveal-js-support t  ;; download reveal.js and set org-reveal-root to the download path
          org-re-reveal-root "file:///home/darlan/Programas_Locais/reveal.js"

          org-attach-use-inheritance t
          org-link-frame-setup '((vm . vm-visit-folder-other-frame)
                                (vm-imap . vm-visit-imap-folder-other-frame)
                                (gnus . org-gnus-no-new-news)
                                (file . find-file)
                                (wl . wl-other-frame))
          org-preview-latex-default-process 'dvisvgm
          org-hide-emphasis-markers t  ;; font-lock should hide the emphasis markers

          org-image-actual-width '(600)

          ;; Org-roam support
          org-enable-roam-support t
          org-roam-v2-ack t
          org-roam-directory "/home/darlan/org/org-roam-notes/"
          org-roam-db-location (concat user-emacs-directory ".cache/org-roam.db")
          org-roam-graph-exclude-matcher "index.org"
          org-roam-graph-extra-config '(("rankdir" . "LR"))

          ;; org-enable-roam-server t
          )

     spacemacs-org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     spell-checking
     syntax-checking
     ;; version-control
     html
     (python :variables
             python-fill-docstring-style 'symmetric
             python-backend 'lsp
             python-formatter 'yapf
             ;; python-format-on-save t
             python-sort-imports-on-save nil
             python-fill-column 80)

     ;; ipython-notebook
     (latex :variables
            latex-enable-folding t
            latex-backend 'company-auctex
            )
     (bibtex :variables
             bibtex-entry-format '(opts-or-alts required-fields numerical-fields whitespace realign last-comma unify-case braces sort-fields)
             bibtex-comma-after-last-field t
             )

     ;; c-c++ layer can use semantic and cscope layers, if they are included before c-c++ layer
     ;; semantic
     ;; cscope
     (c-c++ :variables
            ;; c-c++-enable-clang-support t  ;; Not used for the lsp-* backends
            c-c++-default-mode-for-headers 'c++-mode
            compilation-window-height 16
            c-doc-comment-style 'doxygen
            c-c++-backend 'lsp-clangd
            lsp-file-watch-threshold 6000
            lsp-enable-snippet nil
            c-c++-lsp-enable-semantic-highlight nil ;;'rainbow
            ;; c-c++-lsp-executable "/home/darlan/Programas_Locais/ccls/Release/ccls"
            )
     debug ; TODO: Investigate this layer -> It uses realgud
     ibuffer
     ;; themes-megapack
     ;; graphviz
     javascript
     ;; gtags  ;; I'm using the gxref package now
     (csv :variables
          csv-separators '("," "	" ";"))
     yaml
     ;; plantuml
     ;; octave
     cmake ;; TODO: Investigate this layer (does it add sintax highlight to cmake files?)
     (lsp :variables
          lsp-ui-doc-include-signature t
          lsp-ui-doc-enable nil ;; Too much pollution if enabled
          ;; lsp-ui-sideline-show-symbol t
          lsp-ui-sideline-show-hover nil  ;; Too much pollution if enabled
          lsp-headerline-breadcrumb-enable nil
          lsp-keymap-prefix "C-x l"  ;; Change keymap prefix from "s-l" to "C-x l"
          lsp-enable-on-type-formatting nil
          ;; lsp-enable-file-watchers nil
          )
     (mu4e :variables
           mu4e-enable-mode-line nil
           mu4e-enable-notifications nil)
     docker
     ;; systemd
     dap
     ;; treemacs
     unicode-fonts
     ;; (ipython-notebook :variables
     ;;                   ein:jupyter-default-server-command "/home/darlan/miniconda3/envs/pyphysim/bin/jupyter")
     ;; My Private Layers
     ;;emoji
     (deft :variables
       deft-directory "~/org/org-roam-notes"
       deft-use-filename-as-title nil
       deft-zetteldeft nil
       deft-recursive t
       deft-use-filter-string-for-filename t
       deft-default-extension "org"
       )

     helpful

     darcamo-org-roam  ;; Extra org-roam configuration
     darcamo-pdf
     darcamo-c++
     darcamo-python-conda-env
     darcamo-jupyter-notebook  ;; Defines a (VERY) simple minor-mode for jupyter notebooks that makes file read-only
     darcamo-functions
     darcamo-general-programming
     darcamo-org
     darcamo-preview-latex  ;; org-mode and programming buffers
     darcamo-references  ;; configure org-ref and bibtex
     darcamo-outline-minor-mode
     darcamo-spell-checking
     darcamo-usability
     darcamo-mouse
     darcamo-completions  ;; Atalho C-f1 está aqui
     darcamo-latex-extra
     darcamo-latex-beamer
     darcamo-tikz
     darcamo-mu4e
     darcamo-authinfo
     darcamo-calibre
     darcamo-volume
     darcamo-diagrams  ;; Use napkin in org-babel (it's Python) to create
                       ;; diagrams
     )

   ;; Other things to check
   ;; - Org-graph-view: https://github.com/alphapapa/org-graph-view

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(string-utils
                                      helm-unicode
                                      ninja-mode
                                      grip-mode  ;; Live preview markdown and org-mode files -> you need to `pipx install grip`
                                      ;; gxref
                                      darkroom
                                      poetry
                                      (pdf-continuous-scroll-mode :location (recipe
                                                                             :fetcher github
                                                                             :repo "dalanicolai/pdf-continuous-scroll-mode.el"))
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(wombat
                         tsdh-dark
                         darkmine
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '(("JetBrains Mono"  ;; Great font and it also has italics
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
                               ("Fira Code"  ;; Great font, but does not have italics
                                :size 16
                                :weight normal
                                :width normal
                                :powerline-scale 1.1)
                               ("Source Code Pro"
                                :size 16
                                :weight normal
                                :width normal
                                :powerline-scale 1.1)
                               )
   ;; TIP: call the "set-frame-font" interactive function to try a few options

   ;; (set-face-attribute 'default nil :font "Fira Code Retina-12")

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Show trailing whitespace (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (require 'dired-x)

  (setenv "WORKON_HOME" "/home/darlan/miniconda3/envs")
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump.")


(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  ;; Make Emacs use UTF-8 in files, filenames, terminal, etc..
  (set-language-environment 'UTF-8)

  ;; (setq user-mail-address "darcamo@gmail.com")

  ;; Safe file/dir variables
  (put 'helm-make-build-dir 'safe-local-variable 'stringp)
  (put 'projectile-project-compilation-cmd 'safe-local-variable 'stringp)
  (put 'projectile-project-run-cmd 'safe-local-variable 'stringp)
  (put 'user-mail-address 'safe-local-variable 'stringp)
  (put 'reftex-default-bibliography 'safe-local-variable 'darlan/list-of-strings-p)
  (put 'darlan-cmake-use-ninja 'safe-local-variable 'booleanp)
  (put 'darlan-build-dir 'safe-local-variable 'stringp)
  (put 'abbrev-file-name 'safe-local-variable 'stringp)
  (put 'TeX-master 'safe-local-variable 'stringp)
  (put 'ispell-skip-html 'safe-local-variable 'booleanp)
  (put 'ispell-local-dictionary 'safe-local-variable 'stringp)
  (put 'org-download-image-dir 'safe-local-variable 'stringp)
  (put 'org-html-table-align-individual-fields 'safe-local-variable 'booleanp)

  ;; Set extension .puml to plantuml mode -> Requires the plantuml layer
  (add-to-list 'auto-mode-alist '("\\.puml" . plantuml-mode))
  ;; Set .clang-format file to yaml mode
  (add-to-list 'auto-mode-alist '("\\.clang-format" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.style.yapf" . conf-mode))
  (add-to-list 'auto-mode-alist '(".conan/profiles/*" . conf-mode))
  ;; Integrate plantuml with org-mode
  (with-eval-after-load 'org
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
    )
  ;; Set conf-mode for the conanfile.txt -> Used by conan C++ package manager
  (add-to-list 'auto-mode-alist '("conanfile\\.txt" . conf-mode))

  ;; Set a file with name Doxyfile to conf-mode
  (add-to-list 'auto-mode-alist '("Doxyfile" . conf-mode))

  ;; Add the doxymacs package (in my .spacemacs.d/local folder) and activate
  ;; doxymacs-mode in C++ buffers
  (use-package doxymacs
    :load-path "~/.spacemacs.d/local"
    :diminish doxymacs-mode
    :config (add-hook 'c++-mode-hook 'doxymacs-mode)
    )

  ;; The system-cores library provides a "system-core" function that we can use
  ;; to query how many CPUs the machine has. We use this to get the number of
  ;; cores to pass to "make" in the "darlan-get-make-or-ninja-compile-command"
  ;; function.
  ;;
  ;; See this answer in stackoverflow: https://stackoverflow.com/questions/20666556/getting-number-of-processors-in-emacs
  (use-package system-cores
    :load-path "~/.spacemacs.d/local"
    :diminish system-cores
    ;; :config (add-hook 'c++-mode-hook 'doxymacs-mode)
    )

  ;; Some layers change the company-idle-delay, but I prefer to keep it at the
  ;; original value of 0.5, since a lower value can make completion slower
  (setq company-idle-delay 0.5)

  ;; Projectile find test file
  (defun darlan/my-test-prefix (project-type) "test_")
  (setq projectile-test-prefix-function 'darlan/my-test-prefix)

  ;; Require locally installed meson-mode file. This is a major mode for
  ;; meson.build files.
  ;; (require 'meson-mode)

  (with-eval-after-load 'dired-x
    (add-hook 'dired-mode-hook
              (function (lambda ()
                          ;; Extensões de arquivos que serão omitidos quando estiver usando o dired-omit-mode
                          ;; Note que vc também pode usar "C-u s" para mudar os switches do dired
                          (add-to-list 'dired-omit-extensions ".fdb_latexmk")
                          (add-to-list 'dired-omit-extensions "synctex.gz")
                          (add-to-list 'dired-omit-extensions "log")
                          (add-to-list 'dired-omit-extensions "fls")
                          (add-to-list 'dired-omit-extensions "converted-to.pdf")
                          (add-to-list 'dired-omit-extensions "bcf")
                          (add-to-list 'dired-omit-extensions "acn")
                          (add-to-list 'dired-omit-extensions "acr")
                          (add-to-list 'dired-omit-extensions "alg")
                          (add-to-list 'dired-omit-extensions "ist")
                          (add-to-list 'dired-omit-extensions "slg")
                          (add-to-list 'dired-omit-extensions "slo")
                          (add-to-list 'dired-omit-extensions "sls")
                          (add-to-list 'dired-omit-extensions "wrt")
                          (add-to-list 'dired-omit-extensions "tikz.pdf")
                          (add-to-list 'dired-omit-extensions ".figlist")
                          (add-to-list 'dired-omit-extensions ".ilg")
                          (add-to-list 'dired-omit-extensions ".ind")
                          (add-to-list 'dired-omit-extensions ".out")
                          (add-to-list 'dired-omit-extensions ".run.xml")
                          (add-to-list 'dired-omit-extensions ".org_archive")
                          (add-to-list 'dired-omit-extensions ".bak")
                          (add-to-list 'dired-omit-extensions ".tramp_history")
                          (add-to-list 'dired-omit-extensions ".python_history")
                          (setq dired-omit-files (concat dired-omit-files "\\|^.idea"))
                          (setq dired-omit-files (concat dired-omit-files "\\|^.ipynb_checkpoints"))
                          (setq dired-omit-files (concat dired-omit-files "\\|^.vscode"))
                          (setq dired-omit-files (concat dired-omit-files "\\|^__pycache__"))
                          (setq dired-listing-switches "-alhv")  ;; Add "h" to switches to get human-readable sizes
                          ))

              ;; List with default command to run on a file in dired mode when either "!" or "&" is pressed in dired
              (setq dired-guess-shell-alist-user '(
                                                   ("\\.pdf\\'" "evince")
                                                   ("\\.xmind" "xmind-zen")
                                                   ))
              )
    )

  ;; Disable indentation for some tags in web-mode
  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentless-elements "code-terminal")
    (add-to-list 'web-mode-indentless-elements "output")
    (add-to-list 'web-mode-indentless-elements "in")
    (define-key web-mode-map [f10] #'(lambda () (interactive) (browse-url (concat (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) ".html"))))
    )

  ;; xxxxxxxxxx Configure gxref package xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  ;; (add-to-list 'xref-backend-functions 'gxref-xref-backend)

  ;; | Function              | Binding  |
  ;; |:---------------------:|:--------:|
  ;; | xref-find-definitions | M-.      |
  ;; | xref-find-references  | M-?      |
  ;; | xref-find-apropos     | C-M-.    |
  ;; | xref-pop-marker-stack | M-,      |
  ;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  ;; This might help with the slow handling of very long lines
  (setq-default bidi-display-reordering nil)

  ;; (require 'helm)

  ;; Diminish minor-mode indicators I don't care
  (spacemacs|diminish holy-mode)
  (spacemacs|diminish which-key-mode)
  (spacemacs|diminish company-mode)
  (spacemacs|diminish yas-minor-mode)
  (spacemacs|diminish helm-mode)

  ;; Don't automatically add the closing parenthesis/quote/etc
  ;;
  ;; I still want to use smartparens-mode for things such as selecting a word
  ;; and typing '"' to quote the word, but the automatic closing gets in the way
  ;; of company-mode sometimes
  (setq sp-autoinsert-pair nil)

  ;; Spacemacs change the value of abbrev-file-name, but I preffer to keep the
  ;; original name in my home directory
  (setq abbrev-file-name (expand-file-name "~/.abbrev_defs"))

  ;; Read the abbrev file in my home directory
  (read-abbrev-file "~/.abbrev_defs")

  ;; New buffers are in org-mode by default (instead of fundamental mode)
  (setq-default major-mode 'org-mode)

  ;; If set to t when adding a new history element, all previous identical
  ;; elements are deleted from the history list.
  (setq history-delete-duplicates t)
  (setq history-length 50)

  (global-set-key [C-f11] 'darkroom-tentative-mode)
  (global-set-key [C-f6] 'deft)

  ;; Emacs application framework
  ;; https://github.com/manateelazycat/emacs-application-framework#dependency-list
  ;; Dependencies: "pikaur -S python-pyqt5 python-pyqt5-sip python-pyqtwebengine python-qrcode python-feedparser python-dbus python-pyinotify python-markdown nodejs aria2 libreoffice python-pymupdf python-grip filebrowser-bin"
  ;;
  ;; It is available in Arch AUR as the 'emacs-eaf' package
  ;; (use-package eaf
  ;;   ;; :load-path "/usr/share/emacs/site-lisp/eaf" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  ;;   :load-path "~/Programas_Locais/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  ;;   :custom
  ;;   (eaf-find-alternate-file-in-dired t)
  ;;   :config
  ;;   (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  ;;   (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  ;;   (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  ;;   ;; (define-key eaf-mode-map (kbd "C-<down>") 'eaf-proxy-scroll_up_page)
  ;;   ;; (define-key eaf-mode-map (kbd "C-<up>") 'eaf-proxy-scroll_down_page)
  ;;   ;; (define-key eaf-mode-map (kbd "M-<") 'eaf-proxy-scroll_to_begin)
  ;;   ;; (define-key eaf-mode-map (kbd "M->") 'eaf-proxy-scroll_to_end)
  ;;   ;; :bind
  ;;   ;; (("C-<down>" . eaf-proxy-scroll_up_page)
  ;;   ;; ("C-<up>" . eaf-proxy-scroll_down_page)
  ;;   ;; ("M-<" . eaf-proxy-scroll_to_begin)
  ;;   ;; ("M->" . eaf-proxy-scroll_to_end))
  ;;   )

  (with-eval-after-load 'pdf-continuous-scroll-mode
    (define-key pdf-continuous-scroll-mode-map (kbd "<S-mouse-4>") #'(lambda () (interactive) (pdf-cscroll-image-backward-hscroll 4)))
    (define-key pdf-continuous-scroll-mode-map (kbd "<S-mouse-5>") #'(lambda () (interactive) (pdf-cscroll-image-forward-hscroll 4)))

    (define-key pdf-continuous-scroll-mode-map (kbd "<prior>") 'pdf-continuous-previous-page)
    (define-key pdf-continuous-scroll-mode-map (kbd "<next>") 'pdf-continuous-next-page)
    (define-key pdf-continuous-scroll-mode-map (kbd "q") #'(lambda ()  (interactive) (pdf-continuous-scroll-mode -1) (quit-window) ))
    )

  ;; Enable org-clock-in support in the modline
  (setq spaceline-org-clock-p t)

  ;; With a dark theme, the default color of ediff-fine-diff-B background is to
  ;; bright and I often can't see the text. Let's change it to a better color
  (with-eval-after-load 'ediff-init
    (set-face-attribute 'ediff-fine-diff-B nil :background
                        "DarkSlateGray" ))

  ;; By default the "hl-line" face (used to highlight the current line) just
  ;; inherits from the "highlight" face. Some themes such as tsdh-dark change
  ;; "hl-line" to a nice face, but other themes (such as wombat) don't bother to
  ;; do that, which results in confusing creating a mark with the highlight of
  ;; the current line. Let's just set the face for hl-line to something. The
  ;; value below is the background color of the default face in the wombat theme
  ;; with 1 added to every digit.
  (set-face-attribute 'hl-line nil :inherit nil :background "#353535")
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function 'browse-url-default-browser)
 '(evil-want-Y-yank-to-eol nil)
 '(org-highlight-latex-and-related '(native))
 '(org-roam-directory "/home/darlan/org/org-roam-notes/")
 '(package-selected-packages
   '(wgrep vertico-repeat vertico orderless marginalia flyspell-correct-popup embark-consult embark consult docker-tramp realgud company-lua lua-mode highlight-doxygen ob-napkin org-special-block-extras org-super-agenda org-noter-pdftools org-pdftools pulseaudio-control org-sticky-header org-re-reveal focus olivetti grip-mode poetry calibredb pdf-continuous-scroll-mode darkroom sublimity centered-window zen-mode ox-latex-subfigure adaptive-wrap org-msg jupyter exec-path-from-shell org-noter org-roam-server company-org-roam emacsql-sqlite3 emacsql org-roam yatemplate emojify emoji-cheat-sheet-plus company-emoji unicode-fonts ucs-utils font-utils tern persistent-soft pcache toml-mode racer helm-gtags ggtags flycheck-rust counsel-gtags cargo rust-mode ob-ipython ein treemacs-projectile dap-mode bui tree-mode systemd noccur synosaurus orgit lsp-ui evil-nerd-commenter dumb-jump doom-modeline aggressive-indent ace-window counsel lsp-mode company magit transient pdf-tools helm haml-mode js2-mode all-the-icons dash yasnippet-snippets yapfify yaml-mode ws-butler writeroom-mode winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill toc-org tagedit symon swiper string-utils string-inflection spotify spaceline-all-the-icons smeargle slim-mode shrink-path scss-mode sass-mode restart-emacs rainbow-mode rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode prettier-js popwin plantuml-mode pippel pipenv pip-requirements persp-mode pcre2el password-generator paradox ox-twbs overseer org-ref org-projectile org-present org-pomodoro org-mime org-download org-bullets org-brain open-junk-file ninja-mode neotree nameless mwim mu4e-maildirs-extension mu4e-jump-to-list mu4e-alert move-text mmm-mode markdown-toc magit-svn magit-gitflow macrostep lv lorem-ipsum livid-mode live-py-mode link-hint json-navigator js2-refactor js-doc interleave indent-guide importmagic impatient-mode ibuffer-projectile hungry-delete hl-todo highlight-symbol highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-unicode helm-themes helm-swoop helm-spotify-plus helm-rtags helm-pydoc helm-purpose helm-projectile helm-org-rifle helm-mu helm-mode-manager helm-make helm-gitignore helm-git-grep helm-flx helm-descbinds helm-ctest helm-css-scss helm-company helm-c-yasnippet helm-ag graphviz-dot-mode goto-last-change google-translate google-c-style golden-ratio gnuplot gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter git-commit gh-md fuzzy font-lock+ flyspell-correct-helm flycheck-rtags flycheck-pos-tip flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav eldoc-eval editorconfig dotenv-mode dockerfile-mode docker discover-my-major disaster diminish define-word darkmine-theme cython-mode csv-mode cquery counsel-projectile conda company-web company-tern company-statistics company-rtags company-quickhelp company-lsp company-c-headers company-auctex company-anaconda comment-dwim-2 column-enforce-mode cmake-mode cmake-ide clean-aindent-mode clang-format centered-cursor-mode ccls buffer-move auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk ace-mc ace-link ace-jump-helm-line ac-ispell))
 '(safe-local-variable-values
   '((org-latex-hyperref-template)
     (org-highlight-latex-and-related)
     (projectile-project-name . "ml")
     (javascript-backend . tern)
     (javascript-backend . lsp)))
 '(warning-suppress-log-types '((comp)))
 '(warning-suppress-types '((use-package) (:warning))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-math-face ((t (:foreground "burlywood" :family "Deja-DejaVu Math TeX Gyre"))))
 '(org-roam-link ((t (:inherit org-link :foreground "spring green"))))
 '(org-roam-link-current ((t (:inherit org-link :foreground "gold"))))
 '(pdf-isearch-lazy ((((background light)) (:foreground "goldenrod")) (((background light)) (:inherit lazy-highlight)))))
)
