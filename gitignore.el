;;; gitignore.el --- autoinsert .gitignore templates            -*- lexical-binding: t; -*-

;; Copyright (C) 2017  KOBAYASHI Shigeru

;; Author: KOBAYASHI Shigeru (kosh04) <shigeru.kb@gmail.com>
;; Keywords: tools, vc
;; License: MIT

;;; Commentary:

;; Provide `auto-insert' custom templates for .gitignore
;;
;; $ git clone https://github.com/github/gitignore ~/.emacs.d/share/autoinsert/gitignore
;;
;; init.el example:
;;
;; (require 'gitignore)
;; (setq gitignore-template-directory "~/.emacs.d/share/autoinsert/gitignore/")
;; (auto-insert-mode +1)
;;
;; (with-eval-after-load 'gitignore-mode
;;   (define-key gitignore-mode-map [remap insert-file] #'gitignore-insert-template))

;;; Code:

(require 'autoinsert)

(defvar gitignore-template-directory
  (file-name-as-directory
   (expand-file-name "gitignore" auto-insert-directory))
  "Directory includes .gitignore template files.")

(defvar gitignore-insert-command
  'gitignore-insert-template
  "Command to insert templates.")

;;;###autoload
(defun gitignore-insert-template (file)
  "Insert .gitignore template from `gitignore-template-directory'."
  (interactive
   (progn
     (barf-if-buffer-read-only)
     (list (read-file-name "Insert template: " gitignore-template-directory))))
  (insert-file-contents file))

;; define once only (`define-auto-insert' is not so)

;;;###autoload
(add-to-list
 'auto-insert-alist
 (cons '("/\\.gitignore\\(?:_global\\)?\\'" . ".gitignore template")
       ;; `lambda' MUST NOT has lexical closure (closure (t) ...)
       '(lambda ()
          (call-interactively gitignore-insert-command))))

(provide 'gitignore)
;;; gitignore.el ends here
