(standard-display-ascii ?\t "^I")
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(electric-pair-mode 1)

(defun better-upcase (beg end)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (if (and beg end)
      (upcase-region beg end)
    (upcase-word 1)))
(define-key global-map (kbd "M-u") 'better-upcase)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

;; expand-region
(require 'expand-region)
(define-key global-map (kbd "C-M-@") 'er/expand-region)

;; multiple-cursors
(require 'multiple-cursors)
(defvar ctl-q-map (make-keymap))
(define-key global-map (kbd "C-q") ctl-q-map)
(smartrep-define-key
    global-map "C-q" '(("C-n" . 'mc/mark-next-like-this)
                       ("C-p" . 'mc/mark-previous-like-this)
                       ("*"   . 'mc/mark-all-like-this)))
(define-key global-map (kbd "C-q C-e") 'mc/edit-lines)

;; ace-jump-mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-q C-j") 'ace-jump-mode)

;; regexp
(require 'visual-regexp)
(require 'visual-regexp-steroids)
(define-key global-map (kbd "C-c C-r") 'vr/query-replace)
(define-key global-map (kbd "C-c RET") 'vr/mc-mark)

(add-hook 'before-save-hook '(lambda()
                               (delete-trailing-whitespace)))

(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map (kbd "C-f") 'ido-next-match)
            (define-key ido-completion-map (kbd "C-b")   'ido-prev-match)))

;; yasnippet
(add-to-list 'load-path
             "~/.emacs.d/snippets")
(require 'yasnippet)
(yas-global-mode 1)
(defun my-yas/prompt (prompt choices &optional display-fn)
  (let* ((names (loop for choice in choices
                      collect (or (and display-fn (funcall display-fn choice))
                                  choice)))
         (selected (helm-other-buffer
                    `(((name . ,(format "%s" prompt))
                       (candidates . names)
                       (action . (("Insert snippet" . (lambda (arg) arg))))))
                    "*helm yas/prompt*")))
    (if selected
        (let ((n (position selected names :test 'equal)))
          (nth n choices))
      (signal 'quit "user quit!"))))
(custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
(define-key yas-minor-mode-map (kbd "M-=") 'yas-insert-snippet)
(setq yas/triggers-in-field t)
