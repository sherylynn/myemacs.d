(defun my-scratch-hook ()
  ;; 在这里编写您要执行的操作
  (evil-insert-state))

;;会影响我的整个主题
;;(add-hook 'initial-major-mode 'my-scratch-hook)

(when (string-equal system-type "android")
  ;; set terminal eshell because of vterm bug in android
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'use-my-package-terminal)
  (set 'my-use-package-terminal "eshell")
  ;;如果遇上了android，设置默认为insert以方便唤出键盘
  (add-hook 'evil-initialize
	    (lambda ()
	      (setq evil-default-state 'insert)
	      )
	    )
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
  ;;说明在这里面设置会被覆盖掉
  (add-hook 'evil-mode-hook
	    (lambda ()
	      (setq evil-default-state 'insert)
	      )
	    )
  )
(setq evil-default-state 'insert)
(provide 'init-system)
