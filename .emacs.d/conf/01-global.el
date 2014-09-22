;; server
(require 'server)
(unless (server-running-p)
  (server-start))

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; hideshow
(load-library "hideshow")
(add-hook 'php-mode-hook 'hs-minor-mode)
(define-key hs-minor-mode-map (kbd "C-c C-t") 'hs-toggle-hiding)

;; Interacrively Do Things (highly recommended, but not strictly reauired)
(require 'ido)
(ido-mode t)

;; uiquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; default browser
(setq browse-url-browser-function 'browse-url-default-macosx-browser)
