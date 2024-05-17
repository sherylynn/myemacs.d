;;根据时间来切换输入法框体
(defun my-load-pyim-theme-by-time ()
  "Execute command based on current time."
  (let* ( ;;current-time 获取当前秒数，decode-time 获取第二列的时间
         (hour (nth 2 (decode-time (current-time) 28800)))) ;;设置东八区的时间偏移量，28800
    (if (and (>= hour 8) (< hour 18))
        ;;(load-theme 'doom-one-light t)
        ;;(load-theme 'doom-nord-light t)
	(progn
	  (load-theme 'doom-solarized-light t)
	  (set-face-attribute 'pyim-page nil :background "#fefbf1" :foreground "#6c71c4")
	  (set-face-attribute 'pyim-page nil :background "#fefbf1" :foreground "#6c71c4")
	  (set-face-attribute 'pyim-page-selection nil :background "#073642")
	  )
      ;;(load-theme 'doom-one t)
      ;;(load-theme 'doom-nord t)
      ;;
      ;;(load-theme 'doom-dark+ t);;ssh 不行
      (load-theme 'doom-solarized-dark t)
      )))
;;来点基础词库
(use-package pyim
  :demand t ;;等需要的时候加载
  ;;:custom-face
  ;;(pyim-page ((t (:inherit default :background "yellow" :foreground "blue"))))
  ;;(pyim-page-border ((t (:inherit pyim-page :background "green"))))
  :bind
  ;;多绑一个切换输入法的方式快捷键
  ("C-." . toggle-input-method)
  (
   :map pyim-mode-map
   ("<left>" . pyim-previous-word)
   ("<right>" . pyim-next-word)
   ("<down>" . pyim-next-page)
   ("<up>" . pyim-previous-page))

  :config
  (my-load-pyim-theme-by-time)
  ;;(defface pyim-page-border '((t (:inherit pyim-page :background "green"))))
  ;;默认输入法设置
  (setq default-input-method "pyim")
  (setq pyim-page-length 5)
  (require 'pyim-dregcache)
  ;;解决 android 和 termux 下的 pyim 输入
  (setq pyim-dcache-backend 'pyim-dregcache)
  ;;设置拼写候选词长度
  (setq pyim-page-length 9)
  ;;设置模糊音
  (setq pyim-pinyin-fuzzy-alist
	'(
	  ("z" "zh")
	  ("c" "ch")
	  ("s" "sh")
	  ("en" "eng")
	  ("in" "ing")
	  ("un" "ong")
	  )
	)
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
(unless (package-installed-p 'pyim-tsinghua-dict)
  (package-vc-install
   '(pyim-tsinghua-dict :url "https://github.com/redguardtoo/pyim-tsinghua-dict"
			;;         :lisp-dir "lisp"
			;;        :doc "doc/bbdb.texi"
			))
  )
(use-package pyim-tsinghua-dict
  :ensure t
  :config
  (pyim-tsinghua-dict-enable)
  )
(provide 'init-pyim)
