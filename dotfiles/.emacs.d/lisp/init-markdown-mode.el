;; File associations
(setq auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown$" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.text$" . markdown-mode) auto-mode-alist))

(provide 'init-markdown-mode)
