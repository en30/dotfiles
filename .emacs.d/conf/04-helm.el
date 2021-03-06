(require 'helm-config)
(setq helm-projectile-fuzzy-match nil)

(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-for-files)
(define-key global-map (kbd "C-M-y") 'helm-show-kill-ring)
(define-key global-map (kbd "C-M-z") 'helm-resume)
(define-key global-map (kbd "M-C-m") 'helm-man-woman)
(define-key global-map (kbd "M-i") 'helm-imenu)

(defadvice helm-for-files (around update-helm-list activate)
  (let ((helm-for-files-preferred-list
         (helm-for-files-update-list)))
    ad-do-it))

(defun helm-for-files-update-list ()
  `(helm-source-buffers-list
    helm-source-recentf
    helm-source-ghq
    helm-source-files-in-current-dir
    helm-source-file-cache
    ,@(if (projectile-project-p)
          '(helm-source-projectile-files-list
            helm-projectile-bundle-gems-list))))

(eval-after-load 'helm-projectile
  '(progn
     (defvar helm-projectile-bundle-gems-list
       (helm-build-in-buffer-source "Bundle gems"
         :data (lambda()
                 (if (projectile-file-exists-p (expand-file-name "Gemfile" (projectile-project-root)))
                     (split-string (shell-command-to-string "bundle show --paths") "\n" t)))
         :fuzzy-match nil
         :keymap helm-find-files-map
         :help-message 'helm-ff-help-message
         :mode-line helm-read-file-name-mode-line-string
         :action helm-projectile-file-actions
         )
       "Helm source definition for bundled gems.")))

(require 'filecache)
(file-cache-add-directory-list '("~/Dropbox/org"))
(setq file-cache-filter-regexps
      (append file-cache-filter-regexps
              '("^..?$")))

(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     (set-face-background 'helm-selection "#444444")
     (set-face-background 'helm-source-header "color-69")
     (set-face-foreground 'helm-source-header "#ffffff")))

(eval-after-load 'helm-files
  '(progn
     (define-key helm-generic-files-map (kbd "C-h") 'delete-backward-char)
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

(defun projectile-helm-ag ()
  (interactive)
  (helm-ag (projectile-project-root)))
(define-key global-map (kbd "C-q C-s") 'projectile-helm-ag)

(require 'helm-projectile)
(require 'helm-ghq)
