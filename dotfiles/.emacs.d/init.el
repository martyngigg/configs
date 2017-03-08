;; This file bootstraps the configuration, which is divided into
;; a number of other files.

(let ((minver "23.3"))
  (when (version<= emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
(defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))
;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-gui-frames)
(require 'init-themes)

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))

;; ;; ---------------------------------------------------------------------
;; ;; Packages
;; ;; ---------------------------------------------------------------------
;; (use-package color-theme-sanityinc-solarized
;;   :ensure color-theme-sanityinc-solarized)
;; ;; Load light solarized theme without prompt
;; (load-theme 'sanityinc-solarized-dark t)

;; ;; ---------------------------------------------------------------------
;; ;; Configuration
;; ;; ---------------------------------------------------------------------
;; ;; Inhibit splash screen
;; (setq inhibit-splash-screen t)

;; ;; Modules
;; (add-to-list 'load-path "~/.emacs.d/elpa")

;; ;; Backup files go into a common directory
;; (setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))

;; ;; Change save interval from 300 to 1000
;; ;; keystrokes so it isn't so annoying
;; (setq auto-save-interval 1000)

;; ;; Remove the toolbar
;; (tool-bar-mode -1)

;; ;;Disable ctrl-z behaviour
;; (global-set-key "\C-z" nil)

;; ;; Enable syntax highlighting for appropriate modes
;; (global-font-lock-mode t)
;; ;; Enable visual feedback upon selection
;; (setq transient-mark-mode t)
;; ;; Enable column number mode
;; (setq column-number-mode t)

;; ;; Set-up some keys globally
;; (global-set-key "\C-xl" 'goto-line)
;; (global-set-key "\C-cu" 'uncomment-region)
;; (global-set-key "\C-ci" 'indent-region)
;; (global-set-key [f3] 'grep-find)
;; ;; Tell grep-find to ignore svn directories
;; (setq grep-find-command
;;   "find . -path '*/.svn' -prune -o -type f -print | xargs -e grep -I -n -e ")

;; (require 'cl) ;;gives unless command
;; ;; Needed to get bash ctrl-left/ctrl-right working
;; (unless window-system
;;   (global-set-key "\e[;5D" 'backward-word)
;;   (global-set-key "\e[5C" 'forward-word)
;;   (global-set-key "\e[1;5F" 'end-of-buffer)
;;   (global-set-key "\e[1;5H" 'beginning-of-buffer))

;; ;;turn on mouse wheel
;; (if (load "mwheel" t)
;; 	(mwheel-install))

;; ;;ask about newline at end of text files
;; (setq require-final-newline 'query)

;; ;; Remove trailing whitespace upon saving
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ;; Load british dictionary by default with my preferences file
;; (setq ispell-dictionary "british")

;; ;; File associations
;; ;; C++
;; (setq auto-mode-alist (cons '("\\.C$" . c++-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.cc$" . c++-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.c$" . c++-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.cpp$" . c++-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.cxx$" . c++-mode) auto-mode-alist))
;; ;; Markdown
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ;; Use kramdown & GFM input for markdown
;; (setq markdown-command "kramdown -i GFM")

;; ;; Set BSD style indent with a default of 2 spaces per tab for global things
;; (setq c-default-style "bsd"
;;       c-basic-offset 2)

;; ;; Turn off use of tabs for indentation in many modes
;; (setq indent-tabs-mode nil)

;; ;; If indent-tabs-mode is off, untabify before saving
;; ;; (add-hook 'write-file-hooks
;; ;;           (lambda ()
;; ;; 	    (if (not indent-tabs-mode)
;; ;; 		(untabify (point-min) (point-max)))))

;; ;; LaTeX mode
;; (add-hook 'latex-mode-hook
;; 	  '(lambda()
;; 	     (setq indent-tabs-mode nil)
;; 	     ))
;; ;; C mode
;; (add-hook 'c-mode-hook
;; 	  '(lambda()
;; 	     (setq indent-tabs-mode nil)
;; 	     ))
;; ;; C++ mode
;; (add-hook 'c++-mode-hook
;; 	  '(lambda()
;; 	     (setq indent-tabs-mode nil)
;; 	     ))
;; ;; CMake mode
;; (add-hook 'cmake-mode-hook
;; 	  '(lambda()
;; 	     (setq indent-tabs-mode nil)
;; 	     ))
;; ;; Python mode
;; (add-hook 'python-mode-hook
;; 	  '(lambda()
;; 	     (setq indent-tabs-mode nil)
;; 	     ))
;; ;; Fortran mode
;; (add-hook 'fortran-mode-hook
;; 	  '(lambda()
;; 	     (setq indent-tabs-mode nil)
;; 	     ))
;; ;; perl mode
;; (add-hook 'perl-mode-hook
;; 	  '(lambda()
;; 	     (setq indent-tabs-mode nil)
;; 	     ))
;; ;; Lisp mode
;; (add-hook 'lisp-mode-hook
;; 	  '(lambda()
;; 	     (setq indent-tabs-mode nil)
;; 	     ))
