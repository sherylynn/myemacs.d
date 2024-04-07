;;来点基础词库
(use-package pyim
  :demand t ;;等需要的时候加载
  :config
  ;;默认输入法设置
  (setq default-input-method "pyim")
  (setq pyim-page-length 5)
  (require 'pyim-dregcache)
  (setq pyim-dcache-backend 'pyim-dregcache)
  )
;;使用原家产的悬浮选词窗
(use-package posframe
  :config
  ;;使用悬浮选词窗
  (setq pyim-page-tooltip 'posframe)
  )
(use-package pyim-basedict
  :config
  (pyim-basedict-enable)
  )
(provide 'init-pyim)
