(require 'lf-package-setup)

(use-package rjsx-mode
  :mode ("\\.jsx?\\'")
  :config
  (require 'js-align)
  (add-hook 'rjsx-mode 'js-align-mode))

(setq js2-strict-trailing-comma-warning nil)

(provide 'lf-lang-js)
