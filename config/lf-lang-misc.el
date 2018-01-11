(require 'lf-package-setup)

(use-package scss-mode
  :mode ("\\.scss?\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.scss?\\'" . scss-mode)))

(use-package markdown-mode
  :mode ("\\.markdown?\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.markdown?\\'" . markdown-mode)))

(use-package fsharp-mode
  :mode ("\\.fsx?\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.fsx?\\'" . fsharp-mode)))

(provide 'lf-lang-misc)
