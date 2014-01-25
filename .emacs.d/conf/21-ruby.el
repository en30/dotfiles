;; ruby-mode
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
				     interpreter-mode-alist))
(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; flymake-ruby
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; ruby-electric
;; endなどの補完
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; ruby-block
;; endで対応するdoをハイライトなど
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)



;; rspec-mode.el
(require 'rspec-mode)
(custom-set-variables '(rspec-use-rake-flag nil))
(global-set-key (kbd "C-c r") 'rspec-verify-single)



(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
	  (lambda ()
	    (rinari-launch)
	    (set-face-background 'erb-exec-face "black")
	    (set-face-foreground 'erb-exec-face "white")
	    (set-face-background 'erb-face "black")
	    (set-face-foreground 'erb-face "white")))
(setq auto-mode-alist
      (append '(("\\.erb$" . rhtml-mode))
	      auto-mode-alist))

;; Rinari
(require 'rinari)
(global-rinari-mode)
