(setq package-native-compile t)
;;设置tuna源
(setq package-archives '(
  ("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
  ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
  ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; emacs 29以后use-package 已经内置
(when (< emacs-major-version 29)
  ;; 以下用来 bootstrap use-package 自己。在上文设置好软件源后，
  ;; 如果 use-package 没安装
  (unless (package-installed-p 'use-package)
    ;; 更新本地缓存
    (package-refresh-contents)
    ;; 之后安装它。use-package 应该是你配置中唯一一个需要这样安装的包。
    (package-install 'use-package))

  (require 'use-package)
  )
;; 让 use-package 永远按需安装软件包 不知道为啥不行了
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; emacs 30有 自带的vc，不然只能用quelpa
(when (< emacs-major-version 30)
    (use-package quelpa 
      :init
    ;;原来可以配置选项禁用傻逼的自动更新
      ;;加快启动速度
    (setq quelpa-update-melpa-p nil)
    :config ; 在 (require) 之后需要执行的表达式
    (use-package quelpa-use-package) ; 把 quelpa 嵌入 use-package 的宏扩展
    (quelpa-use-package-activate-advice)) ; 启用这个 advice

    ;;但是要hack掉ensure的实现方式
    ;;(setq use-package-ensure-function 'quelpa) ;;quelpa启动的时候还检查github上包是否有更新，我无语了,太慢了,而且还会检查自己，弃用
    ;;明显降低启动速度，不用use-package的ensure了
  )

;; 让 use-package 永远按需加载软件包 ;;结果全没加载，无语
;;(setq use-package-always-defer t)
;; 之后就可以使用它了。
;; 比如上文安装并 require better-defaults 的过程就可以简化为这一行：
;; 1. 它会判断是否已安装。没有时才会更新 package 缓存并安装它
;; 2. 它会自动 (require)
;; 3. 它有很多配置项能让你控制每个环节，从而做到把和这个软件包有关的所

(provide 'init-package)
