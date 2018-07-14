(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(package-selected-packages
   (quote
    (smartrep ein request jedi company-jedi guide-key smartparens flycheck cython-mode company-anaconda anaconda-mode helm-ls-git avy projectile helm swiper yasnippet smex exec-path-from-shell cmake-font-lock cmake-mode monokai-theme company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; basic configuration for emacs

;; 打开行号显示
(setq column-number-mode t)

;; 关掉工具栏
(tool-bar-mode -1);; turn off tool barq

;; 关掉启动页面
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil) ;; turn off scratch message

;; 改变光标样式
(setq-default cursor-type 'bar)

;; 粘贴删除选中的区域
(delete-selection-mode t)

;; 禁止生成备份文件
;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

;; 当外部文件修改时, 自动加载更新
(global-auto-revert-mode t)


;; 修改打开的最大文件警告阈值
(setq large-file-warning-threshold 10000000)


;; misc
(fset 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode t)


;; 安装插件

;; 配置包管理器

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  )
(require 'cl)


;; 默认安装的包

(defvar liy/packages '(
                          company
                          monokai-theme
                          cmake-mode
                          cmake-font-lock
                          exec-path-from-shell
                          smex
                          yasnippet
                          swiper
                          helm
                          projectile
                          avy
                          helm-ls-git
                          anaconda-mode
                          company-anaconda
                          cython-mode
                          flycheck
                          smartparens
                          guide-key
                          popwin
			  )  "Default packages")

;; 安装默认的packages

(defun liy/packages-installed-p ()
  (loop for pkg in liy/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (liy/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg liy/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))


;; 激活cmake mode
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))



;; 配置yasnippet插件

(require 'yasnippet)
(yas-global-mode t)


;; 激活company-mode
(global-company-mode 1)


;; 添加默认的company 设置
 (eval-after-load 'company
'(progn
   (setq company-echo-delay 0)
   (setq company-idle-delay 0.08)
   (setq company-auto-complete nil)
   (setq company-show-numbers t)
   (setq company-begin-commands '(self-insert-command))
   (setq company-tooltip-limit 10)
   (setq company-minimum-prefix-length 1)
    (let ((map company-active-map))
        (define-key map (kbd "C-d") 'company-show-doc-buffer)
        (define-key map (kbd "C-n") 'company-select-next)
        (define-key map (kbd "C-p") 'company-select-previous)
        (define-key map (kbd "C-l") 'company-complete-selection))
    ))


;; 配置python

(require 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(require 'cython-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
(setq tab-width 4)
(setq indent-tabs-mode nil)
(require 'flycheck)
(add-hook 'python-mode-hook 'flycheck-mode)
(require 'company-anaconda)
(eval-after-load 'anaconda-mode
  '(push 'company-anaconda company-backends))
(define-key anaconda-mode-map (kbd "s-.") 'anaconda-mode-goto-definitions)
(define-key anaconda-mode-map (kbd "s-,") 'anaconda-nav-pop-marker)
(define-key anaconda-mode-map (kbd "s-d") 'anaconda-mode-view-doc)
(define-key anaconda-mode-map (kbd "s-r") 'anaconda-mode-usages)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "s-b") 'backward-word)
(global-set-key (kbd "s-f") 'forward-word)



;; 其他配置
(global-set-key (kbd "C-s") 'swiper)
(require 'smartparens-config)
(smartparens-global-mode t)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(require 'guide-key)
(guide-key-mode t)
(setq guide-key/idle-delay 0.4)
(setq guide-key/guide-key-sequence `("C-c"
                                     "C-x"
                                     "C-c s"
                                     "C-c e"
                                     ))
(setq guide-key/recursive-key-sequence-flag t)
(global-set-key (kbd "s-i") 'helm-semantic-or-imenu)
(require 'helm-ls-git)
(global-set-key (kbd "s-t") 'helm-ls-git-ls)
;;config for REPL
(global-set-key (kbd "C-c si") 'python-shell-switch-to-shell)
(global-set-key (kbd "C-c sf") 'python-shell-send-defun)
(global-set-key (kbd "C-c sr") 'python-shell-send-region)
;;config for flycheck
(global-set-key (kbd "C-c el") 'flycheck-list-errors)
(global-set-key (kbd "C-c en") 'flycheck-next-error)
(global-set-key (kbd "C-c ep") 'flycheck-previous-error)

;;config for popwin, use c-g to quit window
(require 'popwin)
(popwin-mode t)
(push "*Flycheck errors*" popwin:special-display-config)

;; add helm everywhere
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h f") 'helm-apropos)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "C-h C-l") 'helm-locate-library)
(global-set-key (kbd "C-c f") 'helm-recentf)


;; 辅助

;; ido-mode
(ido-mode t)

;; smex
(setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; server-mode
(require 'server)
(unless (server-running-p)
  (server-start))



;; jedi mode for python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)  



;; monokai mode
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)


;; use ipython as python interpreter

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "--simple-prompt -i")
 ;; python-shell-interpreter-args "--colors=Linux --profile=default"
 ;; python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 ;; python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 ;; python-shell-completion-setup-code
 ;; "from IPython.core.completerlib import module_completion"
 ;; python-shell-completion-module-string-code
 ;; "';'.join(module_completion('''%s'''))\n"
 ;; python-shell-completion-string-code
 ;; "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")


;; use jupyeter notebook
;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/extern_el/emacs-websocket/")

;; load websocket
(load "websocket.el")

(require 'websocket)
(require 'request)
(require 'ein)
(require 'smartrep)

