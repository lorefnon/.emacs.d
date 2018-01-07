(require 'lf-package-setup)

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package move-text
  :config
  (move-text-default-bindings))

(add-hook 'before-save-hook 'whitespace-cleanup)

;; Credits: Xah Lee

(defun xah-copy-file-path (&optional φdir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
Result is full path.
If `universal-argument' is called first, copy only the dir path.
URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
Version 2015-12-02"
  (interactive "P")
  (let ((ξfpath
	 (if (equal major-mode 'dired-mode)
	     (expand-file-name default-directory)
	   (if (null (buffer-file-name))
	       (user-error "Current buffer is not associated with a file.")
	     (buffer-file-name)))))
    (kill-new
     (if (null φdir-path-only-p)
	 (progn
	   (message "File path copied: 「%s」" ξfpath)
	   ξfpath
	   )
       (progn
	 (message "Directory path copied: 「%s」" (file-name-directory ξfpath))
	 (file-name-directory ξfpath))))))


(defun xah-delete-current-file ()
  "Delete the file associated with the current buffer and close the buffer.
Also push file content to `kill-ring'.
If buffer is not file, just close it, and push file content to `kill-ring'.

URL `http://ergoemacs.org/emacs/elisp_delete-current-file.html'
Version 2015-08-12"
  (interactive)
  (progn
    (kill-new (buffer-string))
    (when (buffer-file-name)
      (when (file-exists-p (buffer-file-name))
	(progn
	  (delete-file (buffer-file-name))
	  (message "Deleted: 「%s」." (buffer-file-name)))))
    (let ((buffer-offer-save nil))
      (set-buffer-modified-p nil)
      (kill-buffer (current-buffer)))))

(defun generate-buffer ()
  "Easily create temporary buffer"
  (interactive)
  (switch-to-buffer (make-temp-name "scratch")))


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


(defun lf-revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

(defun lf-move-file (new-location)
  "Write this file to NEW-LOCATION, and delete the old one."
  (interactive (list (expand-file-name
		      (if buffer-file-name
			  (read-file-name "Move file to: ")
			(read-file-name "Move file to: "
					default-directory
					(expand-file-name (file-name-nondirectory (buffer-name))
							  default-directory))))))
  (when (file-exists-p new-location)
    (delete-file new-location))
  (let ((old-location (expand-file-name (buffer-file-name))))
    (message "old file is %s and new file is %s"
	     old-location
	     new-location)
    (write-file new-location t)
    (when (and old-location
	       (file-exists-p new-location)
	       (not (string-equal old-location new-location)))
      (delete-file old-location))))

(global-set-key (kbd "C-c b n") 'generate-buffer)
(global-set-key (kbd "C-c [") 'lf-unindent-dwim)
(global-set-key (kbd "C-c ]") (lambda () (interactive) (lf-unindent-dwim -1)))
(global-set-key (kbd "C-c f r") 'lf-revert-buffer-no-confirm)
(global-set-key (kbd "C-c f ~") 'toggle-truncate-lines)
(global-set-key (kbd "C-c f x") 'xah-copy-file-path)
(global-set-key (kbd "C-c f k") 'xah-delete-current-file)
(global-set-key (kbd "C-c f m") 'lf-move-file)
(global-set-key (kbd "C-c ! ! r") 'eval-region)
(global-set-key (kbd "C-c ! ! b") 'eval-buffer)
(global-set-key (kbd "C-c /") 'comment-region)
(global-set-key (kbd "C-c \\") 'uncomment-region)

(provide 'lf-utils-editing)
