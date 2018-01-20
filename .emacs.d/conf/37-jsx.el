(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (electric-pair-mode t)
  (setq-local electric-pair-pairs (append electric-pair-pairs '((?< . ?>) (?' . ?')))))

(add-hook 'web-mode-hook  'my-web-mode-hook)

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

(require 'flycheck-flow)
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-flow 'web-mode)
  (flycheck-add-next-checker 'javascript-flow '(warning . javascript-eslint))
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))

;; auto-insert
(add-to-list 'auto-insert-alist
             '("\\.jsx$" . ["template.jsx" my-replace-template-variables]))

(defvar template-replacements-alists
  '(("%camel-capital-filename%" .
     (lambda () (mapconcat 'capitalize (split-string (replace-regexp-in-string "\\..+$" "" (file-name-base (buffer-file-name))) "_") "")))))

(defun my-replace-template-variables ()
  (time-stamp)
  (mapc #'(lambda(c)
            (progn
              (goto-char (point-min))
              (replace-string (car c) (funcall (cdr c)) nil)))
        template-replacements-alists)
  (goto-char (point-max))
  (message "done."))
