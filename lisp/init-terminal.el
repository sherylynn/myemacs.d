(when (equal my-use-package-terminal "vterm")
  ;;来点终端
  (use-package vterm
    :defer t
    :init
    (setq vterm-always-compile-module t)
    :hook(
	  vterm-mode . (lambda()
			 ;;终端下就不用显示行号了
			 (display-line-numbers-mode 0)
			 ))
    )
  (use-package vterm-toggle
    :defer t
    :after vterm)

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
