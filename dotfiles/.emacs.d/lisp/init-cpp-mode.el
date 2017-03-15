;; File associations
(setq auto-mode-alist (cons '("\\.C$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cc$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.c$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cpp$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cxx$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.tcc$" . c++-mode) auto-mode-alist))

;;----------------------------------------------------------------------------
;; RTags - source code navigation
;;----------------------------------------------------------------------------
;; RTags requires RTags to be built locally and installed in /usr/local/...
;; See https://skebanga.github.io/rtags-with-cmake-in-spacemacs/
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/rtags")
(require 'rtags)

;;----------------------------------------------------------------------------
;; Irony - source code completion
;;----------------------------------------------------------------------------
;; (require-package 'irony)
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; (defun my-irony-mode-hook ()
;;   (define-key irony-mode-map [remap completion-at-point]
;;     'irony-completion-at-point-async)
;;   (define-key irony-mode-map [remap complete-symbol]
;;     'irony-completion-at-point-async))

;; (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


(provide 'init-cpp-mode)
