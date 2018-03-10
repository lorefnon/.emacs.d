(require 'lf-package-setup)
(require 'lf-integration-helm)
(require 'lf-integration-neotree)

(use-package projectile
  :defer t
  :config
  (progn
    (projectile-global-mode t)))

(use-package helm-projectile

  :init
  (require 'neotree)

  (defun lf-projectile-action ()
      "Open dired and neotree when switching projects"
      (interactive)
      (let ((root (projectile-project-root)))
        (neotree-dir root)
        (dired root)))

  (defun lf-helm-projectile-do-with-file (action)
    "Perform action for file found through projectile"
    (let* ((project-root (projectile-project-root))
           (project-files (projectile-select-files (projectile-current-project-files))))
      (helm :sources (helm-build-sync-source "Projectile files"
                       :candidates (helm-projectile--files-display-real project-files project-root)
                       :fuzzy-match helm-projectile-fuzzy-match
                       :action action)
            :buffer "*helm projectile*"
            :truncate-lines helm-projectile-truncate-lines
            :prompt (projectile-prepend-project-name  "Find file :"))))

  (defun lf-helm-projectile-kill-file-path ()
    "Kill path of file found through helm in current project"
    (interactive)
    (lf-helm-projectile-do-with-file 'kill-new))

  (defun lf-kill-rel-path (path)
    "kill path relative to current buffer's file"
    (kill-new (f-relative path (buffer-file-name))))

  (defun lf-helm-projectile-kill-rel-file-path ()
    "Kill relative path of file found through helm in current project"
    (interactive)
    (lf-helm-projectile-do-with-file 'lf-kill-rel-path))

  (defun lf-f-relative (path1 path2)
    (let* ((rel-path (f-relative path1 path2))
           (is-rel (s-matches? "^\\.\\./" rel-path)))
      (if is-rel rel-path (s-concat "./" rel-path))))

  (defun lf-insert-rel-path (path)
      "Insert base path of file relative to current buffer's file"
      (insert (f-no-ext (lf-f-relative path (f-dirname (buffer-file-name))))))

  (defun lf-helm-projectile-insert-rel-path ()
    "Insert path of file in project found through helm relative to current buffer's file"
    (interactive)
    (lf-helm-projectile-do-with-file 'lf-insert-rel-path))

  (setq projectile-switch-project-action 'lf-projectile-action)

  :bind
  (("C-c ." . helm-projectile)
   ("C-." . helm-projectile)
   ("C-c p ." . lf-projectile-action)
   ("C-c p p" . projectile-switch-project)
   ("C-c p f" . helm-projectile-find-file-dwim)
   ("C-c p F" . helm-projectile-find-file-in-known-projects)
   ("C-c p r" . helm-projectile-recentf)
   ("C-c p g" . helm-projectile-grep)
   ("C-c p b" . helm-projectile-switch-to-buffer)
   ("C-c p w" . lf-helm-projectile-kill-rel-file-path)
   ("C-c p W" . lf-helm-projectile-kill-file-path)
   ("C-c p ~ ." . lf-helm-projectile-insert-rel-path)
   ("C-c p ~ /" . lf-helm-projectile-insert-path))

  :config
  (require 'helm)
  (require 'projectile)
  (require 'helm-projectile)
  (helm-projectile-on))

(provide 'lf-integration-projectile)
