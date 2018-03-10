(require 'lf-package-setup)

(defun lf-css-to-js ()
  (interactive)
  (let ((str (filter-buffer-substring (mark) (point) t)))
    (insert
     (mapconcat
      (lambda (line)
        (let ((parts (s-split ":" line)))
          (if (= (length parts) 2)
              (s-concat
               (s-lower-camel-case (car parts))
               ": "
               (s-concat "\"" (s-trim (car (cdr parts))) "\""))
            line)))
      (s-split ";" str)
      ",\n"))))

(provide 'lf-css-to-js)
