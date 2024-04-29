(when (equal my-use-package-terminal "vterm")
  ;;来点终端
  (use-package vterm
    :hook(
	  vterm-mode . (lambda()
			 (display-line-numbers-mode 0)
			 ))

    )
  (use-package vterm-toggle)

  (defun toggle-terminal()
    (interactive)
    ;;(vterm-other-window )
    (vterm-toggle-cd)
    ))
(when (equal my-use-package-terminal "eshell")
  ;;来点终端
  ;;(use-package eshell-toggle)
  (defun toggle-terminal()
    (interactive)
    (select-window (split-window-below))
    (eshell )
    ))
(provide 'init-terminal)
