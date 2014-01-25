;; php-mode
(require'php-mode)
(setq php-mode-force-pear t)

;; flymake
(require 'flymake-php)
(add-hook 'php-mode-hook 'flymake-php-load)

;; mmm-mode in php
(require 'mmm-mode)
(setq mmm-submode-decoration-level 2)
					;(invert-face 'mmm-default-submode-face t)
(setq mmm-font-lock-available-p t)
(setq mmm-global-mode 'maybe)
(set-face-background 'mmm-default-submode-face nil)
(mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php)
(mmm-add-mode-ext-class 'html-mode "\\.ctp\\'" 'html-php)
(mmm-add-classes
 '((html-php
    :submode php-mode
    :front "<\\?\\(php\\)?"
    :back "\\?>")))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.ctp?\\'" . html-mode))
(defun save-mmm-c-locals ()
  (with-temp-buffer
    (php-mode)
    (dolist (v (buffer-local-variables))
      (when (string-match "\\`c-" (symbol-name (car v)))
	(add-to-list 'mmm-save-local-variables `(,(car v) nil, mmm-c-derived-modes))))))
(save-mmm-c-locals)
