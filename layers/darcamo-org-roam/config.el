
(with-eval-after-load 'use-package-core
  (use-package org-roam-protocol :after org-roam)
  )


(setq org-roam-capture-templates '(
                                   ("d" "default" plain #'org-roam-capture--get-point "Criado em %u\n\n%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+SETUPFILE: ~/.spacemacs.d/org-mode-setup/org-roam-setup.org\n\n" :unnarrowed t)
                                   ("e" "De um E-mail" plain #'org-roam-capture--get-point "Criado em %u\nE-mail-original: %a\nEnviado por %:from em %:date\n\n%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+SETUPFILE: ~/.spacemacs.d/org-mode-setup/org-roam-setup.org\n\n" :unnarrowed t)
                                   ("D" "Doutorado" plain #'org-roam-capture--get-point "Criado em %u\n\n%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+SETUPFILE: ~/.spacemacs.d/org-mode-setup/org-roam-setup.org\n#+ROAM_TAGS: §Doutorado\n\n- Links :: [[file:20200623165210-doutorado.org][Doutorado]]\n\n" :unnarrowed t)
                                   ("i" "IAB" plain #'org-roam-capture--get-point "Criado em %u\n\n%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+SETUPFILE: ~/.spacemacs.d/org-mode-setup/org-roam-setup.org\n#+ROAM_TAGS: §GTEL §IAB\n\n- Links :: [[file:20201120143347-iab.org][IAB]]\n\n" :unnarrowed t)
                                   ))



;; Configuration for org-roam-bibtex
(with-eval-after-load 'org-roam-bibtex
  (add-to-list 'orb-preformat-keywords "year")
  (add-to-list 'orb-preformat-keywords "doi")

  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point) ""
           :file-name "paper_${citekey}"
           :head "#+TITLE: ${title}\n#+ROAM_KEY: ${ref}\n#+ROAM_TAGS: §Paper §${year} \n#+PROPERTY: :author ${author}\n#+PROPERTY: :doi ${doi}\n\nPDF: [[file:${file}][${title}]]\nBib entry: [[file:~/org/references/articles.bib::${citekey}][${title}]]\n\n" ; <--
           :unnarrowed t)))

  )
