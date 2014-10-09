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

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))
