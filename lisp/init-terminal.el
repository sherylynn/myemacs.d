(when (equal my-use-package-terminal "vterm")
  ;;来点终端
  (use-package vterm
    :config
    (add-hook
     'vterm-mode-hook
     (
      ;;当启动vterm的时候关闭行号,关闭tabs
      lambda()
      (display-line-numbers-mode 0)
      ;;没有当前窗口关闭的tab，算了
      ;;(awesome-tab-mode 0)
      )))
  (defun toggle-terminal()
    (interactive)
    (vterm-other-window )
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
