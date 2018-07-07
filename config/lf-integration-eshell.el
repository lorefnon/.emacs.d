(require 'lf-package-setup)

(use-package multi-eshell
  :quelpa (multi-eshell :fetcher github :repo "emacsmirror/multi-eshell")
  :bind
  (("C-c $ n" . multi-eshell)
   ("C-c $ s" . multi-eshell-switch)))

(provide 'lf-integration-eshell)
