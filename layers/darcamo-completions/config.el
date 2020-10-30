
;; For each entry, the first element will be the expansion trigger, while the
;; second element is the expansion. Third element indicates if a plural
;; expansion should also be created (just adding s after the trigger). The
;; fourth element indicates if a corresponding "acronym expansion" should be
;; added to latex and org-mode. An acronym expansion corresponds to a trigger
;; which is the one in the list preceeded by "a" and the expansion will have the
;; corresponding acronyms functionality (acro package in latex and glossaries
;; package in org-mode).
(setq my-acronym-list '(
                        ;; token - expansion - use plural - add acronym expansion
                        ("arima" "ARIMA" nil t)
                        ("bd" "BD" nil t)
                        ("ber" "BER" t t)
                        ("blast" "BLAST" nil t)
                        ("bler" "BLER" t t)
                        ("bpsk" "BPSK" nil t)
                        ("bs" "BS" t t)
                        ("cam" "CAM" nil t)
                        ("cdf" "CDF" t t)
                        ("comp" "CoMP" nil t)
                        ("cqi" "CQI" nil t)
                        ("crs" "CRS" nil t)
                        ("csi" "CSI" nil t)
                        ("csit" "CSIT" nil t)
                        ("csr" "CSR" nil t)
                        ("dft" "DFT" t t)
                        ("dmrs" "DMRS" nil t)
                        ("dof" "DOF" t t)
                        ("dtdd" "DTDD" nil t)
                        ("fdd" "FDD" nil t)
                        ("gp" "GP" t t)
                        ("harq" "HARQ" nil t)
                        ("ia" "IA" nil t)
                        ("ic" "IC" nil t)
                        ("jp" "JP" nil t)
                        ("los" "LOS" nil t)
                        ("ls" "LS" nil t)
                        ("lte" "LTE" nil t)
                        ("mcs" "MCS" t t)
                        ("mimo" "MIMO" nil t)
                        ("miso" "MISO" nil t)
                        ("ml" "ML" nil t)
                        ("mlp" "MLP" nil t)
                        ("mmse" "MMSE" nil t)
                        ("mrt" "MRT" nil t)
                        ("mse" "MSE" nil t)
                        ("occ" "OCC" nil t)
                        ("ofdm" "OFDM" nil t)
                        ("pdf" "PDF" t t)
                        ("prb" "PRB" t t)
                        ("prr" "PRR" nil t)
                        ("psk" "PSK" nil t)
                        ("qam" "QAM" nil t)
                        ("qos" "QoS" nil t)
                        ("rb" "RB" t t)
                        ("re" "RE" t nil)
                        ("rsrp" "RSRP" nil t)
                        ("rsrq" "RSRQ" nil t)
                        ("rssi" "RSSI" nil t)
                        ("sdma" "SDMA" nil t)
                        ("sic" "SIC" nil t)
                        ("simo" "SIMO" nil t)
                        ("sinr" "SINR" t t)
                        ("siso" "SISO" nil t)
                        ("snr" "SNR" nil t)
                        ("srs" "SRS" nil t)
                        ("stbc" "STBC" nil t)
                        ("svd" "SVD" t t)
                        ("tdd" "TDD" nil t)
                        ("tti" "TTI" t t)
                        ("ue" "UE" t t)
                        ("ula" "ULA" t t)
                        ("ura" "URA" t t)
                        ("v2i" "V2I" nil t)
                        ("v2v" "V2V" nil t)
                        ("v2x" "V2X" nil t)
                        ("zf" "ZF" nil t)
                        ))

;; List with elements in my-acronym-list where the third value is 't'
(setq plural-list (seq-filter (lambda (elem) (nth 2 elem)) my-acronym-list))

;; Construct an abbrev table for text mode from my-acronym-list
(define-abbrev-table 'my-text-mode-abbrev-table
  (append
   (mapcar (lambda (elem) (list (nth 0 elem) (nth 1 elem))) my-acronym-list)
   (mapcar (lambda (elem) (list (concat (nth 0 elem) "s") (concat (nth 1 elem) "s"))) plural-list)
   '(
     ("bayesian" "Bayesian")
     ("comunication" "communication")
     ("latence" "latency")
     ("manhattan" "Manhattan")
     ("trainning" "training")
     ("eachother" "each other")
     ("teh" "the")
     ("diferente" "different")
     ("diferent" "different")
     ("pp" "point process")
     )
   )
  )


;; (-keep (lambda (elem) (nth 2 elem)) my-acronym-list)

;; Construct an abbrev table for tex mode where each element in my-acronym-list will have a xpansion stating with "a". For instance, typing "abs" will expand to \ac{BS}
;; NOTE: The "-keep" function is like "mapcar", but it does not include nil elements in the returned list
(define-abbrev-table 'my-latex-mode-abbrev-table
  (append
   (-keep (lambda (elem) (if (nth 3 elem) (list (concat "a" (nth 0 elem)) (concat "\\ac{" (nth 1 elem) "}")))) my-acronym-list)

   (-keep (lambda (elem) (if (nth 3 elem) (list (concat "a" (nth 0 elem) "s") (concat "\\acp{" (nth 1 elem) "}")))) plural-list)
   )
  )

(define-abbrev-table 'my-org-mode-abbrev-table
  (append
   (-keep (lambda (elem) (if (nth 3 elem) (list (concat "a" (nth 0 elem)) (concat "ac:" (nth 1 elem))))) my-acronym-list)

   (-keep (lambda (elem) (if (nth 3 elem) (list (concat "a" (nth 0 elem) "s") (concat "acp:" (nth 1 elem))))) plural-list)
   )
  )


;; I will always modify my abbrev file manually or programatically and I don't
;; want emacs to mess the file
(setq save-abbrevs nil)

;; Turn on abbrev-mode by default on all major modes
(setq-default abbrev-mode t)

(read-abbrev-file "~/.abbrev_defs")
