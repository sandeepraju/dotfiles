;; The following elisp code has been hacked together
;; from various resources all over the internet.

;; Few references here:
;;    [01] http://stackoverflow.com/a/10093312/1044366
;;    [02] http://stackoverflow.com/a/10095853/1044366
;;    [03] http://stackoverflow.com/a/15962540/1044366
;;    [04] http://stackoverflow.com/a/21989454/1044366
;;    [05] http://stackoverflow.com/a/18330742/1044366
;;    [06] http://stackoverflow.com/a/65473/1044366
;;    [07] http://stackoverflow.com/a/64558/1044366
;;    [08] http://stackoverflow.com/a/11624677/1044366
;;    [09] http://stackoverflow.com/a/4160949/1044366
;;    [10] https://www.reddit.com/r/emacs/comments/4fqu0a/automatically_install_packages_on_startup/d2ba42o
;;    [11] http://stackoverflow.com/a/6415812
;;    [12] http://stackoverflow.com/a/322690
;;    [13] http://stackoverflow.com/a/3316038


;; Set the emacs config directory.
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory "~/.emacs.d/"))

;; List the package repositories (elpa, gnu, melpa).
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  ;; (add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/") t)
  ;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by [1]
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Install the required packages
(ensure-package-installed 'use-package 'nyan-mode 'company 'ws-butler 'helm 'undo-tree 'multiple-cursors 'smartparens 'gist 'markdown-mode 'elpy)

;; Install the required themes.
(ensure-package-installed 'sublime-themes 'monokai-theme 'color-theme-solarized 'molokai-theme 'hipster-theme 'gotham-theme)

;; Activate installed packages.
(package-initialize)

;; Load the `use-package` package.
(eval-when-compile
  (require 'use-package))

;; Package specifc configs.
;; `nyan-mode` config.
(if (display-graphic-p)
    (use-package nyan-mode
      :config
      (nyan-mode)
      (setq nyan-wavy-trail t)
      (nyan-start-animation)
      )
  )

;; `company-mode` configs.
(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode t)
  )

;; `ws-butler` configs.
(use-package ws-butler)

;; `helm` configs.
(use-package helm
  :config
  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))

  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
        helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t)
  (helm-autoresize-mode 1)
  (helm-mode 1))
(use-package helm-config)

;; `undo-tree` configs.
(use-package undo-tree
  :init
  (setq undo-tree-auto-save-history t)
  (global-undo-tree-mode))
(setq undo-tree-history-directory-alist '((".*" . "~/.emacs.d/undo-list")))

;; `multiple-cursors` configs.
(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; `smartparens` configs.
(use-package smartparens
  :config
  (show-smartparens-global-mode t)
  (smartparens-global-mode t))

;; `gist` configs.
(use-package gist)

;; `markdown-mode` configs.
(use-package markdown-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;; Load the required theme.
(if (display-graphic-p)
    (load-theme 'monokai t)
  (load-theme 'dorsey t))

;; Line & column numbers.
(global-linum-mode t)
(setq line-number-mode t)
(setq column-number-mode t)

;; Prevent the cursor from blinking.
(blink-cursor-mode 0)

;; Don't show messages that you don't read.
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Enable soft wrapping.
(visual-line-mode t)

;; Always highlight cursor line.
(global-hl-line-mode t)

;; Set appropriate line number gutter.
(setq linum-format "%4d ")

;; Set custom typeface and size
(set-default-font "Monaco 12")

;; Revert files automatically
(global-auto-revert-mode t)

;; Don't litter the working directory.
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;; Yank and paste elsewhere.
(setq x-select-enable-clipboard t)

;; Replace yes or no with y or n.
(defalias 'yes-or-no-p 'y-or-n-p)

;; No more tabs
(setq-default indent-tabs-mode nil)

;; Set default tab width to 4
(setq-default tab-width 4)

;; Confirm before quitting.
(if (display-graphic-p)
    (bind-key
     "C-x C-c"
     (lambda ()
       (interactive)
       (if (y-or-n-p "Quit Emacs? ")
           (save-buffers-kill-emacs))))
  )

;; Toggle line numbers
(global-set-key (kbd "M-\\") 'global-linum-mode)

;; Minimal emacs looks good.
(tool-bar-mode -1)
(menu-bar-mode -1)
(if (display-graphic-p)
    (scroll-bar-mode -1))


;; Custom functions

;; Indent & un-indent
(defun my-indent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(global-set-key ">" 'my-indent-region)
(global-set-key "<" 'my-unindent-region)


;; Smoother scroll. Way better than the default.
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;; Specify the virtual environment for emacs to use.
(push "~/.virtualenvs/emacs/bin" exec-path)
(setenv "PATH"
        (concat
         "~/.virtualenvs/emacs/bin" ":"
         (getenv "PATH")
         ))

;; Set up Python Development Environment.
;; Pre-requisites:
;; # Either of these
;; pip install rope
;; pip install jedi
;; # flake8 for code checks
;; pip install flake8
;; # and importmagic for automatic imports
;; pip install importmagic
(use-package elpy
  :config
  (elpy-enable))

;; set the $PATH from shell
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;; Setup per mode hooks
;; untabify some modes
(setq untabify-modes '(python-mode emacs-lisp-mode lisp-mode))
(defun untabify-hook ()
  (when (member major-mode untabify-modes)
     (untabify (point-min) (point-max))))
(add-hook 'before-save-hook 'untabify-hook)
