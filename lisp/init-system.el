(defun android-insert()
  ;; 在这里添加您要执行的命令或配置
  (when (equal (buffer-name) "*scratch*")
    (evil-insert-state)
    (message "default insert in scratch")
    )
  )

(when (string-equal system-type "android")
  ;; set terminal eshell because of vterm bug in android
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'use-my-package-terminal)
  (set 'my-use-package-terminal "eshell")
  (use-package emacs
    ;;:hook
    ;;(emacs-startup-hook . (lambda() android-insert))
    :custom
    ;;可以设置这个变量打开键盘
    (touch-screen-display-keyboard t) ;;然而还是没生效

    :init
    ;;还是会引入很多问题,问题的来源其实是因为android 输入法和emacs本身实现的问题，会导致evil的normal模式下还是会不断键入hjkl ，可以通过下面这个来关闭输入转译
    (setq overriding-text-conversion-style nil)
    ;;果然想象力才是限制，直接在启动完后，只在具体的buffer执行就行
    (add-hook 'emacs-startup-hook 'android-insert)

    )

  ;;如果遇上了android，设置默认为insert以方便唤出键盘
  ;;(add-hook 'evil-initialize
  ;;(lambda ()
  ;;(setq evil-default-state 'insert)
  ;;)
  ;;)

  ;; disable because of elpa bug in android
  (setq package-check-signature nil)
  ;; Add Termux binaries to PATH environment
  (let ((termuxpath "/data/data/com.termux/files/usr/bin"))
    (setenv "PATH" (concat (getenv "PATH") ":" termuxpath))
    (setq exec-path (append exec-path (list termuxpath)))))


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
