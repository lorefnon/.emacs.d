;; # Setup Package Management

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
)

(setq package-enable-at-startup nil)
(package-initialize)

;; ## Bootstrap use-package
;;
;; Rest of the packages will auto-installed by use-package
;; but use-package itself needs to be bootstrapped
;;
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Auto insetall packages if not present
(setq use-package-always-ensure t)

(provide 'lf-package-setup)
