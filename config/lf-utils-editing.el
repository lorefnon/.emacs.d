(require 'lf-package-setup)

;; Enforce UTF-8 as the default coding system for all files, comint processes and buffers.
;;
;; Refer: https://www.masteringemacs.org/article/working-coding-systems-unicode-emacs
(prefer-coding-system 'utf-8)

(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

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

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package s)
(use-package f)
(use-package dash)

(use-package disable-mouse
  :bind
  (("C-c m m" . global-disable-mouse-mode)))

(add-hook 'before-save-hook 'whitespace-cleanup)

(global-set-key (kbd "C-c i s") (lambda () (interactive) (insert "Ψ")))

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

(global-set-key (kbd "C-c [") 'lf-unindent-dwim)
(global-set-key (kbd "C-c ]") (lambda () (interactive) (lf-unindent-dwim -1)))
(global-set-key (kbd "C-c f ~") 'toggle-truncate-lines)
(global-set-key (kbd "C-c ! ! r") 'eval-region)
(global-set-key (kbd "C-c ! ! b") 'eval-buffer)
(global-set-key (kbd "C-c /") 'comment-region)
(global-set-key (kbd "C-c \\") 'uncomment-region)
(global-set-key (kbd "C-c \\") 'uncomment-region)
(global-set-key (kbd "C-<return>") 'cua-rectangle-mark-mode)

(provide 'lf-utils-editing)
