(require 'lf-package-setup)

(use-package flycheck
  :bind
  (("C-c m f" . global-flycheck-mode))
  :config
  (global-flycheck-mode t))

(use-package helm-flycheck
  :after (helm flycheck))

(provide 'lf-integration-flycheck)
