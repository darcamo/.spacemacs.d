

;; Change between .h and .cpp

;; (defun change-between-h-cpp ()
;;   "If the library eassist is loaded, call
;;       eassist-switch-h-cpp. Otherwise, call the builtin
;;       ff-find-other-file function"
;;   (interactive)
;;   (if (fboundp 'eassist-switch-h-cpp)
;;       (eassist-switch-h-cpp)
;;     (ff-find-other-file)))


;; Compile Functions

(defun my-save-and-compile ()
  (interactive "")
  (save-buffer 0)
  (compile "make -k -j 2"))

(defun my-save-and-compile-and-run ()
  (interactive "")
  (save-buffer 0)
  (compile "make -k -j 2 run"))

;; Compila apenas o arquivo atual
(defun my-save-and-compile-single-file ()
  (interactive "")
  (save-buffer 0)
  (if (string= (substring(buffer-name) -1) "p") ; Testa se é o .cpp ou o .h
                                        ; If it is true and we are in the .cpp file
      (compile (concat "make -k -j 2 " (concat (substring(buffer-name) 0 -4) ".o")))
                                        ; If false and we are in the .h file
    (compile (concat "make -k -j 2 " (concat(substring(buffer-name) 0 -2) ".o")))
    )
  )
