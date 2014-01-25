(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.\\(mark\|md\\)\\'" . markdown-mode))
(add-hook 'markdown-mode-hook 'visual-line-mode)
