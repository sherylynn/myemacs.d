(defun librime-install (&optional pfx)
  "Helper function to download and install the librime based on OS"
  (interactive "P")
  (when (or pfx (yes-or-no-p "This will download and install librime, are you sure you want to do this?"))
    ;;(let* ((url-format "https://raw.githubusercontent.com/rainstormstudio/nerd-icons.el/main/fonts/%s")
    (let* ((url-format "https://raw.githubusercontent.com/sherylynn/fonts/main/%s")
           (font-dest (cond
                       ;; Default Linux install directories
                       ((member system-type '(gnu gnu/linux gnu/kfreebsd))
                        (concat (or (getenv "XDG_DATA_HOME")
                                    (concat (getenv "HOME") "/.local/share"))
                                "/fonts/"
                                ))
                       ;; Default MacOS install directory
                       ((eq system-type 'darwin)
                        (concat (getenv "HOME")
                                "/Library/Fonts/"
                                ;;sarasa-nerd-fonts-subdirectory))
                                ))
                       ;; Default Android install directory
                       ((eq system-type 'android)
                        (concat (getenv "HOME")
                                "/fonts/"
                                ))))
           (known-dest? (stringp font-dest))
           (font-dest (or font-dest (read-directory-name "Font installation directory: " "~/"))))

      (unless (file-directory-p font-dest) (mkdir font-dest t))

      (mapc (lambda (font)
              (url-copy-file (format url-format font) (expand-file-name font font-dest) t))
            sarasa-nerd-font-names)
      (when known-dest?
        (message "Fonts downloaded, updating font cache... <fc-cache -f -v> ")
        (shell-command-to-string (format "fc-cache -f -v")))
      (message "Successfully %s `sarasa-nerd' fonts to `%s'!"
               (if known-dest? "installed" "downloaded")
               font-dest))))
(use-package rime
  :bind
  ;;多绑一个切换输入法的方式快捷键
  ("C-." . toggle-input-method) ;;不知道为啥 normal 下无效
  :custom
  (default-input-method "rime")
  :config
  ;;(concat (car (directory-files "~/.emacs.d/elpa/" t "^rime")) "/librime-emacs.so")
  (when (file-exists-p "/home/linuxbrew")
    ;;for mac
    ;;(setq rime-librime-root "/usr/lib/x86_64-linux-gnu/librime.so.1")
    ;;(setenv "LIBRARY_PATH" (format "%s:%s" "/usr/lib/x86_64-linux-gnu/" (getenv "LIBRARY_PATH")))
    ;;(setenv "LD_LIBRARY_PATH" (format "%s:%s" "/usr/lib/x86_64-linux-gnu/" (getenv "LD_LIBRARY_PATH")))
    (setq rime-emacs-module-header-root
          "/home/linuxbrew/.linuxbrew/include"
          )
    )

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
