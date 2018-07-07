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

;; Don't use quelpa for melpa packages
(setq quelpa-checkout-melpa-p nil)

;; ## Bootstrap Quelpa
;;
;; https://github.com/quelpa/quelpa
;;
(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;; ## Bootstrap quelpa-use-package
(quelpa
 '(quelpa-use-package
   :fetcher github
   :repo "quelpa/quelpa-use-package"))

(require 'quelpa-use-package)

;; ## Bootstrap use-package
;;
;; Rest of the packages will auto-installed by use-package
;; but use-package itself needs to be bootstrapped
;;
;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Auto insetall packages if not present
(setq use-package-always-ensure t)

(provide 'lf-package-setup)
