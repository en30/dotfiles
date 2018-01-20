(add-to-list 'exec-path (expand-file-name "~/bin"))

(defun my-regex-filter (my-pair)
  "Run func if filename match the regexp.  MY-PAIR is a cons cell (regexp . func)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
      (funcall (cdr my-pair)))))

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

;; projectile
(projectile-global-mode)

;; to avoid "ls does not support --dired; see `dired-use-ls-dired' for more details."
(when (eq system-type 'darwin)
  (require 'ls-lisp)
    (setq ls-lisp-use-insert-directory-program nil))

;; auto-insert
(auto-insert-mode 1)
(setq auto-insert-directory "~/.emacs.d/templates")
(add-hook 'find-file-hooks 'auto-insert)

;; alert
(setq alert-default-style 'notifier)

;; savekill
(require 'savekill)

(if (eq system-type 'darwin)
    (defun play-sound-file (file)
      (start-process "play-sound-file" nil "afplay" file)))

;; ffap
(defadvice ffap-file-at-point (after ffap-file-at-point-after-advice ())
  (if (string= ad-return-value "/")
      (setq ad-return-value nil)))
(ad-activate 'ffap-file-at-point)

;; utility
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


(require 'which-func)
(which-function-mode 1)
(setq mode-line-format (delete (assoc 'which-func-mode
                                      mode-line-format) mode-line-format)
      which-func-header-line-format '(which-func-mode ("" which-func-format)))
(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (setq mode-line-format (delete (assoc 'which-func-mode
                                          mode-line-format) mode-line-format)
          header-line-format which-func-header-line-format)))
(eval-after-load "which-func"
      '(setq which-func-modes '(emacs-lisp-mode c++-mode org-mode ruby-mode)))

(define-derived-mode ansi-compilation-mode compilation-mode "ansi compilation"
  "Compilation mode that understands ansi colors."
  (require 'ansi-color)
  (toggle-read-only 0)
  (ansi-color-apply-on-region (point-min) (point-max)))

(defun colorize-compilation (one two)
  "ansi colorize the compilation buffer."
  (ansi-compilation-mode)
 )

(setq compilation-finish-function 'colorize-compilation)

;; time tracking
(global-wakatime-mode)

;; jump to definition
(dumb-jump-mode)
