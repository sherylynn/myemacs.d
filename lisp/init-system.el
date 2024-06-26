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
  ;;原本evil会在down-mouse-1下默认绑定evil-mouse-drag-region
  ;;(describe-key-briefly (kbd "<down-mouse-1>"))
  ;;严重影响触摸屏使用，原来的visual依然可以用键盘实现
  ;;好像这个绑定还是有问题的

  ;;下面注释的代码和忽略的代码等效
  ;;(evil-define-key 'visual 'global
  ;; (kbd "<down-mouse-1>") 'mouse-drag-region)
  ;;(evil-define-key 'normal 'global
  ;; (kbd "<down-mouse-1>") 'mouse-drag-region)
  ;;在鼠标事件中忽略evil的
  (put 'evil-mouse-drag-region 'ignored-mouse-command t)

  ;;绑定音量键
  ;;insert 模式下可以evil-complete-next
  ;; evil-complete-previous
  ;; normal 模式下可以 org-crcle
  ;;tab是indent-for-tab-command
  ;;改成单击的ctrl按键先
  (define-key key-translation-map
              (kbd "<volume-up>")
              #'tool-bar-event-apply-control-modifier)
  (define-key key-translation-map (kbd "<volume-down>") (kbd "TAB"))
  ;;(describe-key-briefly (kbd "TAB"))
  ;;(evil-define-key '(insert normal) 'global (kbd "<volume-up>") 'toggle-input-method)
  )
(when (string-equal system-type "android")
  ;; set terminal eshell because of vterm bug in android
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'use-my-package-terminal)
  ;;还是不如直接term方便
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
    ;;还是得配合scatch 一开始的插入，等后面就能不断的最小化窗口和重新进入来输出键盘了
    ;;不知道为啥后来就一直能弹出来，原来是改掉了evil的影响
    ;;把tool-bar 位置靠近键盘
    (tool-bar-position 'bottom)

    :init
    ;;还是会引入很多问题,问题的来源其实是因为android 输入法和emacs本身实现的问题，会导致evil的normal模式下还是会不断键入hjkl ，可以通过下面这个来关闭输入转译
    (setq overriding-text-conversion-style nil)
    ;;果然想象力才是限制，直接在启动完后，只在具体的buffer执行就行
    ;;(add-hook 'emacs-startup-hook 'android-insert)

    ;;如果遇上了android，设置默认为insert以方便唤出键盘 原来一直弹出的问题是来源于evil对mouse的绑定，所以touch键盘会影响
    (add-hook 'evil-mode-hook 'evil-for-android)
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
;; 和evil-collection冲突，且不方便
(provide 'init-system)
