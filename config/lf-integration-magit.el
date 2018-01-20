(require 'lf-package-setup)

(use-package magit
  :init
  :bind
  (("C-c M s" . magit-status)
   ("C-c M l" . magit-log)
   ("C-c M b" . magit-blame)))

(provide 'lf-integration-magit)
