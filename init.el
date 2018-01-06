; (package-initialize)

(add-to-list 'load-path (expand-file-name "customizations" user-emacs-directory))

(require 'lf-ui-primary)
(require 'lf-package-setup)
(require 'lf-ui-theme)
(require 'lf-integration-helm)
(require 'lf-integration-magit)
(require 'lf-integration-neotree)
(require 'lf-integration-projectile)
(require 'lf-utils-editing)
(require 'lf-utils-nav)
(require 'lf-lang-ts)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (helm-itunes winum avy move-lines undo-tree use-package tide spacemacs-theme neotree magit helm-projectile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
