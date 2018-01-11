(require 'lf-package-setup)

(use-package avy
  :bind (("C-c j" . avy-goto-char)
	 ("C-c J" . avy-goto-line)))

(use-package switch-window
  :bind (("C-x w w" . switch-window)
	 ("C-x w W" . switch-window-then-maximize))
  )

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
