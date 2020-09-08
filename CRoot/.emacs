;; This is only used by EmacsW32
(message (concat "Bootstrapping in " (getenv "HOMEDRIVE") (getenv "HOMEPATH")))
(setenv "HOME" (concat (getenv "HOMEDRIVE") (getenv "HOMEPATH")))
(load "~/.emacs")
