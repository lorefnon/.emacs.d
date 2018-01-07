(require 'lf-package-setup)

(use-package typescript-mode
  :mode ("\\.tsx?\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode)))

(use-package tide
  :defer t
  :bind
  ("C-c t E" . tide-project-errors)
  ("C-c t f" . tide-fix)
  ("C-c t F" . tide-format)
  ("C-c t ." . tide-jump-to-definition)
  ("C-c t i" . tide-jump-to-implementation)
  ("C-c t <" . tide-jump-back))

(defun setup-tide-mode ()
  (require 'tide)
  (require 'company)
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
  (add-hook 'before-save-hook 'tide-format-before-save))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(provide 'lf-lang-ts)
