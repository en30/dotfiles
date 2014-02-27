(define-key c++-mode-map (kbd "C-c C-c") 'compile)
(define-key c++-mode-map (kbd "C-c C-k") 'kill-compilation)
(add-hook 'c++-mode-hook
	  (lambda ()
	    (unless (or (file-exists-p "makefile")
			(file-exists-p "Makefile"))
	      (set (make-local-variable 'compile-command)
		   (concat "g++ -Wall -O2 "
			   buffer-file-name
			   " && ./a.out"
			   )))))
