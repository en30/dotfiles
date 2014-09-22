(require 'helm-config)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-for-files)
(define-key global-map (kbd "C-M-y") 'helm-show-kill-ring)
(define-key global-map (kbd "C-M-z") 'helm-resume)
(define-key global-map (kbd "M-C-m") 'helm-man-woman)

(require 'helm-ghq)
(defconst helm-for-files-preferred-list
  '(helm-source-buffers-list
    helm-source-recentf
    helm-source-ghq
    helm-source-files-in-current-dir))

(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     (set-face-background 'helm-selection "#444444")
     (set-face-background 'helm-source-header "color-69")
     (set-face-foreground 'helm-source-header "#ffffff")))

(eval-after-load 'helm-files
  '(progn
     (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
     (define-key helm-find-files-map (kbd "C-i") 'helm-execute-persistent-action)
     (set-face-foreground 'helm-match "color-76")
     (set-face-foreground 'helm-ff-directory "brightmagenta")
     (set-face-background 'helm-ff-directory nil)))
(setq helm-ff-auto-update-initial-value nil)

(require 'helm-descbinds)
