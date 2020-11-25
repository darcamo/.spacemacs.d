(when (configuration-layer/package-usedp 'org-table)

  ;; Orgtbl Translator function for the GitHub-Flavored-Markdown(GFM)
  ;; Taken from https://gist.github.com/yryozo/5807243
  (defun orgtbl-to-gfm (table params)
    "Convert the Orgtbl mode TABLE to GitHub Flavored Markdown."
    (let* ((alignment (mapconcat (lambda (x) (if x "|--:" "|---"))
                                 org-table-last-alignment ""))
           (params2
            (list
             :splice t
             :hline (concat alignment "|")
             :lstart "| " :lend " |" :sep " | ")))
      (orgtbl-to-generic table (org-combine-plists params2 params))))

  )


(defun darlan/save-buffer-and-export-to-last-target ()
  "Save the burrent buffer and export org-mode buffer to the last exported target"
  (interactive)
  (progn
    (save-buffer)
    (if org-export-dispatch-last-action
        (org-export-dispatch 4)
      (message "Please export to some target first"))
    )
  )
