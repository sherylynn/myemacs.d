;;来点基础词库
(use-package pyim
  :demand t ;;等需要的时候加载
  :bind (
	 :map pyim-mode-map
	 ("C-." . toggle-input-method)
	 ("<left>" . pyim-previous-word)
	 ("<right>" . pyim-next-word)
	 ("<down>" . pyim-next-page)
	 ("<up>" . pyim-previous-page))
  :config
  ;;默认输入法设置
  (setq default-input-method "pyim")
  (setq pyim-page-length 5)
  (require 'pyim-dregcache)
  ;;解决android和termux下的pyim输入
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
;;自动括号 29.3 的 emacs 还不支持:vc 的命令
;;(when (< emacs-major-version 30)
(use-package pyim-tsinghua-dict
  :quelpa (pyim-tsinghua-dict :fetcher github :repo "redguardtoo/pyim-tsinghua-dict")
  :config
  (pyim-tsinghua-dict-enable)
  )
;; )
;;(use-package awesome-pair
;;:vc (:url "" :rev :newest)
;;)
(provide 'init-pyim)
