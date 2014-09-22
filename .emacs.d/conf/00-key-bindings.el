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
(global-set-key (kbd "C-x C-0") 'kill-buffer-and-window)

;; delete-window
(global-set-key (kbd "C-x 0") 'delete-window)

;; wind move
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(if (equal "xterm" (tty-type)) (define-key input-decode-map "\e[1;2A" [S-up]))

;; format (indent all)
(global-set-key (kbd "C-x f") '(lambda() "" (interactive) (indent-region (point-min) (point-max))))

;; delete
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-x C-h") 'backward-kill-sentence)

;; % で対応する括弧に移動
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(define-key global-map (kbd "%") 'match-paren)
;; pbcopy
(defun pbcopy ()
  (interactive)
  (when mark-active
    (shell-command-on-region (point) (mark) "pbcopy")
    (kill-buffer "*Shell Command Output*")
    (setq deactivate-mark t)))

(global-set-key (kbd "M-C-w") 'pbcopy)
