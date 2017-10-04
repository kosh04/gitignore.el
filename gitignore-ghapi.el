;;; gitignore-ghapi.el --- autoinsert .gitignore using GitHub API

;; (アクセス制限に注意)

;; Package-Requires: ((let-alist "1.0.5"))

(require 'gitignore)
(require 'json)
(require 'let-alist)

(defvar gitignore-templates
  (eval-when-compile
    (let* ((vec2list (lambda (x) (append x nil)))
           (url "https://api.github.com/gitignore/templates")
           (dat (with-temp-buffer
                  (url-insert-file-contents url)
                  (json-read))))
      (funcall vec2list dat)))
  "List of .gitignore template names.")

(defun gitignore--fetch (template)
  (let* ((url (format "https://api.github.com/gitignore/templates/%s" template))
         (dat (with-temp-buffer
                (url-insert-file-contents url)
                (json-read))))
    (let-alist dat .source)))

;;;###autoload
(defun gitignore-insert-template* (template)
  (interactive (list (completing-read "Insert template: " gitignore-templates)))
  (save-excursion
    (insert (gitignore--fetch template))))

