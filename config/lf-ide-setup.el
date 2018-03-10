(require 'lf-package-setup)

(defun lf-activate-ide ()
  "Activate features useful when editing projects"
  (interactive)
  (projectile-global-mode t)
  (global-flycheck-mode t)
  (yas-global-mode t)
  (global-company-mode t))

(global-set-key (kbd "C-c ! ! !") 'lf-activate-ide)

(provide 'lf-ide-setup)
