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
      ;;configure zsh
      "zs" '(configure-zsh :wk "edit zsh configure")
      ;;init.el
      "ze" '(configure-emacs :wk "edit emacs configure")
      ;;quit emacs
      "zz" 'kill-emacs
      ;;show todo tree
      "zt" 'org-show-todo-tree
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
      ;;edit
      "e" '(:wk "edit")
      "ef" '(format-all-buffer :wk "edit format")
      ;;配置中文字体
      "ec" '(cnfonts-edit-profile :wk "edit chinese fonts")
      ;;file
      "f" '(:wk "find or file")
      "ff" 'find-file
      ;;insert ;;插入
      "i" '(:wk "insert")
      "ic" 'insert-checkbox
      "it" 'insert-todo
      "in" 'insert-now-time 
      "id" 'insert-now-schedule
      ;;run func
      "x" '(:wk "exce func")
      "xx" 'vterm-other-window
      ;;toggle/tab
      "t" '(:wk "toggle/tab")
      "tt" 'toggle-terminal
      "ti" 'toggle-input-method
      "th" '(awesome-tab-backward-tab :wk "left tab")
      "tl" '(awesome-tab-forward-tab :wk "right tab")
      ;;"t-" '(awesome-tab-forward-tab :wk "right tab")
      ;;"t=" '(awesome-tab-forward-tab :wk "right tab")
      ;;"tj" '(awesome-tab-backward-tab :wk "close tab")
      ;;
      ;;"-" 'text-scale-decrease ;;这个是默认自带的方法
      ;;"=" 'text-scale-increase ;;这个是默认自带的方法，还可以直接ctrl和滚轮配合调整
      ;;"-" 'default-text-scale-decrease ;; purcell 的default-text-scale 和 cnfonts 有冲突
      ;;"=" 'default-text-scale-increase ;; 直接用 cnfonts的 方法
      "-" 'cnfonts-decrease-fontsize
      "=" 'cnfonts-increase-fontsize

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
