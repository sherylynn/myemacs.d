;;(setq package-native-compile t)
;;设置tuna源
(setq package-archives '(
			 ("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
			 ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;;28有点慢了，就不校验源地址了
;;win的30 也校验失败，还是都别校验吧
(setq package-check-signature nil)
;; emacs 29以后use-package 已经内置
(when (< emacs-major-version 29)
  ;; 以下用来 bootstrap use-package 自己。在上文设置好软件源后，
  ;; 28压根没installed-p，采取直接判断文件夹方式，判断是否有use-package开头的文件夹
  ;;(unless (package-installed-p 'use-package)
  ;; 如果 use-package 没安装
  ;;(concat
  ;; (directory-files "~/.emacs.d/elpa/" t "^use-package")
  ;; "use-package.el"
  ;; )
  (setq my_package_path "~/.emacs.d/elpa")
  (unless (file-directory-p my_package_path) (mkdir my_package_path t))
  (unless (directory-files "~/.emacs.d/elpa/" t "^use-package")
    ;; 更新本地缓存
    (message "开始安装use-package")
    (package-refresh-contents)
    ;; 之后安装它。use-package 应该是你配置中唯一一个需要这样安装的包。
    (package-install 'use-package)
    )

  (require 'use-package)
  )
;; 让 use-package 永远按需安装软件包 不知道为啥不行了
(require 'use-package-ensure)
(setq use-package-always-ensure t)
;;更新内置包
;;(setq package-install-upgrade-built-in t)

;; 让package-autoremove 可以用
;; package.el updates the saved version of package-selected-packages correctly only
;; after custom-file has been loaded, which is a bug. We work around this by adding
;; the required packages to package-selected-packages after startup is complete.
;; Make `package-autoremove' work with `use-package'

(defvar use-package-selected-packages '(use-package)
  "Packages pulled in by use-package.")

(eval-and-compile
  (define-advice use-package-handler/:ensure (:around (fn name-symbol keyword args rest state) select)
    (let ((items (funcall fn name-symbol keyword args rest state)))
      (dolist (ensure args items)
        (let ((package
               (or (and (eq ensure t) (use-package-as-symbol name-symbol))
                   ensure)))
          (when package
            (when (consp package)
              (setq package (car package)))
            (push `(add-to-list 'use-package-selected-packages ',package) items)))))))

(when (fboundp 'package--save-selected-packages)
  (add-hook 'after-init-hook
            (lambda ()
              (package--save-selected-packages
               (seq-uniq (append use-package-selected-packages package-selected-packages))))))


(provide 'init-package)
