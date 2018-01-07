(require 'lf-package-setup)

(use-package avy
  :bind (("C-c j" . avy-goto-char)
	 ("C-c J" . avy-goto-line)))

(use-package winum
  :bind (("C-c w" . winum-select-window-by-number))
  :config
  (require 'winum)
  (winum-mode))

(use-package god-mode
  :bind (("C-c m g" . god-mode)))

(defun lf-utils-editing-start-line-start ()
  "Move point to beginning-of-line. If repeat command it cycle
position between `back-to-indentation' and `beginning-of-line'."
  (interactive "^")
  (if (and (eq last-command 'lf-utils-editing-start-line-start)
           (= (line-beginning-position) (point)))
      (back-to-indentation)
    (beginning-of-line)))

(global-set-key (kbd "C-a") 'lf-utils-editing-start-line-start)

(provide 'lf-utils-nav)
