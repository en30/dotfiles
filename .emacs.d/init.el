(savehist-mode 1)

(setq make-backup-files nil)

(load "saveplace")
(setq-default save-place t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'load-path "~/.emacs.d/elpa/")

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'cl)
(defvar installing-package-list
  '(
    ace-jump-mode
    coffee-mode
    color-theme
    eldoc-extension
    ess
    ess-R-object-popup
    expand-region
    flymake-coffee
    flymake-easy
    flymake-json
    flymake-php
    flymake-ruby
    flymake-sass
    flymake-yaml
    fuzzy
    git-gutter
    haml-mode
    helm
    helm-ag
    helm-descbinds
    highlight-current-line
    init-loader
    iedit
    js2-mode
    json-mode
    magit
    markdown-mode
    mmm-mode
    php-mode
    popwin
    processing-mode
    rainbow-delimiters
    rinari
    rspec-mode
    ruby-block
    ruby-electric
    ruby-end
    scss-mode
    slim-mode
    tabbar
    yaml-mode
    w3m
    ))
(let ((not-installed (loop for x in installing-package-list
			   when (not (package-installed-p x))
			   collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp))
  (el-get-emacswiki-build-local-recipes))

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipe")

(el-get 'sync '(
	  drill-instructor
	  jaspace
	  ))

;; init-loader
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")
(put 'set-goal-column 'disabled nil)
