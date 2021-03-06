(require 'lf-package-setup)
(require 'multi-region)
(require 'highlight)

;; Enforce UTF-8 as the default coding system for all files, comint processes and buffers.
;;
;; Refer: https://www.masteringemacs.org/article/working-coding-systems-unicode-emacs
(prefer-coding-system 'utf-8)

(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; https://emacs.stackexchange.com/questions/33510/unicode-txt-slowness/33514
(setq inhibit-compacting-font-caches t)

;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Tabs -> Spaces
(setq-default indent-tabs-mode nil)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(add-hook 'find-file-hook 'linum-mode)
(add-hook 'find-file-hook 'hl-line-mode)

(setq visible-bell 1)

(delete-selection-mode 1)

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package move-text
  :config
  (move-text-default-bindings))

;; (use-package zones
;;   :quelpa (zones :fetcher url :url "https://www.emacswiki.org/emacs/download/zones.el"))

(use-package s)
(use-package f)
(use-package dash)

(use-package disable-mouse
  :bind
  (("C-c m m" . global-disable-mouse-mode)))

(add-hook 'before-save-hook 'whitespace-cleanup)

(global-set-key (kbd "C-c i s") (lambda () (interactive) (insert "Ψ")))
(global-set-key (kbd "C-c i e") (lambda () (interactive) (insert "ε")))

(use-package goto-chg
  :bind
  (("C-c <" . goto-last-change)
   ("C-c >" . goto-last-change-reverse)))

(defun lf-unindent-dwim (&optional count-arg)
  "Keeps relative spacing in the region.  Unindents to the next multiple of the current tab-width"
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning)) (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position)))
        (min-indentation)
        (count (or count-arg 1)))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (add-to-list 'min-indentation (current-indentation))
        (forward-line)))
    (if (< 0 count)
        (if (not (< 0 (apply 'min min-indentation)))
            (error "Can't indent any more.  Try `indent-rigidly` with a negative arg.")))
    (if (> 0 count)
        (indent-rigidly beg end (* (- 0 tab-width) count))
      (let (
            (indent-amount
             (apply 'min (mapcar (lambda (x) (- 0 (mod x tab-width))) min-indentation))))
        (indent-rigidly beg end (or
                                 (and (< indent-amount 0) indent-amount)
                                 (* (or count 1) (- 0 tab-width))))))))

(defun lf-disable-indentation ()
  (interactive)
  (setq electric-indent-inhibit t)
  (setq tab-width 4)
  (local-set-key (kbd "<tab>") (lambda () (interactive) (lf-unindent-dwim -1)))
  (local-set-key (kbd "<backtab>") 'lf-unindent-dwim))

;; Disable emacs indentation for models where it is badly supported
;; ===
;; (dolist (hook '(rjsx-mode-hook
;;         js-mode-hook
;;         js2-mode-hook
;;         jsx-mode-hook))
;; (add-hook hook 'lf-disable-indentation))

(electric-indent-mode -1)

(custom-set-variables
 '(js2-basic-offset 4)
 '(js2-bounce-indent-p t)
 )

;; Disable auto-backup files because I already have a version control
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(setq-default truncate-lines t)
(setq-default global-visual-line-mode t)
(setq web-mode-enable-auto-quoting nil)

;; There doesn't an operation so important that I need to type out three letters for confirmation
(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-c [") 'lf-unindent-dwim)
(global-set-key (kbd "C-c ]") (lambda () (interactive) (lf-unindent-dwim -1)))
(global-set-key (kbd "C-c f ~") 'toggle-truncate-lines)
(global-set-key (kbd "C-c ! ! r") 'eval-region)
(global-set-key (kbd "C-c ! ! b") 'eval-buffer)
(global-set-key (kbd "C-c /") 'comment-region)
(global-set-key (kbd "C-c \\") 'uncomment-region)
(global-set-key (kbd "C-c \\") 'uncomment-region)
(global-set-key (kbd "C-<return>") 'cua-rectangle-mark-mode)

(global-set-key (kbd "C-c +") 'multi-region-mark-region)
(global-set-key (kbd "C-c -") 'multi-region-unmark-region)
(global-set-key (kbd "C-c =") 'multi-region-unmark-regions)
(global-set-key (kbd "C-c *") 'multi-region-execute-command)

(provide 'lf-utils-editing)
