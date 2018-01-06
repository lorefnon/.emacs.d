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
 '(initial-frame-alist (quote ((fullscreen . maximized)))))
