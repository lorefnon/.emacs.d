(require 'lf-package-setup)

;; # Setup Primary Theme
(use-package spacemacs-theme
  :load-path "themes"
  :init
  (load-theme 'spacemacs-dark t)
  :no-require t)

(provide 'lf-ui-theme)
