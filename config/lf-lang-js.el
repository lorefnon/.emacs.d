(require 'lf-package-setup)

(use-package js-align
  :mode ("\\.js?\\'")
  :config
  (add-hook 'js-mode 'js-align-mode))

(use-package rjsx-mode
  :mode ("\\.jsx?\\'")
  :config
  (require 'js-align)
  (add-hook 'rjsx-mode 'js-align-mode))

(provide 'lf-lang-js)
