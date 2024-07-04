(use-package rime
  :bind
  ;;多绑一个切换输入法的方式快捷键
  ("C-." . toggle-input-method) ;;不知道为啥 normal 下无效
  :custom
  (default-input-method "rime")
  :config
  ;;(concat (car (directory-files "~/.emacs.d/elpa/" t "^rime")) "/librime-emacs.so")
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
;;支持escape
(defun rime-evil-escape-advice (orig-fun key)
  "advice for `rime-input-method' to make it work together with `evil-escape'.
        Mainly modified from `evil-escape-pre-command-hook'"
  (if rime--preedit-overlay
      ;; if `rime--preedit-overlay' is non-nil, then we are editing something, do not abort
      (apply orig-fun (list key))
    (when (featurep 'evil-escape)
      (let (
            (fkey (elt evil-escape-key-sequence 0))
            (skey (elt evil-escape-key-sequence 1))
            )
        (if (or (char-equal key fkey)
                (and evil-escape-unordered-key-sequence
                     (char-equal key skey)))
            (let ((evt (read-event nil nil evil-escape-delay)))
              (cond
               ((and (characterp evt)
                     (or (and (char-equal key fkey) (char-equal evt skey))
                         (and evil-escape-unordered-key-sequence
                              (char-equal key skey) (char-equal evt fkey))))
                (evil-repeat-stop)
                (evil-normal-state))
               ((null evt) (apply orig-fun (list key)))
               (t
                (apply orig-fun (list key))
                (if (numberp evt)
                    (apply orig-fun (list evt))
                  (setq unread-command-events (append unread-command-events (list evt))))))
              )
          (apply orig-fun (list key)))))))

(advice-add 'rime-input-method :around #'rime-evil-escape-advice)
(provide 'init-rime)
