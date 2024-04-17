(when (string-equal system-type "android")
  ;; set terminal eshell because of vterm bug in android
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'use-my-package-terminal)
  (set 'my-use-package-terminal "eshell")
  ;; disable because of elpa bug in android
  (setq package-check-signature nil)
  ;; Add Termux binaries to PATH environment
  (let ((termuxpath "/data/data/com.termux/files/usr/bin"))
    (setenv "PATH" (concat (getenv "PATH") ":" termuxpath))
    (setq exec-path (append exec-path (list termuxpath)))))

;;如果遇上了android，设置默认为insert以方便唤出键盘
(setq evil-default-state 'insert)

(when (string-equal system-type "windows-nt")
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'my-use-package-terminal)
  (set 'my-use-package-terminal "eshell")
  )
(provide 'init-system)
