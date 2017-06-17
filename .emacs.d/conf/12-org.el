(require 'org)
(require 'org-habit)

(setq
 org-agenda-files (list "~/org")
 org-agenda-sticky t
 org-agenda-custom-commands '(("D" "Daily Action List"
                               ((agenda "" ((org-agenda-ndays 1)
                                            (org-agenda-sorting-strategy
                                             '((agenda time-up priority-down tag-up)))
                                            (org-deadline-warning-days 0)))))
                              ("W" "Weekly agenda with reading books"
                               ((agenda "" ((org-agenda-ndays 7)))
                                (tags "READING")))
                              ("R" "Weekly Review"
                               ((agenda "" ((org-agenda-ndays 7)))
                                (todo "TODO")
                                (todo "SOMEDAY"))))
 org-capture-templates '(("t" "Todo" entry
                          (file+headline "~/org/gtd.org" "Tasks")
                          "* TODO %?\n   %i\n   %t")
                         ("m" "Random memo" entry
                          (file+headline "~/org/memo.org" "Memo")
                          "* %?\n   %i\n   %t")
                         ("i" "New Ideas" entry
                          (file+headline "~/org/memo.org" "Idea")
                          "* %?\n   %i\n   %t"))
 org-clock-persist t
 org-clock-out-remove-zero-time-clocks t
 org-extend-today-until 6
 org-log-done t
 org-refile-targets '(("gtd.org" :maxlevel . 1)
                      ("someday.org" :level . 2))
 org-src-fontify-natively t
 calendar-holidays nil)

(global-set-key (kbd "C-c c") 'org-capture)

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
(set-face-foreground 'org-agenda-date "blue")
(set-face-foreground 'org-agenda-done "green")
(set-face-foreground 'org-agenda-date-today "color-63")
(set-face-foreground 'org-agenda-date-weekend "#F2BA9B")
(set-face-foreground 'org-column-title "#000000")

;; auto-insert
(add-to-list 'auto-insert-alist
             '("\\.org$" . "template.org"))

;; pomodoro
(require 'org-timer)
(setq org-timer-default-timer 1
      org-clock-sound "/System/Library/Sounds/Glass.aiff"
      org-yapomodoro-state nil
      org-yapomodoro-cycle '((:pomodoro 50)
                             (:short-break 10)
                             (:pomodoro 50)
                             (:short-break 10)
                             (:pomodoro 50)
                             (:short-break 10)
                             (:pomodoro 50)
                             (:long-break 30)))

(defun org-yapomodoro-step ()
  (with-current-buffer
      (marker-buffer (car org-clock-history))
    (org-timer-set-timer (cadar org-yapomodoro-incoming-states))
    (setq org-yapomodoro-state (caar org-yapomodoro-incoming-states)
          org-yapomodoro-incoming-states (cdr org-yapomodoro-incoming-states))
    (if (eq org-yapomodoro-state :pomodoro)
        (org-clock-in-last)
      (let ((org-clock-out-hook (remq 'org-yapomodoro-stop org-clock-out-hook)))
        (org-clock-out)))))

(defun org-yapomodoro-start ()
  (org-clock-play-sound)
  (setq org-yapomodoro-incoming-states (copy-tree org-yapomodoro-cycle))
  (nconc org-yapomodoro-incoming-states org-yapomodoro-incoming-states)
  (org-yapomodoro-step))

(defun org-yapomodoro-stop ()
  (interactive)
  (setq org-yapomodoro-state nil)
  (org-yapomodoro-flush-tmux)
  (with-current-buffer
      (marker-buffer (car org-clock-history))
    (if (org-clock-is-active)
        (org-clock-out)))
  (org-timer-stop))

(defun org-yapomodoro-update-tmux ()
  (unless org-timer-pause-time
    (let* ((tmux-file "~/.pomodoro")
           (bg-colour (if (eq org-yapomodoro-state :pomodoro) "colour225" "colour195"))
           (status (if (eq org-yapomodoro-state :pomodoro)
                       org-clock-heading
                     (replace-regexp-in-string ":" "" (symbol-name org-yapomodoro-state))))
           (content (format "#[bg=%s] \U0001F345 #[fg=colour24] %s | %s"
                            bg-colour (org-timer-value-string) status)))
      (write-string-to-file content tmux-file))))

(defun org-yapomodoro-flush-tmux ()
  (message "flushed")
  (write-string-to-file "" "~/.pomodoro"))

(advice-add 'org-timer-update-mode-line :after 'org-yapomodoro-update-tmux)

(add-hook 'org-clock-in-hook (lambda ()
                               (unless org-yapomodoro-state
                                 (org-yapomodoro-start))))

(add-hook 'org-clock-out-hook 'org-yapomodoro-stop)
(add-hook 'org-timer-done-hook 'org-yapomodoro-step)
