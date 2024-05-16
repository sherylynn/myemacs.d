;;按键总是最重要的，让我们来开始 which-key（leader 时候 general 也会用到)
;;which-key 是快捷键提示
(defun my-mad-theme()
  "load crazy theme"
  (interactive)
  (load-theme 'crazy t))
(use-package which-key
  :config
  (which-key-mode))

;;general 是通用的按键绑定
(when (equal my-use-package-leader "general")
  (use-package general
    ;;https://github.com/noctuid/general.el
    :init
    ;;覆盖掉evil-collection的SPC绑定
    (setq general-override-states '(insert
                                    emacs
                                    hybrid
                                    normal
                                    visual
                                    motion
                                    operator
                                    replace))
    :config
    ;;这样就指定了 normal state 下的 leader 键是 SPC、其余的 insert / visual /emacs state 下是 C-,。之后用这个新创建的 definer 分配键位就好：
    (general-create-definer my-SPC-leader-def
      ;; 分不清什么状态好，直接全上看看会不会好一点,这样全部都能用 leader 模式了
      :states '(normal insert visual emacs hybrid motion operater replace)
      :keymaps 'override
      :prefix "SPC"
      ;;非normal情况下的按键
      :non-normal-prefix "C-SPC"
      )
    ;;定义键位时，可以用 :which-key 或简写 :wk 来指定 which-key 所显示的文字：
    (my-SPC-leader-def
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
      ;;"zt" 'org-show-todo-tree
      "zt" 'my-org-show-todo-tree
      ;;git pull
      "zf" 'magit-pull-from-upstream
      ;;neotree
      "1" '(my-toggle-filetree :wk "toggle filetree")
      ;;quit buffer
      ;;"q" '(kill-buffer-and-window :wk "quit buffer")
      "q" '(delete-window :wk "delete window")

      ;;magit-status
      "g" '(:wk "git")
      "gg" '(magit-status :wk "magit-status")
      "gf" '(magit-pull-from-upstream :wk "git-fetch")
      "gc" '(magit-pull-from-upstream :wk "git checkout .")

      ;;redo reload restart
      "r" '(:wk "re-do reload restart")
      "rd" 'find-function
      "rl" 'reload-emacs
      "rr" 'restart-emacs
      "rc" '(package-recompile-all :wk "recompile package")
      ;;windows
      "w" '(:wk "windows")
      "wq" 'my-toggle-filetree
      "wd" 'kill-buffer-and-window
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
      "e" '(:wk "edit/eval")
      "ef" '(format-all-buffer :wk "edit format")
      "eb" '(eval-buffer :wk "eval-buffer")
      ;;配置中文字体
      "ec" '(cnfonts-edit-profile :wk "edit chinese fonts")
      ;;file
      "f" '(:wk "find or file or format")
      "ff" 'find-file
      "ft" '(org-table-align :wk "format table")
      ;;SPC SPC ;;apt remove fd-find ;;brew install fd
      "SPC" 'projectile-find-file
      ;;insert input ;;插入
      "i" '(:wk "insert")
      "ic" 'insert-checkbox
      "it" 'insert-todo
      "in" 'insert-now-time
      "ih" 'org-insert-heading-respect-content ;;insert heading or hour
      "io" 'org-insert-heading-respect-content
      "is" 'my-org-insert-subheading
      "id" 'insert-now-schedule
      ;;"it" 'toggle-input-method
      ;;change
      "c" '(:wk "change/close")
      "ct" 'change-todo
      "ci" 'toggle-input-method
      "ck" 'my-close-android-keyboard
      ;;"h" '(:wk "org heading")
      ;;"hi" '(org-insert-heading-respect-content :wk "head inssert")
      ;;"hl" '(org-demote-subtree :wk "item demote")
      ;;"hh" '(org-promote-subtree :wk "item promote")
      ;;"hj" '(outline-move-subtree-down :wk "item down")
      ;;"hk" '(outline-move-subtree-up :wk "item up")
      ;;"ht" '(outline-move-subtree-up :wk "item todo")
      ;;"ow" 'org-agenda-date-weekend
      ;;org-agenda
      "o" '(:wk "org")
      "oa" 'org-agenda
      "ow" 'my-org-agenda-week-view
      "ot" 'org-agenda-todo-list
      ;;move item
      "ol" '(org-demote-subtree :wk "item demote")
      "oh" '(org-promote-subtree :wk "item promote")
      "oj" '(outline-move-subtree-down :wk "item down")
      "ok" '(outline-move-subtree-up :wk "item up")
      ;;"ow" 'org-agenda-date-weekend
      ;;project/projectile
      "p" '(:wk "project/projectile/page")
      ;;"pf" 'project-find-file ;;这个有时候不能用
      "pf" 'projectile-find-file ;;速度太慢
      ;;"ps" 'projectile-switch-project
      "ps" 'project-switch-project
      "pg" 'projectile-grep
      "pd" 'evil-scroll-down
      ;;"pu" 'evil-scroll-up
      "pi" 'package-install
      "pu" 'package-upgrade-all
      "pc" 'package-autoremove
      ;;run func
      "x" '(:wk "exce func")
      "xx" 'execute-extended-command
      "xe" 'eval-last-sexp
      ;;toggle/tab/todo
      "t" '(:wk "toggle/tab/todo")
      "tt" 'toggle-terminal
      "ta" 'toggle-android
      "th" '(my-left-tab :wk "left tab")
      "tl" '(my-right-tab :wk "right tab")
      "tj" '(my-prev-tab :wk "LEFT tab")
      "tk" '(my-next-tab :wk "RIGHT tab")
      "tc" '(tab-bar-close-tab :wk "close tab")
      "tn" '(tab-bar-new-tab :wk "new tab")

      ;;"t-" '(awesome-tab-forward-tab :wk "right tab")
      ;;"t=" '(awesome-tab-forward-tab :wk "right tab")
      ;;
      ;;"-" 'text-scale-decrease ;;这个是默认自带的方法
      ;;"=" 'text-scale-increase ;;这个是默认自带的方法，还可以直接 ctrl 和滚轮配合调整
      ;;"-" 'default-text-scale-decrease ;; purcell 的 default-text-scale 和 cnfonts 有冲突
      ;;"=" 'default-text-scale-increase ;; 直接用 cnfonts 的 方法
      ;;toggle/tab/todo
      "s" '(:wk "size")
      "si" 'cnfonts-increase-fontsize
      "sd" 'cnfonts-decrease-fontsize
      "-" 'cnfonts-decrease-fontsize
      "=" 'cnfonts-increase-fontsize
      "d" '(:wk "desktop")
      "ds" 'my-desktop-save
      "dc" 'desktop-clear
      "dr" 'my-desktop-read

      "m" '(:wk "mad")
      "mm" '(my-mad-theme :wk "mad mind crazy theme")

      )
    ))
(provide 'init-key)
