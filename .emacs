;;将~/.emacs.d/mylisp / 添加到加载路径
(add-to-list 'load-path "/home/***/.emacs.d/mylisp/")
;;关闭起动时的那个“开机画面”
(setq inhibit-startup-message t)
;;centos下无法下载color-theme，暂时关闭
;;(require 'color-theme)
;;(color-theme-initialize)
;;这个是你选择的主题，后面的calm forest是它的名字，注意使用小写。
;;(color-theme-calm-forest)
;;;显示行号
(global-linum-mode 1)

;;将光标修改为竖线
(setq-default cursor-type 'bar)

;;用一个很大的 kill ring. 这样防止我不小心删掉重要的东西
(setq kill-ring-max 200)

;;把 fill-column 设为 60. 这样的文字更好读
(setq default-fill-column 60)

;;;添加约会提醒功能
(setq appt-issue-message t)

;;;用这个，按f11进入全屏模式：）
;;参考http: //www.emacswiki.org/cgi-bin/wiki/FullScreen#toc1
;;;这段代码什么意思我不明白，音乐猜测是把set-frame-parameter置为0就是nil
;;;然后启用fullscreen
;;;反正用它能够成功就行了
(defun fullscreen()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
;;; 我还是不想要tool-bar，就是有那些快捷图标的任务栏，所以关闭它。
;;;(if (fboundp 'tool-bar-mode) (tool-bar-mode -1)) ;;no toolbar
;;;把开启和关闭全屏幕的快捷键设置为f11
(global-set-key[f11] 'fullscreen)

;;; ### Indent ###
;;; --- 缩进设置
(setq-default indent-tabs-mode t) ;默认不用空格替代TAB
(setq default-tab-width 4) ;设置TAB默认的宽度
(dolist (hook (list ;设置用空格替代TAB的模式
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
               'scheme-mode-hook
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'haskell-mode-hook
               'asm-mode-hook
               'emms-tag-editor-mode-hook
               'sh-mode-hook
               ))
  (add-hook hook '(lambda () (setq indent-tabs-mode nil))))

;;防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000)

;;括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线
(mouse-avoidance-mode 'animate)

;;在标题栏显示buffer的名字，而不是 emacs@wangyin.com 这样没用 的提示
(setq frame-title-format "emacs@%b")

;;进行语法加亮
(global-font-lock-mode t)

;;把这些缺省禁用的功能打开
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

;;设置一下备份时的版本控制，这样更加安全
(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)

;;一个简单的办法设置 auto-mode-alist, 免得写很多 add-to-list.
(mapcar
 (function (lambda (setting)
             (setq auto-mode-alist
                   (cons setting auto-mode-alist))))
 '(("\\.xml$". sgml-mode)
   ("\\\.bash" . sh-mode)
   ("\\.rdf$". sgml-mode)
   ("\\.session" . emacs-lisp-mode)
   ("\\.l$" . c-mode)
   ("\\.css$" . css-mode)
   ("\\.cfm$" . html-mode)
   ("gnus" . emacs-lisp-mode)
   ("\\.idl$" . idl-mode)))

;;设置有用的个人信息。这在很多地方有用
(setq user-full-name "safesky")
(setq user-mail-address "safeskycn@gmail.com")

;;实现代码折叠功能
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-style "bsd")
            (hs-minor-mode)
            (local-set-key "\C-c\t" 'complete-symbol)
            (local-set-key "\C-m" 'newline-and-indent)
            (setq mslk-c++-key (make-keymap))
            (local-set-key "\C-j" mslk-c++-key)
            (define-key mslk-c++-key "\C-j" 'complete-symbol)
            (define-key mslk-c++-key "\C-o" 'hs-hide-all)
            (define-key mslk-c++-key "\C-p" 'hs-show-all)
            (define-key mslk-c++-key "\C-h" 'hs-hide-block)
            (define-key mslk-c++-key "\C-u" 'hs-show-block)
            (define-key mslk-c++-key "\C-l" 'hs-hide-level)
            (define-key mslk-c++-key "\C-m" 'hs-toggle-hiding)
            ))
(add-hook 'c-mode-hook 'c++-mode)

;;20150420对emacs配置文件做如下调整，所有非本地插件设置，全部放在最后，备忘！fengg
(add-to-list 'load-path "~/.emacs.d/mylisp")
(require 'auto-complete-config)
(ac-config-default)

;;添加auto-complete-clang插件
;;先装载auto-complete-clang建议安装yasnippet
(add-to-list 'load-path "~/.emacs.d/mylisp")
(require 'yasnippet)
(yas-global-mode 1)
(require 'auto-complete-clang)
(setq ac-clang-auto-save t)
(setq ac-auto-start t)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)
(define-key ac-mode-map [(control tab)] 'auto-complete)
(defun my-ac-config ()
  (setq ac-clang-flags
          (mapcar(lambda (item)(concat "-I" item))
                         (split-string
                                         /usr/lib/gcc/x86_64-pc-cygwin/5.4.0/include/c++
                                         /usr/lib/gcc/x86_64-pc-cygwin/5.4.0/include/c++/x86_64-pc-cygwin
                                         /usr/lib/gcc/x86_64-pc-cygwin/5.4.0/include/c++/backward
                                         /usr/lib/gcc/x86_64-pc-cygwin/5.4.0/include
                                         /usr/include
                                         /usr/lib/gcc/x86_64-pc-cygwin/5.4.0/../../../../lib/../include/w32api
                                         ")))
(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
(add-hook 'css-mode-hook 'ac-css-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
(setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)
