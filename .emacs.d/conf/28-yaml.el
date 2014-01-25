;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; flymake-yaml
(require 'flymake-yaml)
(add-hook 'yaml-mode-hook 'flymake-yaml-load)
