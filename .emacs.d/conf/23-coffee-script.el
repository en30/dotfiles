;; coffee-mode
(require 'coffee-mode)

;; デフォルトだとインデントが８スペースなので、２スペースに変更
;; http://qiita.com/items/a8d96ae95a1838500e37
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2)
 (setq coffee-tab-width 2))
(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;; flymake-coffee
(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)
