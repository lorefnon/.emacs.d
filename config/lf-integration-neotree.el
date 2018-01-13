(require 'lf-package-setup)

(use-package neotree
  :bind (("C-c n t" . neotree-toggle)
	 ("C-c n f" . neotree)
	 ("C-c n ." . neotree-projectile-action)))

(provide 'lf-integration-neotree)
