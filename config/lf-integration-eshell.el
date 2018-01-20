(require 'lf-package-setup)

(use-package multi-eshell
  :bind
  (("C-c $ n" . multi-eshell)
   ("C-c $ s" . multi-eshell-switch)))

(provide 'lf-integration-eshell)
