
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)

  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(setq load-path (cons "~/.emacs.d/elpa" load-path))


;;theme
;;(load-theme 'forest-blue t)
(load-theme 'monokai t)(setq monokai-gray "#E06C75")
;;(load-theme 'zenburn t)
;;(load-theme 'moe-dark t)

;;日本語フォントの設定
(set-fontset-font t 'japanese-jisx0208 "TakaoPGothic")
;;helm
(require 'helm)
(require 'helm-config)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "M-r")     'helm-resume)
(define-key global-map (kbd "C-M-h")   'helm-apropos)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal


;;powerllinesce
(require 'powerline)
 
(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (setq powerline-current-separator 'utf-8)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'mode-line-1-fg 'mode-line-2-fg))
                          (face2 (if active 'mode-line-1-arrow 'mode-line-2-arrow))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (lhs (list (powerline-raw " " face1)
                                     (powerline-major-mode face1)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-buffer-id nil )
                                     (powerline-raw " [ ")
                                     (powerline-raw mode-line-mule-info nil)
                                     (powerline-raw "%*")
                                     (powerline-raw " |")
                                     (powerline-process nil)
                                     (powerline-vc)
                                     (powerline-raw " ]")
                                     ))
                          (rhs (list (powerline-raw "%4l")
                                     (powerline-raw ":")
                                     (powerline-raw "%2c")
                                     (powerline-raw " | ")                                  
                                     (powerline-raw "%6p")
                                     (powerline-raw " ")
                                     )))
                     (concat (powerline-render lhs)
                             (powerline-fill nil (powerline-width rhs)) 
                             (powerline-render rhs)))))))

(defun make/set-face (face-name fg-color bg-color weight)
  (make-face face-name)
  (set-face-attribute face-name nil
                      :foreground fg-color :background bg-color :box nil :weight weight))
(make/set-face 'mode-line-1-fg "#282C34" "#EF8300" 'bold)
(make/set-face 'mode-line-2-fg "#AAAAAA" "#2F343D" 'bold)
(make/set-face 'mode-line-1-arrow  "#AAAAAA" "#3E4451" 'bold)
(make/set-face 'mode-line-2-arrow  "#AAAAAA" "#3E4451" 'bold)

(powerline-my-theme)


;;active windowをわかりやすくするよう色を変更
;;(require 'hiwin)
;;(hiwin-activate)                           ;; hiwin-modeを有効化
;;(set-face-background 'hiwin-face "gray80") ;; 非アクティブウィンドウの背景色を設定
;;clang-format
(require 'clang-format)
(global-set-key (kbd "C-c u") 'clang-format-buffer)
;;(global-set-key [C-M-tab] 'clang-format-region)
(global-set-key (kbd "C-c i") 'clang-format-region)
(setq clang-format-style-option "llvm")

;;autopair
(require 'autopair)
(autopair-global-mode)

;;trr
(add-to-list 'load-path "/home/mech-user/.emacs.d/emacs-trr/")
(setq trr-japanese t) ;; uncomment this to play with japanese mode
(require 'trr)


;; rainbow-delimiters を使うための設定
(add-to-list 'load-path "/home/mech-user/.emacs.d/rainbow-delimiters/")
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;rosemacs
;;(add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
;;(require 'rosemacs-config)
;;(global-set-key "\C-x\C-r" ros-keymap)

;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)



;;company-mode
(add-to-list 'load-path "/home/mech-user/.emacs.d/elpa/company-0.9.6/")
(require 'company)
(global-company-mode) ; 全バッファで有効にする
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(add-to-list 'company-backends 'company-irony)

;;(eval-after-load "irony"
;;  '(progn
;;     (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
;;     ;;(add-to-list 'company-backends 'company-irony)
;;     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;;          (add-hook 'c-mode-common-hook 'irony-mode)))
;;


(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;python
(require 'jedi-core)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
;;(jedi:install-server)
(add-hook 'python-mode-hook 'jedi:setup)
(add-to-list 'company-backends 'company-jedi)

;;bash-completion
(require 'bash-completion)
(bash-completion-setup)
;; バックアップファイルを作成させない
;;(setq make-backup-files nil)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; スタートアップメッセージを表示させない
;;(setq inhibit-startup-message 1)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")


;; ターミナルで起動したときにメニューを表示しない
(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)(setq inhibit-startup-message 1)

;;タブにスペースを使用する
;;(setq-default tab-width 4 indent-tabs-mode nil)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; 複数ウィンドウを禁止する
;;(setq ns-pop-up-frames nil)

;; ウィンドウを透明にする
;; アクティブウィンドウ／非アクティブウィンドウ（alphaの値で透明度を指定）
;;(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; メニューバーを消
(menu-bar-mode -1)

;; ツールバーを消す
(tool-bar-mode -1)

;; 列数を表示する
(column-number-mode t)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

;; 行数を表示する
(global-linum-mode t)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; カーソル行をハイライトする
(global-hl-line-mode t)

;; 対応する括弧を光らせる
(show-paren-mode t)
(set-face-background 'show-paren-match nil)
(set-face-attribute 'show-paren-match nil
                    :inherit 'highlight)

;; スペース、タブなどを可視化する
;;(global-whitespace-mode 1)



;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; シフト＋矢印で範囲選択
(setq pc-select-selection-keys-only t)

;; C-kで行全体を削除する
(setq kill-whole-line t)

(put 'upcase-region 'disabled nil)


;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

;; 画面の移動をalt+矢印キーで行く
(global-set-key (kbd "<M-left>")  'windmove-left)
(global-set-key (kbd "<M-down>")  'windmove-down)
(global-set-key (kbd "<M-up>")    'windmove-up)
(global-set-key (kbd "<M-right>") 'windmove-right)

;;reload
(global-set-key
 [f9] 'eval-buffer)

;;flycheck
(require 'flycheck)

;;選択bufferを大きくする golden ratio
;;(golden-ratio-mode 1)

;;NeoTreeとの干渉回避のための例外処理
;;(add-to-list 'golden-ratio-exclude-buffer-names " *NeoTree*")

;;all-the-icons and neotree(require 'neotree)
(require 'font-lock+)
(require 'neotree)
(require 'all-the-icons)
;;(setq neo-theme 'icon)
(setq neo-theme 'icons)
;; 隠しファイルをデフォルトで表示
(setq neo-show-hidden-files t)
;; f8 でneotreeを起動
(global-set-key [f8] 'neotree-toggle)
;;(neotree-show)

;; sidebar and dired in one
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(custom-safe-themes
   (quote
    ("bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" "26d49386a2036df7ccbe802a06a759031e4455f07bda559dcf221f53e8850e69" "13d20048c12826c7ea636fbe513d6f24c0d43709a761052adbca052708798ce3" "e03d2f414fb109f3920752b10b92323697174f49d577da9e69979edbb147a921" "bd51a329aa9b8e29c6cf2c8a8cf136e0d2960947dfa5c1f82b29c9178ad89a27" default)))
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(irony-additional-clang-options (quote ("-std=c++11")))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (company-irony-c-headers helm flycheck bash-completion autopair jedi-direx moe-theme powerline zenburn-theme monokai-theme forest-blue-theme python-mode neotree jedi golden-ratio context-coloring company-jedi company-irony clang-format all-the-icons)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; redo+
(require 'redo+)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-r") 'redo)
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

 
;;選択範囲を移動
(defun move-region-down ()
  (interactive)
  (let ((col (current-column)))
    (kill-region (region-beginning) (region-end))
    (forward-line 1)
    (yank)
    (set-mark  (region-beginning) (region-end))
    (move-to-column col)))

(defun move-region-up ()
  (interactive)
  (let ((col (current-column)))
    (kill-region (region-beginning) (region-end))
    (forward-line -1)
    (yank)
    (set-mark (region-beginning) (region-end))
    (move-to-column col)))
(global-set-key (kbd "C-,")  'move-region-down)
(global-set-key (kbd "C-.")  'move-region-up)


;;矩形選択の先頭に文字列を挿入
(global-set-key (kbd "C-x a") 'string-rectangle)

;;end-of-bufferをC-pagedownに設定
(global-set-key (kbd "M-.") 'end-of-buffer)


;; 透明度を変更するコマンド M-x set-alpha
;; http://qiita.com/marcy@github/items/ba0d018a03381a964f24
(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))

