
;;接下来让我们vim起来
(when (equal my-use-package-vim "evil")
    ;;leader键
  (when (equal my-use-package-leader "evil-leader")
    (use-package evil-leader
    :init
    ;;evil-collection 的 warning, 不得不关闭
    (setq evil-want-keybinding nil)
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "SPC")
    (evil-leader/set-key
        ;;org file
        "zo" 'open-myorg
        ;;reload init.el
        "zr" 'reload-emacs
        ;;init.el
        "ze" 'configure-emacs
        ;;neotree
        "1" 'neotree-toggle
        ;;quit buffer
        "q" 'kill-buffer-and-window
        ;;quit emacs
        "zz" 'kill-emacs ;;evil leader 不能用qq叠词
        ;;magit-status
        "gg" 'magit-status
        )
    )
  )

    ;;EVIL:: as vim
    (use-package evil
    :init
    ;;evil-collection 的 warning
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1)
    ;; evil也自带 leader模式
    (when (equal my-use-package-leader "evil")
      (evil-set-leader nil (kbd "SPC"))
      ;;org file
      (evil-define-key 'normal 'global (kbd "<leader>zo") 'open-myorg)
      ;;init.el
      (evil-define-key 'normal 'global (kbd "<leader>ze") 'configure-emacs)
      ;;neotree
      (evil-define-key 'normal 'global (kbd "<leader>1") 'neotree-toggle)
      ;;quit buffer
      (evil-define-key 'normal 'global (kbd "<leader>q") 'kill-buffer-and-window)
      ;;reload emacs
      (evil-define-key 'normal 'global (kbd "<leader>zr") 'reload-emacs);;一样废物，不能和上面的leaderq重合
      ;;quit emacs
      (evil-define-key 'normal 'global (kbd "<leader>zz") 'kill-emacs);;一样废物，不能和上面的leaderq重合
      ;;magit-status
      (evil-define-key 'normal 'global (kbd "<leader>gg") 'magit-status)
      
      ))
    ;;surround,添加环绕字符
    (use-package evil-surround
    :after evil
    :config
        (global-evil-surround-mode 1))
    ;;一些包括evil for magit的操作合集
    (use-package evil-collection
    :after evil
    :config
        (evil-collection-init))
    ;;退出evil的快捷方式
    (use-package evil-escape
    :after evil
    :config
    (evil-escape-mode)
    (setq-default evil-escape-key-sequence "jk")
    )
    ;;其他全局按键
    (global-set-key (kbd "C-g") 'evil-escape)
);;my-use-package when evil
(provide 'init-evil)