(provide 'lf-package-setup)

(use-package elfeed
  :bind
  (("C-c F" . elfeed))
  :config
  (require 'elfeed)
  (require 'elfeed-goodies)
  (elfeed-goodies/setup))

(use-package elfeed-goodies
  :defer t)

(provide 'lf-integration-elfeed)
