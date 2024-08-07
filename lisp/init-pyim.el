;;来点基础词库
(use-package pyim
  :demand t ;;等需要的时候加载
  ;;:custom-face
  ;;(pyim-page ((t (:inherit default :background "yellow" :foreground "blue"))))
  ;;(pyim-page-border ((t (:inherit pyim-page :background "green")))
  :bind
  ;;多绑一个切换输入法的方式快捷键
  ("C-." . toggle-input-method) ;;不知道为啥 normal 下无效
  (
   :map pyim-mode-map
   ("<left>" . pyim-previous-word)
   ("<right>" . pyim-next-word)
   ("<down>" . pyim-next-page)
   ("<up>" . pyim-previous-page))

  :config
  ;;(defface pyim-page-border '((t (:inherit pyim-page :background "green"))))
  ;;默认输入法设置
  (setq default-input-method "pyim")
  (setq pyim-page-length 5)
  (require 'pyim-dregcache)
  ;;解决 android 和 termux 下的 pyim 输入
  (setq pyim-dcache-backend 'pyim-dregcache)
  ;;设置拼写候选词长度
  (setq pyim-page-length 5)
  ;;设置模糊音
  (setq pyim-pinyin-fuzzy-alist
	'(
	  ("z" "zh")
	  ("c" "ch")
	  ("s" "sh")
	  ("en" "eng")
	  ("in" "ing")
	  ("un" "ong")
	  ))
  ;;关闭云搜词
  ;;(setq pyim-cloudim nil)
  ;;百度的云搜词
  ;;(setq pyim-cloudim 'baidu)
  ;;关闭 buffer 搜词
  ;;(setq pyim-candidates-search-buffer-p nil)
  )
;;使用原家产的悬浮选词窗
(use-package posframe
  :when
  (display-graphic-p )
  :config
  ;;使用悬浮选词窗
  (setq pyim-page-tooltip 'posframe)
  )
;;终端下的悬浮窗
(use-package popup
  :unless
  (display-graphic-p)
  :config
  ;;使用悬浮选词窗
  (setq pyim-page-tooltip 'popup)
  )
(use-package pyim-basedict
  :config
  (pyim-basedict-enable)
  )
;;自动括号 29.3 的 emacs 还不支持:vc 的命令
;;(use-package pyim-tsinghua-dict
;; :ensure t
;; :quelpa (pyim-tsinghua-dict :fetcher github :repo "redguardtoo/pyim-tsinghua-dict")
;; :config
;; (pyim-tsinghua-dict-enable)
;; )
(unless (< emacs-major-version 29)
  ;;这个命令29后才支持，没办法
  (unless (package-installed-p 'pyim-tsinghua-dict)
    (package-vc-install
     '(pyim-tsinghua-dict :url "https://github.com/redguardtoo/pyim-tsinghua-dict"
			  ;;         :lisp-dir "lisp"
			  ;;        :doc "doc/bbdb.texi"
			  )))
  (use-package pyim-tsinghua-dict
    :ensure t
    :config
    (pyim-tsinghua-dict-enable)
    )
  )
(provide 'init-pyim)
