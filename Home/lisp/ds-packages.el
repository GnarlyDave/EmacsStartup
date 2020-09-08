;;; ds-packages.el -- load my package customizations for emacs.

;; Author: Dave Spring
;; Keywords: lisp
;; Revision: 1.0

;; This file is not part of GNU Emacs.

;;; Commentary:

;;  This is a helper package that is designed to be used to alleviate
;; the complexity of loading up lots of custom Emacs Lisp from a .emacs
;; startup file.
;;
;;  This package has been posted as one simple method of loading all the
;; personal lisp packages a user possesses.
;;

;;; Usage:


;;; Details:


;;; History:

;;  1.0 -- Initial version.

;;; Code:

(defvar ds-packages "1.0"
  "Version number of ds packages.")

(defvar ds-site-package-list ()
  "List of packages to add from the site, as sub directory names.")

(defvar ds-home-package-list ()
  "List of packages to add from under my home/lisp directory.")

;;
;; these are package specific and os specific


;; (if ds-at-home
;;     (progn )
;;   ( progn 
;;     ;; not at home
;;     ;; try setting up the printer in the office
;;     (setq printer-name "//10.33.112.86/ricoh551 006")
;;     )
;; )

;; ;;;
;; ;;
;; ;; now load the packages

;; ;; cope with the dependencies first.
;; ;; eieio requires speedbar
;; ;; speedbar supports w3 as well.

;; ;(add-to-list 'load-path "~/lisp/w3/lisp")
;; ;; enabling w3 kills emacs! - not if you actually install it properly:
;; ;; edit build.bat and run it.
;; ;(require 'w3-auto)

;; ;; using require all on speedbar needs w3....
;; ;; semantic requires one better than shipped with Emacs
;; (add-to-list 'load-path "~/lisp/speedbar-0.14beta4")
;; (require 'speedbar)

;; ;; eieio
;; ;; used by JDE, Semantic, ...
;; (add-to-list 'load-path "~/lisp/eieio-0.17")
;; (require 'eieio)

;; ;; semantic - no deps except to call speedbar before
;; ;; JDE needs 1.4+
;; (add-to-list 'load-path "~/lisp/semantic-1.4")
;; ;(setq semantic-load-turn-everything-on t)
;; ;(require 'semantic-load)
;; ;;(require 'semantic-c) ; for C code integration
;; ;;(require 'semantic-el) ; for Emacs Lisp code integration
;; ;;(require 'semantic-make) ; for Makefile integration
;; ;;(require 'semantic-imenu) ; if you use imenu or wich-function
;; ;(add-hook 'speedbar-load-hook (lambda () (require 'semantic-sb)))
;; 			; for speedbar integration
;; ;(autoload 'semantic-bnf-mode "semantic-bnf" "Mode for Bovine Normal Form." t)
;; ;(add-to-list 'auto-mode-alist '("\\.bnf$" . semantic-bnf-mode))
;; 			; for editing .bnf parser files.
;; ;(autoload 'semantic-minor-mode "semantic-mode" "Mode managing semantic parsing." t)
;; 			; for semantic-minor-mode

;; ; decompile mode
;; ; (requires jad on path)
;; (add-to-list 'load-path (expand-file-name "~/lisp/decompile"))
;; (require 'decompile)

;; ;; elib
;; (add-to-list 'load-path (expand-file-name "~/lisp/elib-1.0"))

;; ;; jde
;; ;; needs eieio, speedbar, semantic
;; (add-to-list 'load-path "~/lisp/jde-2.2.9beta11/lisp")

;; ;; If you want Emacs to defer loading the JDE until you open a 
;; ;; Java file, edit the following line
;; ;; (setq defer-loading-jde nil)
;; ;; to read:
;; ;;
;; (setq defer-loading-jde t)
;; ;;

;; (if defer-loading-jde
;;     (progn
;;       (autoload 'jde-mode "jde" "JDE mode." t)
;;       (setq auto-mode-alist
;; 	    (append
;; 	     '(("\\.java\\'" . jde-mode))
;; 	     auto-mode-alist)))
;;   (require 'jde))



;; add C sharp support
;;(add-to-list 'load-path "~/lisp/csharp")
;;(require 'csde)


;; ;; psgml
;; (add-to-list 'load-path "~/lisp/psgml-1.2.5")
;; (require 'psgml)
;; (autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
;; (autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
;; ;; (setq auto-mode-alist
;; ;;       (union '(("\\.xml$" . sgml-mode)
;; ;; 	       ("\\.xsl$" . sgml-mode)
;; ;; 	       ) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DAS - from Curly
;; Put  gnuclientw "%1" in a shortcut to use.
;; start gnuserv stuff. Put it up front so you don't get into a
;; timeout problem when starting emacs from gnuclient or gnudoit,
;; according to Cristian Ionescu-Idbohrn
;; <cristian.ionescu-idbohrn@axis.com>
;; xemacs does its own thing, as does emacsW32
(if (and (not (boundp 'running-xemacs))
         (boundp 'gnuserv-start))
    
    (progn 
      (if (memq window-system '(win32 w32)) ; Windows NT/95
		(progn
		  ;; gnuserv.exe copied into emacs bin
		  (add-to-list 'load-path "~/lisp/gnuserv")
		  (require 'gnuserv)
		  (setq server-done-function 'bury-buffer
			gnuserv-frame (car (frame-list)))
		  (gnuserv-start)
      ;;; open buffer in existing frame instead of creating new one...
		  (setq gnuserv-frame (selected-frame))
		  (message "gnuserv started."))
      )
	  
      (if (string-equal system-type "gnu/linux")
	  (progn (server-start)
	   (message "emacsserver started.")))
      )
  )
; end gnuserv stuff

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setup the single directory backups using backup-dir
;; which is standard with Xemacs, but not with GNU
;; use custom to set the backup directory - you will
;; probably have to edit custom.el by hand.
;; backup-dir - put backups in a single directory
;; Note: need version 2.9 to support NT.
;; Note: customizing the variable, should do an implicit require.
(if (not (boundp 'bkup-backup-directory-info))
    (progn 
      (add-to-list 'load-path "~/lisp")
      (require 'backup-dir)
      (message "loading backup-dir - please customize")
      )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use templates - or not - autoinsert is enough for me!
;; Xemacs and GnuEmacs
;;(if (file-exists-p "~/.emacs.d/lisp/template.el")
;;    (load (expand-file-name "~/.emacs.d/lisp/template.el"))
;;  (require 'template)
;;  (template-initialize)
;;  )
;; for new files only
(require 'autoinsert)
(setq auto-insert-directory "~/.templates/") ; re-use the template location.
(setq auto-insert-query nil)
(define-auto-insert "\.xbel" "TEMPLATE.xbel.tpl")
(add-hook 'find-file-hooks 'auto-insert)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Xemacs ships with xslt-process, GNUEmacs doesn't
(if ds-running-xemacs-p
    (add-to-list 'load-path "~/.emacs.d/lisp/xslt-process-2.1/lisp")
  (autoload 'xslt-process-mode "xslt-process" "Emacs XSLT processing" t)
)

;; (autoload 'xslt-process-install-docbook "xslt-process"
;;  "Register the DocBook package with XSLT-process" t)

;; ;;; commented out as it puts xml mode as read-only at startup.
;; ;; (add-hook 'sgml-mode-hook 'xslt-process-mode)
;; ;; (add-hook 'xml-mode-hook 'xslt-process-mode)
;; ;; (add-hook 'xsl-mode-hook 'xslt-process-mode)

;; ;; fix psgml where it fails to call the xml mode hook properly.

;; (defadvice xml-mode (after run-xml-mode-hooks act)
;;   "Invoke `xml-mode-hook' hooks in the XML mode."
;;   (run-hooks 'xml-mode-hook))

;; ;; add tdtd mode
;; (add-to-list 'load-path "~/lisp/tdtd")




;; ;;;;;;;;;;;;;;;
;; ;; bind psgml mode to openjade
;; ;; load psgml-jade extension
;; (add-to-list 'load-path "~/lisp/ntsgml")
;; (setq
;;   sgml-command-list
;;   (list
;;    (list "Jade" "d:/apps/openjade-1.3.1 -c%catalogs -t%backend -d%stylesheet %file"
;;      'sgml-run-command t
;;      '(("jade:\\(.*\\):\\(.*\\):\\(.*\\):E:" 1 2 3)))
;;    (list "JadeTeX" "jadetex %tex"
;;      'sgml-run-command nil)
;;    (list "JadeTeX PDF" "pdfjadetex %tex"
;;      'sgml-run-command t)
;;    (list "dvips" "dvips -o %ps %dvi"
;;      'sgml-run-command nil)
;;    (list "View dvi" "yap %dvi"
;;      'sgml-run-background t)
;;    (list "View PDF" "gsview32 %pdf"
;;      'sgml-run-command nil)
;;    (list "View ps" "gsview32 %ps"
;;      'sgml-run-command nil))
;; )

;; (setq sgml-sgml-file-extension "sgml")

;; (setq sgml-dsssl-file-extension "dsl")

;; (setq sgml-expand-list
;;   (list
;;    (list "%file" 'file nil)     ; the current file as is
;;    (list "%sgml" 'file sgml-sgml-file-extension) ;   with given extension
;;    (list "%tex" 'file "tex")        ;   dito
;;    (list "%dvi" 'file "dvi")        ;   dito
;;    (list "%pdf" 'file "pdf")        ;   dito
;;    (list "%ps" 'file "ps")      ;   dito
;;    (list "%dsssl" 'file sgml-dsssl-file-extension) ;   dito
;;    (list "%dir" 'file nil t)        ; the directory part
;;    (list "%stylesheet" 'sgml-dsssl-spec) ; the specified style sheet
;;    (list "%backend" 'sgml-jade-backend) ; the selected backend
;;    (list "%catalogs" 'sgml-dsssl-catalogs 'sgml-catalog-files 'sgml-local-catalogs)
;;                     ; the catalogs listed in sgml-catalog-files and sgml-local-catalogs.
;;    )
;; )

;; (setq sgml-shell (concat ds-utils-location "/cmdproxy.exe"))
;; (setenv "PATH" (concat "d:/apps/bin/OpenJade-1.3.1/bin;" (getenv "PATH")))
;; (setenv "SGML_CATALOG_FILES" ".\catalog;d:\apps\openjade-1.3.1\dsssl\catalog")

;; (add-hook 'sgml-mode-hook '(lambda () (require 'psgml-jade)))


;; ;; enable the version control hooks



;; ;;(add-to-list 'load-path (expand-file-name (concat ds-emacs-specific-location "/sitelisp/vb-mode")))

;;VB editing
;(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
;(setq auto-mode-alist (append '(("\.\(frm\\|bas\\|ebs\\|cls\\)$" .
;                                   visual-basic-mode)) auto-mode-alist))
;; ; (autoload 'vbp-mode "visual-basic-mode" "VBP mode." t)
;; ; (setq auto-mode-alist (append '(("\.\(vbg\\|vbg\\)$" .
;; ;                                  vbp-mode)) auto-mode-alist))
;; ; (setq visual-basic-ide-pathname "E:/Program Files/DevStudio/VB/VB5.EXE")

;; ; (autoload 'vbp-mode "vbp-mode" "VBP mode." t)
;; ; (setq auto-mode-alist (append '(("\.vbp$" .
;; ;                     vbp-mode)) auto-mode-alist))

(autoload 'clipper "clipper-mode" "Clipper 87 mode" t)
(setq auto-mode-alist (append '(("\.SRC\.txt$" . clipper-mode)) auto-mode-alist))

;; ds-packages.el ends here

