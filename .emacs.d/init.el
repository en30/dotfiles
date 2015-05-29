(savehist-mode 1)

(setq make-backup-files nil)

(load "saveplace")
(setq-default save-place t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; cask
(require 'cask "/usr/local/opt/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

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

;; (el-get 'sync '(
;; 	  jaspace
;; 	  ))

;; init-loader
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")
(put 'set-goal-column 'disabled nil)
