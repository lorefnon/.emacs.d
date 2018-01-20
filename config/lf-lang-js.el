(require 'lf-package-setup)

(use-package rjsx-mode
  :mode ("\\.jsx?\\'")
  :config
  (require 'js-align)
  (add-hook 'rjsx-mode 'js-align-mode))

(provide 'lf-lang-js)
