;; js2-mode
;; (autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'js2-mode-hook
          #'(lambda()
              (require 'js)
              (setq js-indent-level 2
                    js-expr-indent-offset 2
                    indent-tabs-mode nil)
              (defun my-js-indent-line()
                (interactive)
                (let* ((parse-status (save-excursion (syntax-ppss (point-at-bol))))
                       (offset (- (current-column) (current-indentation)))
                       (indentation (js--proper-indentation parse-status)))
                  (back-to-indentation)
                  (if (looking-at "case\\s-")
                      (indent-line-to (+ indentation 2))
                    (js-indent-line))
                  (when (> offset 0) (forward-char offset))))
              (set (make-local-variable 'indent-line-function) 'js-indent-line)))
