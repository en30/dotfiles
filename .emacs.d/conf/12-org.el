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

(defun thyme-start ()
  (let ((args
         (list "-d"
               "--name" org-clock-heading)))
    (apply #'call-process "thyme" nil nil nil args)))

(defun thyme-stop ()
  (call-process
   "kill" nil nil nil
   (shell-command-to-string "cat ~/.thyme-pid")))

(add-hook 'org-clock-in-hook 'thyme-start)
(add-hook 'org-clock-out-hook 'thyme-stop)
