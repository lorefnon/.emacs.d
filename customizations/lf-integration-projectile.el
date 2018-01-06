(require 'lf-package-setup)
(require 'lf-integration-helm)
(require 'lf-integration-neotree)

(use-package projectile
  :defer t
  :config (progn
	    (projectile-global-mode t)))

(use-package helm-projectile
  :init
  (require 'neotree)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  :bind (("C-c ." . helm-projectile)
	 ("C-c p p" . projectile-switch-project)
	 ("C-c p f" . helm-projectile-find-file-dwim)
	 ("C-c p F" . helm-projectile-find-file-in-known-projects)
	 ("C-c p r" . helm-projectile-recentf)
	 ("C-c p a" . helm-projectile-ag)
	 ("C-c p g" . helm-projectile-grep)
	 ("C-c p b" . helm-projectile-switch-to-buffer))
  :config
  (require 'helm)
  (require 'projectile)
  (require 'helm-projectile)
  (helm-projectile-on))

(provide 'lf-integration-projectile)
