;;----------------------------------------------------------------------------
;; File associations
;;----------------------------------------------------------------------------
(add-auto-mode 'c++-mode "\\.C$" "\\.cc$"
               "\\.c$" "\\.h$" "\\.cpp$" "\\.cxx$" "\\.tcc$")

;; ;;----------------------------------------------------------------------------
;; ;; RTags - source code navigation
;; ;;----------------------------------------------------------------------------
;; ;; RTags requires RTags to be built locally and installed in /usr/local/...
;; ;; See https://skebanga.github.io/rtags-with-cmake-in-spacemacs/
;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/rtags")
;; (require 'rtags)

;; ;;----------------------------------------------------------------------------
;; ;; Irony - source code completion
;; ;;----------------------------------------------------------------------------
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

;; ;;----------------------------------------------------------------------------
;; ;; Company - in-buffer completion
;; ;;----------------------------------------------------------------------------
;; (require-package 'company-irony)
;; (require-package 'company-irony-c-headers)

;; (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;; ;;(setq company-backends (delete 'company-semantic company-backends))
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends '(company-irony-c-headers company-irony)))

;; (setq company-idle-delay 0)
;; ;;(define-key c-mode-map [(tab)] 'company-complete)
;; ;;(define-key c++-mode-map [(tab)] 'company-complete)

;; ;;----------------------------------------------------------------------------
;; ;; Flycheck - syntax checking
;; ;;----------------------------------------------------------------------------
;; (require-package 'flycheck)
;; (add-hook 'c++-mode-hook 'flycheck-mode)
;; (add-hook 'c-mode-hook 'flycheck-mode)

;; (require 'flycheck-rtags)
;; (defun my-flycheck-rtags-setup ()
;;   (flycheck-select-checker 'rtags)
;;   (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
;;   (setq-local flycheck-check-syntax-automatically nil))
;; ;; c-mode-common-hook is also called by c++-mode
;; (add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

;; (require-package 'flycheck-irony)
;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


(provide 'init-cpp-mode)
