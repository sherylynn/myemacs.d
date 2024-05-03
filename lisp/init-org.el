;;个人日程列表文件
(setq org-agenda-files (list "~/work/todo.org"))
(setq org-todo-keywords
      ;;无语了居然是用分隔符号来区分是否完成
      '((sequence "TODO(t)"  "WAIT(w)" "|" "KILL(k)" "DONE(d)" )))
(setq org-not-done-keywords '("TODO"))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "green" :weight bold))
	("WAIT" . (:foreground "yellow" :weight bold))
	("KILL" . (:foreground "red" :weight bold))
	("DONE" . (:foreground "grey" :weight bold))
	))
(setq
 ;;跨越10天
 org-agenda-span 10)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-start-day "-3d")
;;agenda的时候就不提示不想要的状态
(setq org-agenda-custom-commands
      '(
        ("w" "Agenda for work"
         ((agenda "" ((org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo '("TODO")))))
          (todo "WAIT")
          ;;(alltodo "")
          (tags "note"))
         )
        ("n" todo "NOTE")))

;;org没法直接use package
;;(use-package org)
;;这个是原本emacs自带的让每行只显示一个星号
(defun my-org-mode()
  (setq org-hide-leading-stars t)
  ;;开启 org 下面自动换行
  (setq truncate-lines nil)
  ;;打开 buffer 大小，显示当前字数
  (size-indication-mode t)

  ;;当启动 org 的时候关闭行号
  (display-line-numbers-mode 0)

  ;;打开缩进
  (org-indent-mode)
  )

(when (equal my-use-package-org "org-normal")
  (add-hook 'org-mode-hook 'my-org-mode)
  )



;;evil下一些快捷键的绑定
(use-package evil-org
  ;;  :defer t
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  )

(provide 'init-org)
