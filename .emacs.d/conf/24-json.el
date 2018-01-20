;; json-mode
(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-hook 'json-mode-hook
          (lambda ()
            (hs-minor-mode)
            (make-variable-buffer-local 'js-indent-level)
            (setq js-indent-level 2)))

(add-to-list 'hs-special-modes-alist '(json-mode "{" "}" "/[*/]" nil nil))
