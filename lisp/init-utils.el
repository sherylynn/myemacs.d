
(defun insert-checkbox ()
  "insert checkbox" ;;need desc
  (interactive) ;;need interactive
  (insert "- [ ]")
  (evil-escape )
  (org-update-checkbox-count-maybe )
  )
(defun insert-now-time()
  "insert now time"
  (interactive)
  (org-time-stamp-inactive "HH:MM")
  )
(defun set-input-method-rime()
  "set input method rime"
  (interactive)
  (set-input-method 'rime)
  )
(defun change-todo()
  "insert now schedule"
  (interactive)
  (org-todo )
  )
(defun insert-now-schedule()
  "insert now schedule"
  (interactive)
  (org-schedule "HH:MM")
  )
(defun insert-todo ()
  "insert todo" ;;need desc
  (interactive) ;;need interactive
  ;;另起一行
  ;;(newline)
  ;;使用官方的插入
  (org-insert-todo-heading-respect-content t)
  ;;(insert "TODO")
  ;;(org-todo "t")
  (org-update-checkbox-count-maybe )
  )
(defun open-file-in-right-window (filename)
  "在右边窗口中打开指定的文件。"
  (interactive "FEnter file name: ")
  (let ((new-buffer (find-file-noselect filename)))
    (select-window (split-window-right))
    (set-window-buffer (selected-window) new-buffer)))

(defun configure-emacs ()
  "configure emacs"
  (interactive)
  ;;(find-file "~/.emacs.d_my/packages.el")
  (find-file "~/.emacs.d_my/init.el")
  ;;配置模块化，就不主打打开这个了
  ;;(open-file-in-right-window "~/.emacs.d_my/lisp/init-utils.el")
  ;;因为配置模块化，所以直接打开lisp下面的侧边栏让自己选择
  ;;(neotree-dir "~/.emacs.d_my/lisp/")
  )
(defun configure-zsh ()
  "configure zsh"
  (interactive)
  ;;(find-file "~/sh/win-git")
  ;;(find-file "~/.emacs.d_my/init.el")
  ;;配置模块化，就不主打打开这个了
  ;;(open-file-in-right-window "~/.emacs.d_my/lisp/init-utils.el")
  ;;因为配置模块化，所以直接打开lisp下面的侧边栏让自己选择
  ;;(neotree-dir "~/sh/")
  )
(defun reload-emacs ()
  "reload emacs"
  (interactive)
  ;;重新加载
  (load-file "~/.emacs.d_my/init.el")
  (eval-buffer)
  )
(defun open-myorg()
  "configure emacs"
  (interactive)
  (tab-bar-new-tab)
  (find-file "~/work/todo.org")
  ;;(neotree-dir "~/work/")
  )
(defun async-shell-command-no-window
    (command)
  (interactive)
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))
(defun my-org-agenda-week-view()
  "agenda w"
    (interactive)
  (org-agenda nil "w"))

(provide 'init-utils)
