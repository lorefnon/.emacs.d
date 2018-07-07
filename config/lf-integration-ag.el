(require 'lf-package-setup)

(use-package ag
  :bind
  (("C-c p s S" . ag-project)           ;; Search files in project root directory (without helm)
   ("C-c d s" . ag)                     ;; Search files in some directory
   ("C-c p s s" . helm-projectile-ag))) ;; Search files in project directory (with helm)

(provide 'lf-integration-ag)
