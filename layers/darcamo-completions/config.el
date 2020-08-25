
;; For each entry, the first element will be the expansion trigger, while the
;; second element is the expansion. Third element indicates is a plural
;; expansion should also be created
(setq my-acronym-list '(
                        ("arima" "ARIMA" nil)
                        ("bd" "BD" nil)
                        ("ber" "BER" nil)
                        ("blast" "BLAST" nil)
                        ("bler" "BLER" nil)
                        ("bpsk" "BPSK" nil)
                        ("bs" "BS" t)
                        ("cam" "CAM" nil)
                        ("cdf" "CDF" nil)
                        ("comp" "CoMP" nil)
                        ("cqi" "CQI" nil)
                        ("crs" "CRS" nil)
                        ("csi" "CSI" nil)
                        ("csit" "CSIT" nil)
                        ("dft" "DFT" nil)
                        ("dmrs" "DMRS" nil)
                        ("dof" "DOF" nil)
                        ("dtdd" "DTDD" nil)
                        ("fdd" "FDD" nil)
                        ("harq" "HARQ" nil)
                        ("ia" "IA" nil)
                        ("ic" "IC" nil)
                        ("jp" "JP" nil)
                        ("los" "LOS" nil)
                        ("ls" "LS" nil)
                        ("lte" "LTE" nil)
                        ("mimo" "MIMO" nil)
                        ("miso" "MISO" nil)
                        ("mlp" "MLP" nil)
                        ("mmse" "MMSE" nil)
                        ("mrt" "MRT" nil)
                        ("mse" "MSE" nil)
                        ("ofdm" "OFDM" nil)
                        ("pdf" "PDF" t)
                        ("prb" "PRB" t)
                        ("prr" "PRR" nil)
                        ("psk" "PSK" nil)
                        ("qam" "QAM" nil)
                        ("qos" "QoS" nil)
                        ("rb" "RB" nil)
                        ("rsrp" "RSRP" nil)
                        ("rsrq" "RSRQ" nil)
                        ("rssi" "RSSI" nil)
                        ("sdma" "SDMA" nil)
                        ("sic" "SIC" nil)
                        ("simo" "SIMO" nil)
                        ("sinr" "SINR" nil)
                        ("sinrs" "SINRs" nil)
                        ("siso" "SISO" nil)
                        ("snr" "SNR" nil)
                        ("srs" "SRS" nil)
                        ("stbc" "STBC" nil)
                        ("svd" "SVD" nil)
                        ("tdd" "TDD" nil)
                        ("teh" "the" nil)
                        ("tti" "TTI" nil)
                        ("ue" "UE" t)
                        ("ula" "ULA" nil)
                        ("ura" "URA" nil)
                        ("v2i" "V2I" nil)
                        ("v2v" "V2V" nil)
                        ("v2x" "V2X" nil)
                        ("zf" "ZF" nil)
                        ))

;; List with elements in my-acronym-list where the third value is 't'
(setq plural-list (seq-filter (lambda (elem) (nth 2 elem)) my-acronym-list))

;; Construct an abbrev table for text mode from my-acronym-list
(define-abbrev-table 'text-mode-abbrev-table
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
     ("pathloss" "path-loss")
     )
   )
  )


;; Construct an abbrev table for tex mode where each element in my-acronym-list will have a xpansion stating with "a". For instance, typing "abs" will expand to \ac{BS}
(define-abbrev-table 'latex-mode-abbrev-table
  (append
   (mapcar (lambda (elem) (list (concat "a" (nth 0 elem)) (concat "\\ac{" (nth 1 elem) "}"))) my-acronym-list)

   (mapcar (lambda (elem) (list (concat "a" (nth 0 elem) "s") (concat "\\acp{" (nth 1 elem) "}"))) plural-list)
   )
  :parents (list text-mode-abbrev-table)
  )

(define-abbrev-table 'org-mode-abbrev-table
  (append
   (mapcar (lambda (elem) (list (concat "a" (nth 0 elem)) (concat "gls:" (nth 1 elem)))) my-acronym-list)

   (mapcar (lambda (elem) (list (concat "a" (nth 0 elem) "s") (concat "glspl:" (nth 1 elem)))) plural-list)
   )
  :parents (list text-mode-abbrev-table)
  )



;; Turn on abbrev-mode by default on all major modes
(setq-default abbrev-mode t)
