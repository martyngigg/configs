;;----------------------------------------------------------------------------
;; File associations
;;----------------------------------------------------------------------------
(add-auto-mode 'c++-mode "\\.C$" "\\.cc$"
               "\\.c$" "\\.h$" "\\.cpp$" "\\.cxx$" "\\.tcc$")

;;----------------------------------------------------------------------------
;; Clang-format (requires clang-format-3.6 on the path)
;;----------------------------------------------------------------------------
(require-package 'clang-format)
(global-set-key (kbd "C-x \\") 'clang-format-buffer)
(setq clang-format-executable "clang-format-3.6")

;;----------------------------------------------------------------------------
;; Handy shortcut keys
;;----------------------------------------------------------------------------
(setq compilation-read-command nil) ;; Don't prompt for command
(global-set-key "\C-x\C-m" 'compile)


;;----------------------------------------------------------------------------
;; C++ IDE Features - TODO: Tidy this up
;;---------------------------------------------------------------------------
(require-package 'auto-complete)
(package-install 'auto-complete-c-headers)

;; default setup for auto-complete
(require 'auto-complete-config)
(ac-config-default)

(require-package 'yasnippet)
(yas-global-mode 1)

(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include/c++/5")
)
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

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
