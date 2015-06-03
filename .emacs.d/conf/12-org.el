(require 'org)
(require 'org-habit)

(setq org-log-done t)
(setq org-agenda-files (list "~/org"))

(setq org-src-fontify-natively t)

(defun my-org-archive-done-tasks ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))

;; key-bindings
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key org-mode-map (kbd "C-c $") 'my-org-archive-done-tasks)
(define-key org-mode-map (kbd "C-c C-j") 'helm-org-in-buffer-headings)

;; face
(set-face-foreground 'org-table "color-172")
(set-face-foreground 'org-hide "#000000")

;; auto-insert
(add-to-list 'auto-insert-alist
             '("\\.org$" . "template.org"))


;; org-pomodoro
(require 'org-pomodoro)

(define-key global-map (kbd "C-c C-x TAB") 'org-pomodoro)
(define-key org-mode-map (kbd "C-c C-x TAB") 'org-pomodoro)

(add-hook 'org-clock-out-hook 'org-pomodoro-kill)

(let ((types '(start killed finished short-break long-break))
      (sound "/System/Library/Sounds/Glass.aiff"))
  (mapc (lambda (type)
          (progn
            (set (intern (format "org-pomodoro-%s-sound-p" type)) t)
            (set (intern (format "org-pomodoro-%s-sound" type)) sound)))
        types))

(defun write-string-to-file (string file)
  (interactive "sEnter the string: \nFFile to save to: ")
  (with-temp-buffer
    (insert string)
    (when (file-writable-p file)
      (write-region (point-min)
                    (point-max)
                    file
                    nil
                    :quiet))))

(defun org-pomodoro-update-tmux ()
  (let* ((tmux-file "~/.pomodoro")
         (bg-colour (if (eq org-pomodoro-state :pomodoro) "colour225" "colour195"))
         (status (if (eq org-pomodoro-state :pomodoro)
                     org-clock-heading
                   (replace-regexp-in-string ":" "" (symbol-name org-pomodoro-state))))
         (content (format "#[bg=%s] \U0001F345 #[fg=colour24] %s | %s"
                          bg-colour (org-pomodoro-format-seconds) status)))
    (write-string-to-file content tmux-file)))

(defun org-pomodoro-flush-tmux ()
  (write-string-to-file "" "~/.pomodoro"))

(add-hook 'org-pomodoro-tick-hook 'org-pomodoro-update-tmux)
(add-hook 'org-pomodoro-killed-hook 'org-pomodoro-flush-tmux)
(add-hook 'org-pomodoro-break-finished-hook 'org-pomodoro)

;; temporarily overwrite buggy procedures
(defun org-pomodoro-short-break-finished ()
    "Is invoked when a break is finished.
This may send a notification and play a sound."
    (org-pomodoro-notify "Short break finished." "Ready for another pomodoro?")
    (org-pomodoro-maybe-play-sound :short-break)
    (org-pomodoro-reset)
    (run-hooks 'org-pomodoro-break-finished-hook 'org-pomodoro-short-break-finished-hook))

(defun org-pomodoro-long-break-finished ()
    "Is invoked when a long break is finished.
This may send a notification and play a sound."
    (org-pomodoro-notify "Long break finished." "Ready for another pomodoro?")
    (org-pomodoro-maybe-play-sound :long-break)
    (org-pomodoro-reset)
    (run-hooks 'org-pomodoro-break-finished-hook 'org-pomodoro-long-break-finished-hook))

(defun org-pomodoro-sound-args (type)
  "Return the playback arguments for given TYPE."
  (cl-case type
    (:start org-pomodoro-start-sound-args)
    (:pomodoro org-pomodoro-finished-sound-args)
    (:killed org-pomodoro-killed-sound-args)
    (:short-break org-pomodoro-short-break-sound-args)
    (:long-break org-pomodoro-long-break-sound-args)
    (:tick org-pomodoro-ticking-sound-args)
    (t (error "Unknown org-pomodoro sound: %S" type))))
