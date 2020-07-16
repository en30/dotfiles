;; Control-X-prefix
(global-set-key (kbd "C-]") 'Control-X-prefix)

;; scroll
(global-set-key (kbd "C-M-v") 'scroll-down-command)
(global-set-key (kbd "M-v") 'scroll-other-window)

;; kill-buffer-and-window
(global-set-key (kbd "C-x RET 0") 'kill-buffer-and-window)

;; format (indent all)
(global-set-key (kbd "C-x f") '(lambda() "" (interactive) (indent-region (point-min) (point-max))))

;; delete
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-x C-h") 'backward-kill-sentence)

;; pbcopy
(defun pbcopy ()
  (interactive)
  (when mark-active
    (shell-command-on-region (point) (mark) "pbcopy")
    (kill-buffer "*Shell Command Output*")
    (setq deactivate-mark t)))

(global-set-key (kbd "M-C-w") 'pbcopy)

;; smartrep
(require 'smartrep)
(smartrep-define-key
    global-map "C-x" '(("{" . 'shrink-window-horizontally)
                       ("}" . 'enlarge-window-horizontally)
                       ("^" . 'enlarge-window)
                       ("o" . 'other-window)
                       ("C-@" . 'pop-global-mark)))
(smartrep-define-key
    global-map "ESC" '(("b" . 'backward-word)
                       ("f" . 'forward-word)
                       ("C-b" . 'backward-sexp)
                       ("C-f" . 'forward-sexp)))

(setq set-mark-command-repeat-pop 1)

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(global-set-key (kbd "C-x C-h") 'backward-kill-line)
