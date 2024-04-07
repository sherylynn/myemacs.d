(when (equal my-use-package-terminal "vterm")
  ;;来点终端
  (use-package vterm)
  (defun toggle-terminal()
    (interactive)
    (vterm-other-window )
    ))
(when (equal my-use-package-terminal "eshell")
  ;;来点终端
  (use-package eshell)
  (eshell/toggle)
  )
(provide 'init-terminal)
