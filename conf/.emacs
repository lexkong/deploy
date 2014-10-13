;; .emacs

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-switches "-u"))

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)

;;w3m相关设置
;;使用Emacs-w3m浏览网页
(add-to-list 'load-path "/usr/local/src/emacs_plugins/emacs-w3m-1.4.4/share/emacs/site-lisp/w3m")
(require 'w3m-load)
(setq w3m-home-page "http://www.google.com.")

(autoload 'w3m "w3m" "interface for w3m on emacs" t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
(setq w3m-use-cookies t)
;;(require 'mime-w3m) 
(setq w3m-default-display-inline-image t) 
(setq w3m-default-toggle-inline-images t)

;;emacs org mode
;;(setq load-path (cons "~/lib/emacs-lisp/org-7.01h/lisp" load-path))
;;(setq load-path (cons "~/lib/emacs-lisp/org-7.01h/contrib/lisp" load-path))

;;(require 'org-install)
;;(require 'org-publish)
;;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;;(add-hook 'org-mode-hook 'turn-on-font-lock)
;;(add-hook 'org-mode-hook 
;;(lambda () (setq truncate-lines nil)))

;;(global-set-key "\C-cl" 'org-store-link)
;;(global-set-key "\C-ca" 'org-agenda)
;;(global-set-key "\C-cb" 'org-iswitchb)

(setq org-startup-indented t)
(add-to-list 'load-path "~/.emacs.d/o-blog")(require 'o-blog)
;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-02-23 13:52:32 Tuesday by ahei>

(require 'w3m)
(require 'w3m-lnum)
;;(require 'util)

(defvar w3m-buffer-name-prefix "*w3m" "Name prefix of w3m buffer")
(defvar w3m-buffer-name (concat w3m-buffer-name-prefix "*") "Name of w3m buffer")
(defvar w3m-bookmark-buffer-name (concat w3m-buffer-name-prefix "-bookmark*") "Name of w3m buffer")
;;(defvar w3m-dir (concat my-emacs-lisps-path "emacs-w3m/") "Dir of w3m.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  设置emacs-w3m浏览器
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/emacs-w3m/")
(require 'w3m-load)
;;(require 'mime-w3m)
(autoload 'w3m "w3m" "interface for w3m on emacs" t) 

;; 设置w3m主页
(setq w3m-home-page "http://www.google.com")

;; 默认显示图片
(setq w3m-default-display-inline-images t)
(setq w3m-default-toggle-inline-images t)

;; 使用cookies
(setq w3m-use-cookies t)

;;设定w3m运行的参数，分别为使用cookie和使用框架  
(setq w3m-command-arguments '("-cookie" "-F"))               

;; 使用w3m作为默认浏览器
(setq browse-url-browser-function 'w3m-browse-url)                
(setq w3m-view-this-url-new-session-in-background t)


;;显示图标                                                      
(setq w3m-show-graphic-icons-in-header-line t)                  
(setq w3m-show-graphic-icons-in-mode-line t) 

;;C-c C-p 打开，这个好用                                        
(setq w3m-view-this-url-new-session-in-background t)  


(add-hook 'w3m-fontify-after-hook 'remove-w3m-output-garbages)                                    
(defun remove-w3m-output-garbages ()                            
  "去掉w3m输出的垃圾."                                            
  (interactive)                                                   
  (let ((buffer-read-only))                                       
    (setf (point) (point-min))                                      
    (while (re-search-forward "[\200-\240]" nil t)                  
      (replace-match " "))                                            
    (set-buffer-multibyte t))                                       
  (set-buffer-modified-p nil))

;;给org-mode 设置自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;)


;; do not automatically append a newline at the end of file, 去掉换行符 \， 据说是万年遗留问题
(setq require-final-newline nil)

;;设定代码高亮
(setq org-src-fontify-natively t)


;;;;;; 使用 xelatex 编译生成 PDF 文件
(setq org-latex-to-pdf-process
      '("xelatex -interaction nonstopmode %b"
        "xelatex -interaction nonstopmode %b"))

;; 设定语法高亮
(setq org-export-latex-listings t)
;; 设置交叉引用
(setq org-export-latex-hyperref-format "\\ref{%s}")

;;TODO 进度记录
(setq org-log-done 'time)
(setq org-log-done 'note)



(setq jabber-account-list
      '(("waterlin.org@gmail.com"
         (:network-server . "talk.google.com")
         (:connection-type . ssl))))

;;不要工具栏
(tool-bar-mode -1) 
;;不要菜单栏
(menu-bar-mode -1) 
;;(add-to-list 'load-path "~/.emacs.d/")(require 'ansys-mode "ansys-mode.el")
(add-to-list 'load-path "~/.emacs.d/")(require 'ks-mode "ks-mode.el")

;;设置自动缩进一个TAB为4个空格
(setq c-basic-offset 4)

;;org-mode 设置默认browse
(setq browse-url-generic-program "firefox")
;;(setq browse-url-browser-function ’firefox)
;;(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program firefox")


;;显示列号
(setq column-number-mode t)

;;不要总是没完没了的问yes or no, 为什么不能用y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;语法高亮
(global-font-lock-mode t) 

;在状态条上显示当前光标在哪个函数体内部   
(which-function-mode t)     

;; 用一个很大的kill ring. 这样防止我不小心删掉重要的东西
(setq kill-ring-max 1024)

;;; ### Indent ###
;;; --- 缩进设置
(setq-default indent-tabs-mode t)       ;默认不用空格替代TAB
(setq default-tab-width 4)              ;设置TAB默认的宽度
(setq require-final-newline nil)        ;不自动添加换行符到末尾, 有些情况会出现错误

(setq browse-url-generic-program (executable-find "firefox")
    browse-url-browser-function 'browse-url-generic)

;;(global-linum-mode 1);;启用全局显示行号模式

;;颜色主题设置
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0") 
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-gnome2) 
;;(global-set-key (kbd "C-c / a") 'color-theme-ahei)

;;智能括号
;;(require 'autopair)      ;;智能自动补全括号 http://www.emacswiki.org/emacs/AutoPairs
;;(require 'auto-pair+)
;;(autopair-global-mode 1) ;; 全局启用智能补全括号
;;(require 'highlight-parentheses)        ;智能括号匹配高亮 http://www.emacswiki.org/emacs/HighlightParentheses
;;(setq show-paren-style 'parentheses)    ;括号匹配显示但不是烦人的跳到另一个括号。


;;高亮显示设置
(require 'generic-x);;更加丰富的高亮
;;(require 'crosshairs) ;;高亮显示光标所在行和列 没啥好用的http://www.emacswiki.org/emacs/CrosshairHighlighting 
;;(require 'hl-line+) ;;http://www.emacswiki.org/emacs/HighlightCurrentLine
;;(toggle-hl-line-when-idle 1) ;;仅在emacs空闲时高亮本行
;;高亮显示关键字
;;(require 'highlight-fixmes-mode)
;;(highlight-fixmes-mode);;启用关键字高亮功能
;;(global-set-key (kbd "C-c / M-f") 'highlight-fixmes-mode)
;; 高亮显示当前buffer中的一个符号 Quickly highlight a symbol throughout the buffer and cycle through its locations.
;;(require 'highlight-symbol)
;;(global-set-key (kbd "C-c / M-h a") 'highlight-symbol-at-point)
;;(global-set-key (kbd "C-c / M-h n") 'highlight-symbol-next)
;;(global-set-key (kbd "C-c / M-h p") 'highlight-symbol-prev)


;;高亮显示c语言的变量类型
;;(require 'ctypes) ;;暂时没看出效果
;;(setq ctypes-write-types-at-exit t)
;;(ctypes-read-file nil nil t t)
;;(ctypes-auto-parse-mode 1)



;;显示空格
;;(require 'show-wspace)   ;空格提示 http://www.emacswiki.org/emacs/ShowWhiteSpace



;;Buffer管理
;; 按下C-x k立即关闭掉当前的buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)



;;(require 'org-extension) ;;org模式增强
;;(require 'buffer-extension) ;;buffer操作增强

(require 'icomplete) 
(icomplete-mode 99) ;;启用M-x命令提示

;; 显示括号匹配
(show-paren-mode t)
;;(setq show-paren-style 'parentheses)

;; 显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)


(transient-mark-mode t) 

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t) 

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t) 

;; 去掉滚动栏
(scroll-bar-mode nil)



;; 去掉工具栏
;;(tool-bar-mode nil)

;;去掉菜单栏
;;(menu-bar-mode nil)


;; 方法为: emacs->options->Set Default Font->"M-x describe-font"查看当前使用的字体名称、字体大小
(set-default-font " -bitstream-Courier 10 Pitch-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")


;; 显示列号
(setq column-number-mode t)
(setq line-number-mode t)
