(require 'lf-package-setup)

(use-package neotree
  :bind

  (("C-c n t" . neotree-toggle)
   ("C-c n f" . neotree-find)
   ("C-c n ." . neotree-projectile-action)
   (:map neotree-mode-map
	 ("M-<RET>" . lf-neotree-enter-in-switched-window)
	 ("C-c M-w" . lf-neotree-copy-relative-path)))

  :config

  (defun lf-neotree-enter-in-switched-window ()
    (interactive)
    (let ((file (neo-buffer--get-filename-current-line)))
      (switch-window)
      (find-file file)))

  (defun lf-neotree-copy-relative-path ()
    (interactive)
    (require 'f)
    (let ((tree-file (neo-buffer--get-filename-current-line)))
      (switch-window)
      (kill-new (f-relative tree-file (f-dirname buffer-file-name))))))

(provide 'lf-integration-neotree)
