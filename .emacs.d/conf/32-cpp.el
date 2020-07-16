(add-hook 'before-save-hook
  (lambda ()
    (when (member major-mode '(c-mode c++-mode glsl-mode))
      (progn
        (when (locate-dominating-file "." ".clang-format")
          (clang-format-buffer))
        ;; Return nil, to continue saving.
        nil))))

;; auto-insert
(add-to-list 'auto-insert-alist
             '("\\.cpp$" . "template.cpp"))
