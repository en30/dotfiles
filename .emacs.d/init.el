
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(flycheck-clang-language-standard "c++11")
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(package-selected-packages
   (quote
    (clang-format terraform-mode feature-mode dockerfile-mode indent-guide ensime company tide typescript-mode vue-mode cask epl inflections s flycheck-elm rubocop prettier-js flycheck-julia dumb-jump toml-mode elm-yasnippets elm-mode visible-mark restclient robe neotree alert async dash ess f flycheck git-commit helm helm-core inf-ruby log4e package-build visual-regexp flow-mode trr import-js ac-html ac-slime ace-jump-mode bison-mode clocker coffee-mode color-theme eldoc-extension ess-R-object-popup expand-region flycheck-pos-tip fuzzy git-gutter go-autocomplete go-eldoc go-mode gtags haml-mode haskell-mode helm-ag helm-descbinds helm-ghq helm-gtags helm-projectile iedit jade-mode json-mode json-reformat json-snatcher julia-mode lua-mode magit magit-popup markdown-mode migemo mmm-mode multiple-cursors nand2tetris org-pomodoro php-mode popup popwin processing-mode projectile rainbow-delimiters rhtml-mode rinari rspec-mode ruby-block ruby-compilation ruby-end savekill scss-mode slim-mode slime smart-cursor-color smartrep tabbar visual-regexp-steroids w3m web-mode with-editor yaml-mode yasnippet pallet init-loader)))
 '(rspec-use-rake-when-possible nil)
 '(yas-prompt-functions (quote (my-yas/prompt))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-column ((t (:background "color-236" :strike-through nil :underline nil :slant normal :weight normal))))
 '(smerge-mine ((t (:background "color-124"))))
 '(smerge-other ((t (:background "color-34"))))
 '(web-mode-html-attr-name-face ((t (:foreground "brightgreen"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "brightcyan"))))
 '(web-mode-html-tag-face ((t (:foreground "magenta")))))
(put 'downcase-region 'disabled nil)
