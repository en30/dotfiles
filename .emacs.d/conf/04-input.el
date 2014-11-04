(add-hook 'before-save-hook 'delete-trailing-whitespace)

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
(define-key global-map (kbd "C-M-@") 'er/expand-region)

;; multiple-cursors
(require 'multiple-cursors)
(define-key global-map (kbd "C-M-e") 'mc/edit-lines)

(defvar ctl-q-map (make-keymap))
(define-key global-map (kbd "C-q") ctl-q-map)
(smartrep-define-key
    global-map "C-q" '(("C-n" . 'mc/mark-next-like-this)
		       ("C-p" . 'mc/mark-previous-like-this)
		       ("*"   . 'mc/mark-all-like-this)))

;; regexp
(require 'visual-regexp)
(require 'visual-regexp-steroids)
(define-key global-map (kbd "C-c C-r") 'vr/query-replace)
(define-key global-map (kbd "C-c RET") 'vr/mc-mark)
