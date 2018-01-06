(require 'lf-package-setup)

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package move-text
  :config
  (move-text-default-bindings))

(global-set-key (kbd "C-c ! ! r") 'eval-region)
(global-set-key (kbd "C-c ! ! b") 'eval-buffer)

(provide 'lf-utils-editing)
