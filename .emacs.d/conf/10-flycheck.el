;; fly-check
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key (kbd "M-e") 'flycheck-next-error)
(global-set-key (kbd "M-E") 'flycheck-previous-error)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode)
  '(custom-set-variables
    '(flycheck-clang-language-standard "c++11")))

(setq-default flycheck-disabled-checkers '(ruby-rubylint))

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
