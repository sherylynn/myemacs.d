(when (string-equal system-type "android")
  ;; set terminal eshell because of vterm bug in android
  ;;(setq use-my-package-terminal "eshell")
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'use-my-package-terminal)
  (set 'use-my-package-terminal "eshell")
  ;; disable because of elpa bug in android
  (setq package-check-signature nil)
  ;; Add Termux binaries to PATH environment
  (let ((termuxpath "/data/data/com.termux/files/usr/bin"))
    (setenv "PATH" (concat (getenv "PATH") ":" termuxpath))
    (setq exec-path (append exec-path (list termuxpath)))))
(unless (string-equal system-type "android")
  ;; set terminal eshell because of vterm bug in android
  ;;(setq use-my-package-terminal "eshell")
  ;; 需要全局变量来操作
  (make-variable-buffer-local 'use-my-package-terminal)
  (set 'use-my-package-terminal "vterm")
  )
(provide 'init-termux)
