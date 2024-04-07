;;按键总是最重要的，让我们来开始 which-key（leader 时候 general 也会用到)
;;which-key 是快捷键提示
(use-package which-key
  :config
  (which-key-mode))

;;general 是通用的按键绑定
(when (equal my-use-package-leader "general")
  (use-package general
    :config
    ;;这样就指定了 normal state 下的 leader 键是 SPC、其余的 insert / visual /emacs state 下是 C-,。之后用这个新创建的 definer 分配键位就好：
    (general-create-definer my-leader-def
      :states '(normal insert visual emacs)
      :prefix "SPC"
      :non-normal-prefix "C-,")
    ;;定义键位时，可以用 :which-key 或简写 :wk 来指定 which-key 所显示的文字：
    (my-leader-def
     ;;z about editor
     "z" '(:wk "editor")
     ;;org file
     "zo" '(open-myorg :wk "open my orgfile")
     ;;reload init.el
     "zr" '(reload-emacs :wk "reload emacs")
     ;;init.el
     "ze" '(configure-emacs :wk "edit emacs configure")
     ;;quit emacs
     "zz" 'kill-emacs
     ;;git pull
     "zf" 'magit-pull-from-upstream
     ;;neotree
     "1" '(neotree-toggle :wk "toggle neotree")
     ;;quit buffer
     "q" '(kill-buffer-and-window :wk "quit buffer")
     ;;magit-status
     "g" '(:wk "git")
     "gg" '(magit-status :wk "magit-status")
     ;;redo reload restart
     "r" '(:wk "re-do reload restart")
     "rd" 'find-function
     "rl" 'reload-emacs
     "rr" 'restart-emacs
     "rc" '(package-recompile-all :wk "recompile package")
     ;;windows
     "w" '(:wk "windows")
     "wq" 'kill-buffer-and-window
     "wh" 'evil-window-left ;;C-w h
     "wj" 'evil-window-down ;;C-w j
     "wk" 'evil-window-up ;;C-w k
     "wl" 'evil-window-right ;;C-w l
     ;;help
     "h" '(:wk "help")
     "hf" 'describe-function ;;"hf" 'find-function
     "hv" 'describe-variable ;;"hv" 'find-variable
     "hk" 'find-function-on-key
     ;;buffer func
     "b" '(:wk "buffer func")
     "bf" 'format-all-region-or-buffer
     ;;run func
     "x" '(:wk "exce func")
     "xx" 'vterm-other-window
     ;;toggle
     "t" '(:wk "toggle")
     "tt" 'toggle-terminal
     "ti" 'toggle-input-method
     )
    ))
(when (equal my-use-package-vim "meow")
  (use-package meow
    :config
    ;;(meow-setup)
    (meow-global-mode 1)
    )
  )
(provide 'init-key)
