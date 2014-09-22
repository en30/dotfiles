;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

;; ace-jump-mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-c C-SPC") 'er/expand-region)
(global-set-key (kbd "C-c C-M-SPC") 'er/contract-region)
