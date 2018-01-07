(provide 'lf-package-setup)

(use-package elfeed
  :bind
  (("C-c f" . elfeed))
  :config
  (require 'elfeed)
  (require 'elfeed-goodies)
  (require 'emojify)
  (elfeed-goodies/setup))

(use-package elfeed-goodies
  :defer t)

(use-package emojify
  :defer t)

(provide 'lf-integration-elfeed)
