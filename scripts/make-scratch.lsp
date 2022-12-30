(if (-any? (lambda (buf) (string= "scratchmacs" (buffer-name buf))) (buffer-list))
				(switch-to-buffer "scratchmacs")
			(vterm "scratchmacs"))
