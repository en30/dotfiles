;; highlight current line
(require 'highlight-current-line)
(highlight-current-line-on t)
(set-face-background 'highlight-current-line-face "#444444")

;; hilight paren
(show-paren-mode 1)

;; highlight reagion
(setq transient-mark-mode t)

;; color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)

(face-spec-set 'minibuffer-prompt
               '((((class color) (background light))
                  (:foreground "cyan"))
                 (t (:foreground "white"
                     :background "brown"))))

;; jaspace
(require 'jaspace)
(setq jaspace-highlight-tabs t)
(add-hook 'mmm-mode-hook 'jaspace-mmm-mode-hook)

;; popwin
(require 'popwin)
(popwin-mode 1)
(setq anything-samewindow nil)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
(push '("*rspec-compilation*" :height 20) popwin:special-display-config)

;; tabbar
(require 'tabbar)
;; ボタンの無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; ウインドウからはみ出たタブを省略して表示
(setq tabbar-auto-scroll-flag nil)
;; キーバインド
(global-set-key (kbd "C-x 4 t") 'tabbar-mode)
(global-set-key (kbd "C-x C-n") 'tabbar-forward)
(global-set-key (kbd "C-x C-p") 'tabbar-backward)
;; 色
(set-face-foreground 'tabbar-selected "color-69")
(set-face-background 'tabbar-default "#dddddd")
;; セパレータの幅
(setq tabbar-separator '(1.5))
(tabbar-mode 1)
