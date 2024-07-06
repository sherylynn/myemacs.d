;;(use-package pdf-tools)
;;termux下没有libpng-dev和lib-poopler-dev
;;所以是无法提供pdf-tools的服务器端编译的，同理android也没法用
;;关闭生成的~文件
(setq make-backup-files nil)
(provide 'init-test)
