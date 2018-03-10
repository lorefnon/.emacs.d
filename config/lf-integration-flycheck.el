(require 'lf-package-setup)

(use-package flycheck
  :bind
  (("C-c m f" . global-flycheck-mode))
  :config
  (require 'helm-flycheck))

(use-package helm-flycheck
  :defer t)

(provide 'lf-integration-flycheck)
