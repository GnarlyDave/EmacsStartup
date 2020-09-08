;; do the OS specific differences first.
(if (file-exists-p "~/lisp/ds-osadaption.el")
    (load (expand-file-name "~/lisp/ds-osadaption.el"))
  )

;; load the packages I use.
;; set the package independent preferences
(if (file-exists-p "~/lisp/ds-packages.el")
    (load (expand-file-name "~/lisp/ds-packages.el"))
)
(if (file-exists-p "~/lisp/ds-preferences.el")
    (load (expand-file-name "~/lisp/ds-preferences.el"))
  )
