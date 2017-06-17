(column-number-mode t)

(eval-after-load 'hl-line
  (lambda() (set-face-background 'hl-line "#444444")))

(global-hl-line-mode 1)
(smart-cursor-color-mode 1)

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
;; (require 'jaspace)
;; (setq jaspace-highlight-tabs t)
;; (add-hook 'mmm-mode-hook 'jaspace-mmm-mode-hook)

;; popwin
(require 'popwin)
(popwin-mode 1)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config
      (append
       '(("^\*helm.+\*$" :regexp t)
         ("*rspec-compilation*" :height 20)
         ("^\*Man .+\*$" :regexp t)
         ("*Clock Task Select*" :height 20)
         ("^\*Org Agenda.+\*$" :regexp t)
         ("*Agenda Commands*")
         (org-agenda-mode :position bottom :height 15 :stick t)
         ("^CAPTURE-.+$" :regexp t)
         ("*Org Select*"))
       popwin:special-display-config))

;; visible-mark
(global-visible-mark-mode 1)
(setq visible-mark-max 2)
(setq visible-mark-faces `(visible-mark-face1 visible-mark-face2))
