(require 'helm-config)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-M-y") 'helm-show-kill-ring)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "C-M-z") 'helm-resume)

(setq helm-ff-auto-update-initial-value nil)
(define-key helm-find-files-map (kbd "C-i") 'helm-execute-persistent-action)

(require 'helm-descbinds)

;; color
(set-face-background 'helm-selection "#444444")
(set-face-background 'helm-grep-match "color-78")
(set-face-background 'helm-source-header "color-69")
(set-face-foreground 'helm-source-header "#ffffff")
