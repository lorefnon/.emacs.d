(defun lf-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun lf-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'lf-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'lf-minibuffer-exit-hook)

(provide 'lf-config-gc)
