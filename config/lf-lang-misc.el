(require 'lf-package-setup)

(use-package scss-mode
  :mode ("\\.scss?\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.scss?\\'" . scss-mode)))

(use-package markdown-mode
  :mode ("\\.markdown?\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.markdown?\\'" . markdown-mode)))

(provide 'lf-lang-misc)
