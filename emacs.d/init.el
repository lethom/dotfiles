
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'org)
(org-babel-load-file
  (expand-file-name "emacs.d.org"
                    user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("444238426b59b360fb74f46b521933f126778777c68c67841c31e0a68b0cc920" "086970da368bb95e42fd4ddac3149e84ce5f165e90dfc6ce6baceae30cf581ef" "3a08ee881d819097b23b593d8d7d966e34bad2e6b41035cf12fe200e662b7b2f" default)))
 '(fci-rule-color "#4C566A")
 '(package-selected-packages
   (quote
    (nordless-theme elfeed yaml-mode writeroom-mode use-package tuareg tide tao-theme racer purescript-mode psc-ide projectile perspective paren-face nlinum nanowrimo markdown-mode magit lua-mode intero highlight-chars helm flycheck-rust flycheck-irony fill-column-indicator evil-numbers evil dtrt-indent dired+ diff-hl company-racer company-irony company-coq cargo auctex alchemist))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
