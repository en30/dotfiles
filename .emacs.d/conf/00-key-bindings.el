;; Control-X-prefix
(global-set-key (kbd "C-]") 'Control-X-prefix)

;; scroll
(global-set-key (kbd "C-M-v") 'scroll-down-command)
(global-set-key (kbd "M-v") 'scroll-other-window)

;; split window
(global-set-key (kbd "C-o") 'other-window-or-split)
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window 1))

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
