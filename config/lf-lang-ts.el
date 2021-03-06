(require 'lf-package-setup)

(use-package typescript-mode
  :mode ("\\.tsx?\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode)))

(use-package tide
  :defer t
  :bind
  ("C-c t E" . tide-project-errors)
  ("C-c t f ." . tide-fix)
  ("C-c t f n" . tide-fix-next-error)
  ("C-c t f p" . tide-fix-prev-error)
  ("C-c t ." . tide-jump-to-definition)
  ("C-c t i" . tide-jump-to-implementation)
  ("C-c t <" . tide-jump-back))

(defun setup-tide-mode ()
  (require 'tide)
  (require 'company)
  (require 'helm)
  (require 'helm-company)
  (interactive)
  (tide-setup)
  ;; (flycheck-mode +1)
  ;; (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)

  (setq tide-always-show-documentation t)
  (setq tide-sync-request-timeout 120)
  ;; (add-hook 'before-save-hook 'tide-format-before-save)

  (defun tide-popup-select-item (prompt list)
    (helm
     :sources
     (helm-build-sync-source prompt
       :candidates list)
     :buffer "*Tide Completion Candidates*"))

  (defun tide-fix-next-error ()
    "Move to and fix next error"
    (interactive)
    (flycheck-next-error)
    (tide-fix))

  (defun tide-fix-prev-error ()
    "Move to and fix previous error"
    (interactive)
    (flycheck-previous-error)
    (tide-fix)))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(use-package prettier-js
  :config
  (add-hook 'js2-jsx-hook 'prettier-js-mode)
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-mode-hook 'prettier-js-mode))

(use-package add-node-modules-path
  :config
  (eval-after-load 'typescript-mode
    '(progn
       (add-hook 'typescript-mode-hook #'add-node-modules-path)
       (add-hook 'typescript-mode-hook #'prettier-js-mode))))

(provide 'lf-lang-ts)
