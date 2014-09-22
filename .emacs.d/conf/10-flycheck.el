;; fly-check
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key (kbd "M-e") 'flycheck-next-error)
(global-set-key (kbd "M-E") 'flycheck-previous-error)

(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
