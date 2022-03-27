;; 设置字体
(set-frame-font "Source Han Sans CN 13" nil t)

;; 设置禁用欢迎页
(setq inhibit-splash-screen t)
;; 禁用备份
(setq make-backup-files nil)
;; 禁用自动保存
(setq auto-save-default nil)
;; 关闭启动画面
(setq inhibit-startup-message t)
;; 高亮当前行
(global-hl-line-mode 1)
;; 隐藏工具栏、菜单栏、导航条
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
;; 设置窗口大小

;; 添加软件包列表，网站首页：https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; 加载主题
(load-theme 'atom-one-dark t)
