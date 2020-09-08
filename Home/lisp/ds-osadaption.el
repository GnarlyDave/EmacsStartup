;
;
; this file is part of my customisations to isolate the
; differences between different emacs versions and
; the operating systems they run on. as well as the
; different installations. In true GNU autoconf style
; the idea is to identify the environment in this file
; and set flags based on the properties, not the environment.
;
; startup strategy:
; for Xemacs the ~/.xemacs/init.el sets custom-file to ~/.xemacs/custom.el
; then loads custom-file early.
; then ~/.xemacs/init.el loads:
; ds-osadaption.el, ds-packages.el, ds-preferences.el
; for GnuEmacs, .emacs sets user-init-file to ~/.gemacs/init.el and
; custom-file to ~/.gemacs/custom.el
; custom file is also loaded early
; then ~/.gemacs/init.el loads:
; ds-osadaption.el, ds-packages.el, ds-preferences.el
;
; for EmacsW32
; C:\.emacs should exist and contain
;;; This is only used by EmacsW32
;;;(message (concat "Bootstrapping in " (getenv "HOMEDRIVE") (getenv "HOMEPATH")))
;;;(setenv "HOME" (concat (getenv "HOMEDRIVE") (getenv "HOMEPATH")))
;;;(load "~/.emacs")
;
; the result is that custom-file is kept separate for each type, and is
; loaded early. This allows different settings to be custom,
; but can still be overwritten intelligently by code.
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; the paths are different under different OS
;; on my machines.
(setq ds-home (getenv "HOME"))
(setq ds-at-home t)
(setq ds-at-work nil)
(setq ds-use-cygwin nil)

;; see if running under xemacs
(setq ds-running-xemacs-p (or (boundp 'running-xemacs)
			    (string-match "XEmacs\\|Lucid" emacs-version))
)
;; the special win32 build of emacs.
(setq ds-running-emacsw32-p (and (eq system-type 'windows-nt)
                                 (boundp 'gnuserv-start))
)
      
(message (concat "emacs version=" emacs-version))
(message (concat "system-name=" (system-name)))

; note XEmacs for cygwin downcases the system-name
; NTEmacs uses uppercase %COMPUTERNAME%
;; system-name is a built in function for xemacs
(if (string-equal (upcase (system-name)) "NYLAN")
    (progn (setq ds-emacs-location (expand-file-name "d:/users/dave"))
	   (setq ds-utils-location (expand-file-name "d:/apps/bin"))
	   (setq ds-use-cygwin f)
	   (setq ds-cygwin-location (expand-file-name "d:/ProgramFiles/cygwin"))
	   (setq ds-backups-dir (expand-file-name "e:/tmp files/das/emacsBackups/"))
	   (setq ds-at-home nil)
	   (setq ds-emacs-dir (expand-file-name (getenv "EMACS_ROOT")))
     )
    (if (string-equal (system-name) "gagravaar")
	(progn
       	   (setq ds-cygwin-location (expand-file-name "d:/ProgramFiles/cygwin"))
           (setq ds-backups-dir (expand-file-name "e:/tmp/emacsBackups/"))
           )
      
    ;; default
    (setq ds-emacs-location "C:/")
    ))

;;
;; setup the environment flags
;;(setq ds-desired-features '(csharp jde))
(setq ds-version-control "none")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set the initial path to emacs
;; set the path to emacs version specific stuff
(setq ds-emacs-specific-location (concat ds-emacs-location "/emacs-" emacs-version "/"))
(message "using emacs at ")
(message ds-emacs-specific-location)

;(setq ds-emacs-site-lisp (concat ds-emacs-location "/site-lisp"))

;;;;;;;;;;;;;;;;;;;;;
;; end of machine specific bootstrap
;;


;;;;;;;;;;;;
; example code for how to detect registry settings particularly
; docking status and hardware profile.
;;  (if (string-equal (downcase (system-name)) "ender")
;      (progn (setq ds-emacs-location (expand-file-name "d:/apps"))
;             (setq ds-utils-location (expand-file-name "d:/apps/bin"))
;	     (setq ds-emacs-dir (expand-file-name "d:/emacs-20.7"))
;	     (setq ds-backups-dir (expand-file-name "~/.backups"))
;	     (message (concat "backups dir " ds-backups-dir))
;             ;; need to check the hardware profile if we are in NT
;             (if (file-exists-p "~/lisp/RegistryInt/w32-reg-int.el")
;                 (progn
;		   (add-to-list 'load-path "~/lisp/RegistryInt")
;                   ;; Load the registry interface
;                   (require 'w32-reg-int)
                   
;;HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0003
;;HKLM\SYSTEM\ControlSet001\Control\IDConfigDB\CurrentConfig == 3 = vodafone
;; 2 = docked
;; 1 = undocked
;                   (if (string-equal (cdr (w32-reg-interface-read-value "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\IDConfigDB\\CurrentConfig"))
;                                     "4")
;                       (message "undocked")
;                                     )
;                   )
;               )
;	     (setq ds-at-home nil)
;	     (setq ds-at-work t)
;             (setq ds-initial-height 43)
;	     )
