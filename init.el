;;; packages
(setq custom-file "~/.emacs.d/custom.el")  ; I have no intention of using it for now
(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; open buffer in the same window
(global-set-key "\C-x\C-b" 'buffer-menu)
;; backspace instead of help
(global-set-key "\C-h" 'delete-backward-char)
;; visualize matching brackets
(show-paren-mode 1)
;; highlight current line
(global-hl-line-mode 1)
(setq inhibit-splash-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(global-set-key (kbd "s-r") 'revert-buffer)
(set-face-attribute 'default nil :height 100)
(global-linum-mode t)
(column-number-mode t)

;;; window navigation
(split-window-right)                ; split vertically the window at startup
(setq split-height-threshold 100)   ; and prevent commands from splitting further
(windmove-default-keybindings)      ; move to other window by S-right etc.
(winner-mode)
(global-set-key (kbd "C-c p") 'winner-undo)
(global-set-key (kbd "C-c n") 'winner-redo)
(use-package buffer-move
  :config
  (global-set-key (kbd "<C-S-left>")   'buf-move-left)
  (global-set-key (kbd "<C-S-right>")  'buf-move-right)
  (global-set-key (kbd "<C-S-up>")  'buf-move-up)
  (global-set-key (kbd "<C-S-down>")  'buf-move-down)
  (setq buffer-move-behavior 'move))

(use-package ivy
  :config
  (ivy-mode 1))
(use-package swiper
  :config
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "C-r") 'swiper-backward))

;;; git
(use-package magit
  :config
  (global-set-key (kbd "C-x m") 'magit-status)
  (define-key magit-hunk-section-map (kbd "RET") 'magit-diff-visit-file-other-window))

;;; org mode - override org-mode default to favor general window switching
(use-package org
  :config
  (define-key org-mode-map (kbd "<C-S-left>") nil)
  (define-key org-mode-map (kbd "<C-S-right>") nil)
  (define-key org-mode-map (kbd "<C-S-up>") nil)
  (define-key org-mode-map (kbd "<C-S-down>") nil)
  (define-key org-mode-map (kbd "<S-up>") nil)
  (define-key org-mode-map (kbd "<S-down>") nil)
  (define-key org-mode-map (kbd "<S-left>") nil)
  (define-key org-mode-map (kbd "<S-right>") nil))

;;; whitespaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(use-package whitespace
  :config
  (setq whitespace-line-column -1)
  (setq whitespace-style `(face trailing tabs lines newline))
  (global-whitespace-mode 1))

;;; Python
(defun insert-pdb-set-trace ()
  "Insert pdb."
  (interactive)
  (insert "import pdb; pdb.set_trace()"))
(use-package python
  :config
  (define-key python-mode-map (kbd "C-x p") 'insert-pdb-set-trace))

;;; flycheck
(use-package flycheck
  :config
  (global-flycheck-mode)
  (global-set-key (kbd "s-n") 'flycheck-next-error)
  (global-set-key (kbd "s-p") 'flycheck-previous-error)
  (global-set-key (kbd "s-l") 'flycheck-list-errors))
(use-package flycheck-pos-tip
  :after (flycheck)
  :config
  (flycheck-pos-tip-mode))  ; show error/warning message at tooltip

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (define-key company-mode-map (kbd "C-c SPC") 'company-complete))

(use-package lsp-mode
  :hook ((python-mode . lsp))
  :commands lsp
  :config
  (define-key lsp-mode-map (kbd "C-c SPC") 'completion-at-point))

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package color-theme-sanityinc-tomorrow
  :config
  (load-theme 'sanityinc-tomorrow-night t))
