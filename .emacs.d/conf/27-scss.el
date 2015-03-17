;; scss-mode
(defun my-css-electric-pair-brace ()
  (interactive)
  (insert "{")(newline-and-indent)
  (newline-and-indent)
  (insert "}")
  (indent-for-tab-command)
  (previous-line)(indent-for-tab-command)
  )

(defun my-semicolon-ret ()
  (interactive)
  (insert ";")
  (newline-and-indent))

(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.\\(scss\\|css\\)\\'" . scss-mode))
(add-hook 'scss-mode-hook 'ac-css-mode-setup)
(add-hook 'scss-mode-hook
          (lambda ()
            (setq scss-compile-at-save nil)
            (setq css-indent-offset 2)
            (setq scss-compile-at-save nil)
            (setq scss-indent-offset 2)
            (setq ac-sources '(ac-source-yasnippet
                               ;; ac-source-words-in-same-mode-buffers
                               ac-source-words-in-all-buffer
                               ac-source-dictionary
                               ))
            ))
(add-to-list 'ac-modes 'scss-mode)
