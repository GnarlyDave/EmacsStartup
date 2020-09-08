;;;;;;;;;;;;;;;;;;; non-package stuff;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Frame title bar formatting to show full path of file
(setq-default
 frame-title-format
 (list
  " emacs"
  (format
   "@%s - [" (downcase (if (string-match "\\." (system-name))
			   (substring (system-name) 0 (match-beginning 0))
			 (system-name))))
  '((buffer-file-name			; File buffer
     "%f"
     (dired-directory			; Dired buffer
      dired-directory
      (revert-buffer-function		; Buffer Menu
       "%b"
       ("%b - Dir:  " default-directory))))) ; Plain buffer
  "]"
  )
 )

;;
;; my preference is to have a taller initial frame
;; depends on font and computer

(setq initial-frame-alist
      '(
	(top . 1) (left . 160)
	(width . 80) (height . 43)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					; a non audible bell
(setq visible-bell t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					; the default binding can be
					; confusing, so disable.
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					; must be after cus-face
(if (boundp 'show-paren-mode)
    (show-paren-mode 1)                 ; GNUEmacs
    (paren-set-mode 'paren)             ; XEmacs
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					; highlight search matches
(setq search-hightlight t)
(setq query-replace-highlight t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make sure we get Windows-like shifted-motion key selection behavior
;; on recent XEmacs versions.
(if (boundp 'shifted-motion-keys-select-region)
       (setq shifted-motion-keys-select-region t)
      ;; otherwise, try the pc-select package -- 
       (pc-selection-mode)
)
;; generally I set delete-selection-mode in custom.
(if (not (pending-delete-mode))
    (pending-delete-mode t)
)


;; ;; setup ediff
;; ;;
;; (if ds-use-cygwin (progn
;;     (setq ediff-diff-program (concat ds-cygwin-location "/bin/diff"))
;;     (setq ediff-custom-diff-program (concat ds-cygwin-location "/bin/diff"))
;;     (setq ediff-diff3-program (concat ds-cygwin-location "/bin/diff3"))
;;     (setq ediff-cmp-program (concat ds-cygwin-location "/bin/cmp"))
;;     (setq ediff-patch-program (concat ds-cygwin-location "/bin/patch"))
    
;;     )
;;   (progn
;;     (setq ediff-diff-program "p:/software/Gnu/diffutils-2.7/diff")
;;     (setq ediff-custom-diff-program "p:/software/Gnu/diffutils-2.7/diff")
;;     (setq ediff-diff3-program "p:/software/Gnu/diffutils-2.7/diff3")
;;     (setq ediff-cmp-program "p:/software/Gnu/diffutils-2.7/cmp")
;;     (setq ediff-patch-program "p:/software/Gnu/patch-2.5/patch")
;;     )
;;   )

;; ;; change the email address depending on where i am.
;; (if ds-at-work
;;     (progn
;;       (setq user-mail-address "redacted")
;;       )
;;   ;; else
;;   (progn
;;     (setq user-mail-address "redacted")
;;     )
;;   )

;; ;;
;; ;; setup archive manipulation
;; ;;
;; ; despite being on an NT system, I want to use infozip.
;; (setq archive-zip-use-pkzip nil)
;; (setq archive-zip-extract (list (concat ds-utils-location "/unzip.exe") "-qq" "-c"))
;; ;; add .war files to archive mode.
;; (setq auto-mode-alist (append '(("\.war$" .
;;                     archive-mode)) auto-mode-alist))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Customizations for c-mode and c++mode,
;; ;; from Mike Marting mmartin@cccglobal.com
;; (defun my-c-mode-common-hook()

;; ;; make _ not a word separator
;; (modify-syntax-entry ? _ "w" c++-mode-syntax-table)
;; (modify-syntax-entry ? _ "w" c-mode-syntax-table)
;; )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; let the minibuffer change size
;; Xemacs and gnuemacs use a mode.
(if (boundp 'resize-mini-windows)
    (setq resize-mini-windows 't)
    (resize-minibuffer-mode)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set european date style
(setq european-calendar-style t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setup the printing options

(setq ps-print-region-function 'direct-ps-print-region-function)
(setq ps-build-face-reference nil)
(setq ps-paper-type 'a4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my preference is to enter spaces not tabs.
(setq indent-tabs-mode nil)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Turn on syntax coloring for sgml
;; (cond ((fboundp 'global-font-lock-mode)
;;        ;; Turn on font-lock in all modes that support it
;;        (global-font-lock-mode t)
;;        ;; maximum colors
;;        (setq font-lock-maximum-decoration t)))

;;                                         ; done in ds-packages
;;                                         ;      ;; load sgml-mode
;;                                         ;      (autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t )

;; ;; in sgml documents, parse dtd immediately to allow immediate
;; ;; syntax coloring
;; (setq sgml-auto-activate-dtd t)

;; ;; set the default SGML declaration. docbook.dcl should work for most DTDs
;; (setq sgml-declaration "c:/user/default/sgml/dtd/docbook41/docbook.dcl")

;; ;; here we set the syntax color information for psgml
;; (setq-default sgml-set-face t)
;; ;;
;; ;; Faces.
;; ;;
;; (make-face 'sgml-comment-face)
;; (make-face 'sgml-doctype-face)
;; (make-face 'sgml-end-tag-face)
;; (make-face 'sgml-entity-face)
;; (make-face 'sgml-ignored-face)
;; (make-face 'sgml-ms-end-face)
;; (make-face 'sgml-ms-start-face)
;; (make-face 'sgml-pi-face)
;; (make-face 'sgml-sgml-face)
;; (make-face 'sgml-short-ref-face)
;; (make-face 'sgml-start-tag-face)

;; (set-face-foreground 'sgml-comment-face "dark turquoise")
;; (set-face-foreground 'sgml-doctype-face "red")
;; (set-face-foreground 'sgml-end-tag-face "blue")
;; (set-face-foreground 'sgml-entity-face "magenta")
;; (set-face-foreground 'sgml-ignored-face "gray40")
;; (set-face-background 'sgml-ignored-face "gray60")
;; (set-face-foreground 'sgml-ms-end-face "green")
;; (set-face-foreground 'sgml-ms-start-face "yellow")
;; (set-face-foreground 'sgml-pi-face "lime green")
;; (set-face-foreground 'sgml-sgml-face "brown")
;; (set-face-foreground 'sgml-short-ref-face "deep sky blue")
;; (set-face-foreground 'sgml-start-tag-face "dark green")

;; (setq-default sgml-markup-faces
;;               '((comment . sgml-comment-face)
;;                 (doctype . sgml-doctype-face)
;;                 (end-tag . sgml-end-tag-face)
;;                 (entity . sgml-entity-face)
;;                 (ignored . sgml-ignored-face)
;;                 (ms-end . sgml-ms-end-face)
;;                 (ms-start . sgml-ms-start-face)
;;                 (pi . sgml-pi-face)
;;                 (sgml . sgml-sgml-face)
;;                 (short-ref . sgml-short-ref-face)
;;                 (start-tag . sgml-start-tag-face)))

;; ;; load xml-mode 
;; (setq auto-mode-alist
;;       (append (list (cons "\\.xml\\'" 'xml-mode))
;;               auto-mode-alist))
;; (setq auto-mode-alist
;;       (append (list (cons "\\.xsd\\'" 'xml-mode))
;;               auto-mode-alist))
;; (autoload 'xml-mode "psgml" nil t)
;; (setq sgml-xml-declaration "d:\\apps\\OpenJade-1.3.1\\pubtext\\xml.dcl")


;; ;;psgml coluring end
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; more XML hacks
;; ;; (defvar i3-xml-font-lock-keywords
;; ;;   (list
;; ;;    '(" \([^> ]+\) *=" 1 font-lock-variable-name-face t)
;; ;;    '("=[ \t\n]*\(\"[^\"]+\"\)" 1 font-lock-string-face t)
;; ;;    )
;; ;;   "Additional Expressions to highlight in XML mode.  Remotely based on
;; ;; the one for psgml-html, basically an extended version of attribute
;; ;; definitions.  The remainder is fontified by psgml itself.  See
;; ;; `sgml-markup-faces' and `sgml-set-face'")
;; ;; (put 'xml-mode  'font-lock-defaults '(i3-xml-font-lock-keywords nil t))
;; ;; (put 'sgml-mode 'font-lock-defaults '(i3-xml-font-lock-keywords nil t))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; derive an html mode start

;; ;; define html mode
;; (or (assoc "\\.html$" auto-mode-alist)
;;     (setq auto-mode-alist (cons '("\\.html$" . sgml-html-mode)
;;                                 auto-mode-alist)))
;; (or (assoc "\\.htm$" auto-mode-alist)
;;     (setq auto-mode-alist (cons '("\\.htm$" . sgml-html-mode)
;;                                 auto-mode-alist)))

;; (defun sgml-html-mode ()
;;   "This version of html mode is just a wrapper around sgml mode."
;;   (interactive)
;;   (sgml-mode)
;;   (make-local-variable 'sgml-declaration)
;;   (make-local-variable 'sgml-default-doctype-name)
;;   (setq
;;    sgml-default-doctype-name    "html"
;;    sgml-declaration             "c:/user/default/sgml/dtd/html/html.dcl"
   
;;    sgml-always-quote-attributes t
;;    sgml-indent-step             4
;;    sgml-indent-data             t
;;    sgml-minimize-attributes     nil
;;    sgml-omittag                 t
;;    sgml-shorttag                t
;;    )
;;   )

;; (setq-default sgml-indent-data t)
;; (setq
;;  sgml-always-quote-attributes   t
;;  sgml-auto-insert-required-elements t
;;  sgml-auto-activate-dtd         t
;;  sgml-indent-data               t
;;  sgml-indent-step               4
;;  sgml-minimize-attributes       nil
;;  sgml-omittag                   nil
;;  sgml-shorttag                  nil
;;  )

;; ;; derive an html mode end

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; tdtd mode
;; ;; Start DTD mode for editing SGML-DTDs
;; (autoload 'dtd-mode "tdtd" "Major mode for SGML and XML DTDs.")
;; (autoload 'dtd-etags "tdtd"
;;   "Execute etags on FILESPEC and match on DTD-specific regular expressions."
;;   t)
;; (autoload 'dtd-grep "tdtd" "Grep for PATTERN in files matching FILESPEC." t)

;; ;; Turn on font lock when in DTD mode
;; (add-hook 'dtd-mode-hooks
;;           'turn-on-font-lock)

;; (setq auto-mode-alist
;;       (append
;;        (list
;;         '("\\.dcl$" . dtd-mode)
;;         '("\\.dec$" . dtd-mode)
;;         '("\\.dtd$" . dtd-mode)
;;         '("\\.ele$" . dtd-mode)
;;         '("\\.ent$" . dtd-mode)
;;         '("\\.mod$" . dtd-mode))
;;        auto-mode-alist))

;; ;; the regexp for NTEmacs etags
;; (setq dtd-etags-regex-option
;;       "--regex=\'/<!\\(ELEMENT\\|ENTITY[ \\t]+%\\|NOTATION\\|ATTLIST\\)[ \\t]+\\([^ \\t]+\\)/\\2/\'")


;; ; ;; end tdtd mode


;; ;; FIXME: doesn't seem to work the same in XEmacs
;; ;;      
;; (if ds-running-xemacs-p
;;     ()
;;     (progn 
;; (require 'info)
;; (message Info-directory-list)
;; (setq Info-directory-list nil)
;; (add-to-list 'Info-directory-list (expand-file-name "~/info"))
;; (add-to-list 'Info-directory-list (expand-file-name (concat ds-emacs-specific-location "/info")))
;; )
;; )

;; (put 'narrow-to-region 'disabled nil)


;; perl best practices settings:

;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

;; turn autoindenting on
(global-set-key "\r" 'newline-and-indent)

;; Use 4 space indents via cperl mode
(custom-set-variables
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-level 4)
'(cperl-indent-parens-as-block t)
 '(cperl-tab-always-indent t))

;; Insert spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Set line width to 78 columns...
(setq fill-column 78)
(setq auto-fill-mode t)

;; Use % to match various kinds of brackets...
;; See: http://www.lifl.fr/~hodique/uploads/Perso/patches.el
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char))))
    (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
          ((string-match "[\]})>]" prev-char) (backward-sexp 1))
          (t (self-insert-command (or arg 1))))))

;; Load an application template in a new unattached buffer...
(defun application-template-pl (  )
  "Inserts the standard Perl application template"  ; For help and info.
  (interactive "*")                                ; Make this user accessible.
  (switch-to-buffer "application-template-pl")
  (insert-file "~/lisp/.code_templates/perl_application.pl"))
;; Set to a specific key combination...
(global-set-key "\C-ca" 'application-template-pl)

;; Load a module template in a new unattached buffer...
(defun module-template-pm (  )
  "Inserts the standard Perl module template"       ; For help and info.
  (interactive "*")                                 ; Make this user accessible.
  (switch-to-buffer "module-template-pm")
  (insert-file "~/lisp/.code_templates/perl_module.pm"))
;; Set to a specific key combination...
(global-set-key "\C-cm" 'module-template-pm)

;; Expand the following abbreviations while typing in text files...
(abbrev-mode 1)

(define-abbrev-table 'global-abbrev-table '(
    ("pdbg"   "use Data::Dumper qw( Dumper );\nwarn Dumper[];"   nil 1)
    ("phbp"   "#! /usr/bin/perl -w"                              nil 1)
    ("pbmk"   "use Benchmark qw( cmpthese );\ncmpthese -10, {};" nil 1)
    ("pusc"   "use Smart::Comments;\n\n### "                     nil 1)
    ("putm"   "use Test::More 'no_plan';"                        nil 1)
    ))


(add-hook 'text-mode-hook (lambda (  ) (abbrev-mode 1)))
