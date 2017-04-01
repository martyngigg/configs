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
;; Yasnippet
;;---------------------------------------------------------------------------
(require-package 'yasnippet)
(yas-global-mode 1)

;;----------------------------------------------------------------------------
;; Company - in-buffer completion
;;----------------------------------------------------------------------------
(require-package 'company)
(require-package 'company-irony)
(require-package 'company-c-headers)
(global-company-mode 1)

;; configure backends
(setq company-backends (delete 'company-semantic company-backends))
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-backends 'company-irony)

;; system gcc paths
(defun my:company-c-header-init ()
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/5")
)
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:company-c-header-init)
(add-hook 'c-mode-hook 'my:company-c-header-init)

;;(add-hook 'after-init-hook 'global-company-mode)
;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-idle-delay 0.2)
(setq company-auto-complete t)
(setq company-minimum-prefix-length 1)
(setq company-begin-commands '(self-insert-command))
(dolist (hook (list
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
               'c-mode-hook
               'c++-mode-hook
               'asm-mode-hook
               'sh-mode-hook
               'org-mode
               'python-mode
               ))
  (add-hook hook 'company-mode))
;; To retrieve completion candidates for your proreate a file named .dir-locals.el at your project root:
;; ((nil . ((company-clang-arguments . ("-I/home/<user>/project_root/include1/"
;;                                     "-I/home/<user>/project_root/include2/")))))

;; shortcuts
(define-key company-mode-map (kbd "M-/") 'company-complete)
(define-key company-active-map (kbd "M-/") 'company-select-next)

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
