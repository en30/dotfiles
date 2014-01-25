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
