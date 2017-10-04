;;; gitignore-io.el --- autoinsert using gitignore.io templates

;;; Commentary:

;; https://www.gitignore.io/

;;; Code:

(require 'gitignore)

(defsubst gitignore-io-url (params)
  (format "https://www.gitignore.io/api/%s" params))

(defvar gitignore-io-templates
  (eval-when-compile
    (let ((s (with-temp-buffer
               (url-insert-file-contents (gitignore-io-url "list"))
               (buffer-string))))
      (split-string s "[\n,]" t)))
  "List of the currently support gitignore.io templates.")

;;;###autoload
(defun gitignore-io-insert-template (templates)
  "Insert .gitignore template using URL `https://gitignore.io/api'."
  (interactive
   (progn
     (barf-if-buffer-read-only)
     (list (completing-read-multiple
            "Insert templates: (e.g. linux,java,...) " gitignore-io-templates))))
  (let ((params (mapconcat #'identity templates ",")))
    (insert-file-contents (gitignore-io-url params))))

;;(setq gitignore-insert-function 'gitignore-io-insert-template)

(provide 'gitignore-io)
;;; gitignore-io.el ends here
