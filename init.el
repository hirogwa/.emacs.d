;;;; packages
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

;;;; theme
;; https://github.com/emacs-jp/replace-colorthemes/blob/master/dark-laptop-theme.el
(load-file "~/.emacs.d/dark-laptop-theme.el")

;;;; line/column number
(global-linum-mode t)
(column-number-mode t)

;;;; windows
(split-window-right)
;;; moving around windows
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
(setq buffer-move-behavior 'move)
(windmove-default-keybindings)

;;;; git
(require 'magit)
(global-set-key (kbd "C-x m") 'magit-status)

;;;; org mode
;;; override org-mode default to favor general window switching
(require 'org)
(define-key org-mode-map (kbd "<C-S-left>") nil)
(define-key org-mode-map (kbd "<C-S-right>") nil)
(define-key org-mode-map (kbd "<S-up>") nil)
(define-key org-mode-map (kbd "<S-down>") nil)
(define-key org-mode-map (kbd "<S-left>") nil)
(define-key org-mode-map (kbd "<S-right>") nil)

;;;; auto-complete
(require 'auto-complete)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-modes 'js2-jsx-mode)
(global-auto-complete-mode t)

;;;; coding general
;;; whitespaces
(setq whitespace-line-column -1)
(setq whitespace-style (quote (face trailing tabs lines)))
(global-whitespace-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;;; JavaScript
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))

;;;; Python
(require 'python)
(define-key python-mode-map (kbd "C-x p") 'insert-pdb-set-trace)
(defun insert-pdb-set-trace ()
  "Insert pdb"
  (interactive)
  (insert "import pdb; pdb.set_trace()"))

;;;; markdown
(custom-set-variables
 '(markdown-command "/usr/local/bin/pandoc"))

;;;; flycheck
(global-flycheck-mode)
(global-set-key (kbd "s-n") 'flycheck-next-error)
(global-set-key (kbd "s-p") 'flycheck-previous-error)
(global-set-key (kbd "s-l") 'flycheck-list-errors)
;; show error/warning message at tooltip
;; uses flycheck-pos-tip.el
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)
  (flycheck-pos-tip-mode))
