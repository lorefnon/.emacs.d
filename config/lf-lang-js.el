(require 'lf-package-setup)
(require 'lf-integration-flycheck)

(setq js2-strict-trailing-comma-warning nil)

(defun lf-use-local-eslint ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/.bin/eslint"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))


(defun setup-js2-mode ()
  (lf-use-local-eslint)
  (setq flycheck-disabled-checkers '(javascript-jshint))
  (setq flycheck-highlighting-mode 'lines)
  (require 'flycheck)
  (flycheck-select-checker 'javascript-eslint)
  (flycheck-mode))

(use-package rjsx-mode
  :mode ("\\.jsx?\\'")
  :init
  (add-hook 'rjsx-mode-hook #'setup-js2-mode))

(use-package
  js2-mode
  :ensure t
  :mode ("\\.js\\'")
  :init
  (setq flycheck-highlighting-mode 'lines)
  (add-hook 'js2-mode-hook #'setup-js2-mode))

(provide 'lf-lang-js)
