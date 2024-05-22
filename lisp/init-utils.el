(defun my-toggle-filetree()
  "toggle filetree" ;;need desc
  (interactive) ;;need interactive
  (when (equal my-use-package-filetree "treemacs")
    (treemacs )
    )
  (when (equal my-use-package-filetree "neotree")
    (neotree-toggle )
    )
  )

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

(defun my-org-show-todo-tree()
  ;;配置个性化的筛选 todo 关键字
  (interactive)
  ;;(org-show-todo-tree 1) ;;第一个 todo 词，TODO
  ;;(org-show-todo-tree 2) ;;第一个 todo 词，KILL
  (org-show-todo-tree '(4) ) ;;手动选词
  )
(defun my-org-insert-subheading()
  "insert subheading"
  (interactive)
  (org-insert-heading-respect-content)
  (org-demote-subtree)
  )
(defun configure-emacs ()
  "configure emacs"
  (interactive)
  ;;(find-file "~/.emacs.d/packages.el")
  (find-file "~/.emacs.d/init.el")
  ;;配置模块化，就不主打打开这个了
  ;;(open-file-in-right-window "~/.emacs.d/lisp/init-utils.el")
  ;;因为配置模块化，所以直接打开 lisp 下面的侧边栏让自己选择
  ;;(neotree-dir "~/.emacs.d_my/lisp/")
  )
(defun configure-zsh ()
  "configure zsh"
  (interactive)
  (find-file "~/sh/win-git/toolsinit.sh")
  ;;(find-file "~/.emacs.d_my/init.el")
  ;;配置模块化，就不主打打开这个了
  ;;(open-file-in-right-window "~/.emacs.d/lisp/init-utils.el")
  ;;因为配置模块化，所以直接打开 lisp 下面的侧边栏让自己选择
  ;;(neotree-dir "~/sh/")
  )
(defun write-and-table-align()
  "write and table align"
  (interactive)
  (save-buffer)
  (org-table-align)
  )
(defun reload-emacs ()
  "reload emacs"
  (interactive)
  ;;重新加载
  (load-file "~/.emacs.d/init.el")
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
  ;;设置新命令时直接 new buffer
  (setq async-shell-command-buffer "new-buffer")
  ;;执行命令时候不显示窗口
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))
;;换一种实现
;;(defun async-shell-command-minibuffer
;;   (my_command)
;; (interactive)
;; (let ((output (async-shell-command my_command)));;结果还是会有窗口
;;   (message "Command output: %s" output))
;; )
(defun my-org-agenda-week-view()
  "agenda w"
  (interactive)
  (org-agenda nil "w"))

(defun my/git-pull-if-repo ()
  "Check if the current directory is a Git repository and pull it."
  ;;检查是否目录下有.git 文件夹
  (when (file-exists-p (locate-dominating-file default-directory ".git"))
    ;;(async-shell-command-minibuffer "git pull" )
    (async-shell-command-no-window "git pull")
    ;;尝试使用 magit 的 pull，但是对 magit 有依赖
    ;;(magit-pull-from-upstream)
    ))

;;判断有 git 的时候进行 git pull
(add-hook 'find-file-hook 'my/git-pull-if-repo)


(defun my-desktop-save()
  "save desktop"
  (interactive)
  (desktop-save desktop-path)
  )

(defun my-desktop-read()
  "save desktop"
  (interactive)
  (desktop-read desktop-path)
  )

;;(async-shell-command "git -C ~/work pull")
;;(make-process
;;        :name "my_work"
;;       :buffer "*work*"
;;不知道为啥切换不过去
;;      :command (list "git" "-C" "~/work" "pull")
;;     :noquery t)



(provide 'init-utils)
