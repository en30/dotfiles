(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

(defun my-switch-project-hook ()
  (if (and (projectile-project-p)
           (projectile-file-exists-p "node_modules"))
      (progn (setq import-js-project-root (projectile-project-root))
             (setq flycheck-javascript-flow-executable
                   (concat (projectile-project-root) "node_modules/.bin/flow")))))

(add-hook 'flycheck-mode-hook 'my-switch-project-hook)

(add-hook 'web-mode-hook 'flow-enable-automatically)
