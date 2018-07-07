(require 'lf-package-setup)

(use-package company
  :init
  (progn
    (require 'color)
    (let ((bg (face-attribute 'default :background)))
      (custom-set-faces
       `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
       `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
       `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
       `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
       `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))
    (setq company-idle-delay nil))
  :config
  (global-company-mode t))

(use-package helm-company
  :after (helm company)
  :bind
  (("C-;" . helm-company)))

(provide 'lf-integration-company)
