(custom-set-variables
 '(package-selected-packages '(atom-one-dark-theme ##)))
(custom-set-faces
 ;; 设置字体
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight normal :height 120 :width normal)))))

;; 窗口最大化
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; 设置禁用欢迎页
(setq inhibit-splash-screen t)
;; 禁用备份
(setq make-backup-files nil)
;; 禁用自动保存
(setq auto-save-default nil)

;; 添加软件包列表，网站首页：https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; 加载主题
(load-theme 'atom-one-dark t)
