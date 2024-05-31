(use-package rime
  :custom
  (default-input-method "rime")
  :config
  (when (file-exists-p "/home/linuxbrew")
    (setq rime-emacs-module-header-root
          "/home/linuxbrew/.linuxbrew/include"
          ))

  (defun toggle-rime-show-candidate()
    "toggle rime show candidate"
    (interactive)
    (if (equal rime-show-candidate 'posframe)
	(setq rime-show-candidate 'minibuffer)
      (setq rime-show-candidate 'posframe))
    )
  (setq rime-user-data-dir "~/rime")
  (setq rime-share-data-dir "~/rime")
  ;;rime-user-data-dir "~/storage/download/rime")
  )
;;使用图形悬浮选词窗
(use-package posframe
  :when
  (display-graphic-p )
  :config
  ;;使用悬浮选词窗
  (setq rime-show-candidate 'posframe)
  (setq rime-posframe-style 'vertical)
  )
;;终端下的悬浮窗
(use-package popup
  :unless
  (display-graphic-p)
  :config
  ;;使用悬浮选词窗
  (setq rime-show-candidate 'popup)
  (setq rime-popup-style 'vertical)
  ;;一堆乱码
  )
(provide 'init-rime)
