(require 'lf-package-setup)

(use-package avy
  :bind
  (("C-c j" . avy-goto-char)
   ("C-c J" . avy-goto-line)))

(use-package switch-window
  :bind
  (("C-c w w" . switch-window)
   ("C-c w W" . switch-window-then-maximize)))

(use-package ag
  :bind
  (("C-c S" . ag)
   ("C-c p s" . ag-project)))

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

(recentf-mode 1)
(setq recentf-max-menu-items 25)

(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

(defun lf-find-test-path-for-src-path (src-path)
  "Get test path for source path"
  (let* ((p1 (s-replace "/src" "/test" src-path))
         (ext (f-ext src-path))
         (repl-suffix-regex (s-concat  "\\." ext "$"))
         (repl-new-suffix (s-concat "_spec." ext ))
         (p2 (s-replace-regexp repl-suffix-regex repl-new-suffix p1)))
    p2))

(defun lf-find-src-path-for-test-path (src-path)
  "Get test path for source path"
  (let* ((p1 (s-replace "/test" "/src" src-path))
         (ext (f-ext src-path))
         (repl-suffix-regex (s-concat  "_spec\\." ext "$"))
         (repl-new-suffix (s-concat "." ext ))
         (p2 (s-replace-regexp repl-suffix-regex repl-new-suffix p1)))
    p2))

(defun lf-test-file? (path)
  "Detect if file is test file"
  (or
   (s-contains? "/test" path)
   (s-contains? "_spec" path)))

(defun lf-nav-src-to-test ()
  "Jump to test file for current source file"
  (interactive)
  (find-file (lf-find-test-path-for-src-path (buffer-file-name))))

(defun lf-nav-test-to-src ()
  "Jump to source file for current test file"
  (interactive)
  (find-file (lf-find-src-path-for-test-path (buffer-file-name))))

(defun lf-nav-test-src-dwim ()
  "Jump between source and test file"
  (interactive)
  (if (lf-test-file? (buffer-file-name))
      (lf-nav-test-to-src)
    (lf-nav-src-to-test)))

(global-set-key (kbd "C-c G T") 'lf-nav-src-to-test)
(global-set-key (kbd "C-c G S") 'lf-nav-test-to-src)
(global-set-key (kbd "C-c G .") 'lf-nav-test-src-dwim)

(provide 'lf-utils-nav)
