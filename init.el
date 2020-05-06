;;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(exec-path-from-shell-initialize)

;; open buffer in the same window
(global-set-key "\C-x\C-b" 'buffer-menu)
;; backspace instead of help
(global-set-key "\C-h" 'delete-backward-char)
;; visualize matching brackets
(show-paren-mode 1)
;; highlight current line
(global-hl-line-mode 1)
(ido-mode t)
(setq inhibit-splash-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(global-set-key (kbd "s-r") 'revert-buffer)
(set-face-attribute 'default nil :height 100)
(global-linum-mode t)
(column-number-mode t)
;; theme. https://github.com/emacs-jp/replace-colorthemes/blob/master/dark-laptop-theme.el
(load-file "~/.emacs.d/dark-laptop-theme.el")

;;; window management
(split-window-right)                ; split vertically the window at startup
(setq split-height-threshold 100)   ; and prevent commands from splitting further
(require 'buffer-move)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
(global-set-key (kbd "<C-S-up>")  'buf-move-up)
(global-set-key (kbd "<C-S-down>")  'buf-move-down)
(setq buffer-move-behavior 'move)
(windmove-default-keybindings)    ; move to other window by S-right etc.

;;; git
(require 'magit)
(global-set-key (kbd "C-x m") 'magit-status)
(define-key magit-mode-map (kbd "RET") 'magit-diff-visit-file-other-window)

;;; org mode - override org-mode default to favor general window switching
(require 'org)
(define-key org-mode-map (kbd "<C-S-left>") nil)
(define-key org-mode-map (kbd "<C-S-right>") nil)
(define-key org-mode-map (kbd "<C-S-up>") nil)
(define-key org-mode-map (kbd "<C-S-down>") nil)
(define-key org-mode-map (kbd "<S-up>") nil)
(define-key org-mode-map (kbd "<S-down>") nil)
(define-key org-mode-map (kbd "<S-left>") nil)
(define-key org-mode-map (kbd "<S-right>") nil)

;;; whitespaces
(require 'whitespace)
(setq whitespace-line-column -1)
(setq whitespace-style `(face trailing tabs lines newline))
(global-whitespace-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;; Python
(require 'python)
(define-key python-mode-map (kbd "C-x p") 'insert-pdb-set-trace)
(defun insert-pdb-set-trace ()
  "Insert pdb."
  (interactive)
  (insert "import pdb; pdb.set_trace()"))

;;; flycheck
(global-flycheck-mode)
(global-set-key (kbd "s-n") 'flycheck-next-error)
(global-set-key (kbd "s-p") 'flycheck-previous-error)
(global-set-key (kbd "s-l") 'flycheck-list-errors)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))    ; show error/warning message at tooltip
