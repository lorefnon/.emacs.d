(require 'lf-package-setup)

(use-package helm
  :init
  (progn
    (require 'helm-config)
    (require 'helm-swoop)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; relatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (helm-mode))
  :bind
  (("C-c h" . helm-mini)
   ("C-h a" . helm-apropos)
   ("C-x C-b" . helm-buffers-list)
   ("C-x C-f" . helm-find-files)
   ("C-x b" . helm-buffers-list)
   ("M-y" . helm-show-kill-ring)
   ("M-x" . helm-M-x)
   ("C-c o" . helm-occur)
   ("C-c s" . helm-swoop)
   ("C-c y" . helm-yas-complete)
   ("C-c f R" . helm-recentf)
   ("C-x c Y" . helm-yas-create-snippet-on-region)
   ("C-x c b" . my/helm-do-grep-book-notes)
   ("C-x c SPC" . helm-all-mark-rings))
  :config
  (set-face-attribute 'helm-source-header nil :height 0.1)
  ;; https://www.reddit.com/r/emacs/comments/2z7nbv/lean_helm_window/
  (helm-autoresize-mode 1)
  (setq helm-autoresize-max-height 30)
  (setq helm-autoresize-min-height 30)
  (setq helm-split-window-in-side-p t)
  (defun helm-insert-char ()
    (interactive)
    (helm :sources
          `((name . "Unicode char name")
            (candidates . ,(ucs-names))
            (action . insert)))))

(use-package helm-swoop
  :defer t)

(provide 'lf-integration-helm)
