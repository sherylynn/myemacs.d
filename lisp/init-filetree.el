(use-package projectile
  :config
  (projectile-mode 1)
  )
;;熟悉的文件栏
(when (equal my-use-package-filetree "neotree")
  (message "why load neotree")
  (use-package neotree
    ;;需要 all the icon 包
    :defer t
    :if (equal my-use-package-filetree "neotree")
    :custom
    (neo-show-hidden-files t)
    :config
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
  )
(provide 'init-filetree)
