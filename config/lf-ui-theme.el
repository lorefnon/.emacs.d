(require 'lf-package-setup)

;; # Setup Primary Theme
(use-package spacemacs-theme
  :load-path "themes"
  :config
  (load-theme 'spacemacs-dark-theme t)
  :no-require t)

(provide 'lf-ui-theme)
