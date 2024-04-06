(when (string-equal system-type "android")
  ;; disable because of elpa bug in android
(setq package-check-signature nil)
  ;; Add Termux binaries to PATH environment
  (let ((termuxpath "/data/data/com.termux/files/usr/bin"))
    (setenv "PATH" (concat (getenv "PATH") ":" termuxpath))
    (setq exec-path (append exec-path (list termuxpath)))))
(provide 'init-termux)
