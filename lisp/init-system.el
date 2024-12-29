(defun android-insert()
  ;; 在这里添加您要执行的命令或配置
  (when (equal (buffer-name) "*scratch*")
    (evil-insert-state)
    (message "default insert in scratch")
    )
  )
(defun toggle-android()
  (interactive)
  (modifier-bar-mode)
  ;;(tool-bar-mode)
  (toggle-tool-bar-mode-from-frame)
  )
(defun my-close-android-keyboard()
  (interactive)
  (setq touch-screen-display-keyboard nil)
  )
(defun evil-for-android()
  (interactive)
  ;;触屏屏幕和鼠标适配
  ;;原本 evil 会在 down-mouse-1 下默认绑定 evil-mouse-drag-region
  ;;(describe-key-briefly (kbd "<down-mouse-1>"))
  ;;严重影响触摸屏使用，原来的 visual 依然可以用键盘实现
  ;;好像这个绑定还是有问题的

  ;;下面注释的代码和忽略的代码等效
  ;;(evil-define-key 'visual 'global
  ;; (kbd "<down-mouse-1>") 'mouse-drag-region)
  ;;(evil-define-key 'normal 'global
  ;; (kbd "<down-mouse-1>") 'mouse-drag-region)
  ;;在鼠标事件中忽略 evil 的
  (put 'evil-mouse-drag-region 'ignored-mouse-command t)

  ;;绑定音量键
  ;;insert 模式下可以 evil-complete-next
  ;; evil-complete-previous
  ;; normal 模式下可以 org-crcle
  ;;tab 是 indent-for-tab-command
  ;;改成单击的 ctrl 按键先
  (define-key key-translation-map
              (kbd "<volume-up>")
              #'tool-bar-event-apply-control-modifier)
  (define-key key-translation-map (kbd "<volume-down>") (kbd "TAB"))
  (define-key key-translation-map (kbd "<kp-ret>") (kbd "RET"))
  ;;(describe-key-briefly (kbd "TAB"))
  ;;(evil-define-key '(insert normal) 'global (kbd "<volume-up>") 'toggle-input-method)
  )
(when (string-equal system-type "android")
  ;; set terminal eshell because of vterm bug in android
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'use-my-package-terminal)
  ;;还是不如直接 term 方便
  ;;(set 'my-use-package-terminal "eshell")
  (setq vterm-shell "/data/data/com.termux/files/usr/bin/zsh")
  (make-variable-buffer-local 'use-my-package-tab-bar)
  (set 'my-use-package-tab-bar t)
  (make-variable-buffer-local 'use-my-package-filetree)
  ;;都不好用, neotree 支持触摸
  (set 'my-use-package-filetree "neotree")

  ;; disable because of elpa bug in android
  (setq package-check-signature nil)

  ;; Add Termux binaries to PATH environment
  (setenv "PATH" (format "%s:%s" "/data/data/com.termux/files/usr/bin"
			 (getenv "PATH")))
  (push "/data/data/com.termux/files/usr/bin" exec-path)



  (use-package emacs
    ;;:hook
    ;;(emacs-startup-hook . (lambda() android-insert))
    :custom
    ;;better magit speed
    (android-use-exec-loader nil)
    ;;可以设置这个变量打开关闭键盘
    (touch-screen-display-keyboard t)
    ;;不弹出对话框
    (use-dialog-box nil)
    ;;还是得配合 scatch 一开始的插入，等后面就能不断的最小化窗口和重新进入来输出键盘了
    ;;不知道为啥后来就一直能弹出来，原来是改掉了 evil 的影响
    ;;把 tool-bar 位置靠近键盘
    (tool-bar-position 'bottom)
    ;;一些android下面的路径实际上没权限访问

    :init
    ;;还是会引入很多问题,问题的来源其实是因为 android 输入法和 emacs 本身实现的问题，会导致 evil 的 normal 模式下还是会不断键入 hjkl ，可以通过下面这个来关闭输入转译
    (setq overriding-text-conversion-style nil)
    ;;果然想象力才是限制，直接在启动完后，只在具体的 buffer 执行就行
    ;;(add-hook 'emacs-startup-hook 'android-insert)

    ;;如果遇上了 android，设置默认为 insert 以方便唤出键盘 原来一直弹出的问题是来源于 evil 对 mouse 的绑定，所以 touch 键盘会影响
    (add-hook 'evil-mode-hook 'evil-for-android)
    (delete "/product/bin" exec-path)
    (delete "/apex/com.android.runtime/bin" exec-path)
    (delete "/apex/com.android.art/bin" exec-path)
    (delete "/system_ext/bin" exec-path)
    (delete "/system/bin" exec-path)
    (delete "/system/xbin" exec-path)
    (delete "/odm/bin" exec-path)
    (delete "/vendor/bin" exec-path)
    (delete "/vendor/xbin" exec-path)
    )

  )

(when (string-equal system-type "windows-nt")
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'my-use-package-terminal)
  (set 'my-use-package-terminal "eshell")
  )

(when (string-equal system-type "gnu/linux")
  ;;(add-hook 'emacs-startup-hook 'android-insert)
  ;;说明在这里面设置会被覆盖掉
  ;; (add-hook 'evil-mode-hook
  ;;    (lambda ()
  ;;     (setq evil-default-state 'insert)
  ;;    )
  ;; )
  )
;;(setq evil-default-state 'insert)
;; 和 evil-collection冲突，且不方便
(provide 'init-system)
