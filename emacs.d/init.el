(package-initialize)

(require 'org)
(org-babel-load-file
  (expand-file-name "emacs.d.org"
                    user-emacs-directory))
