(define-key c++-mode-map (kbd "C-c C-c") 'compile)
(define-key c++-mode-map (kbd "C-c C-k") 'kill-compilation)
(add-hook 'c++-mode-hook
	  (lambda ()
	    (unless (or (file-exists-p "makefile")
			(file-exists-p "Makefile"))
	      (set (make-local-variable 'compile-command)
		   (concat "g++ --std=c++11 -W -Wall -Wno-sign-compare -O2 '"
			   buffer-file-name
			   "' && ./a.out"
			   )))))
