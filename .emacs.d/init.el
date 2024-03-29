;;; init.el --- Emacs configuration
;;; Code:

;; Padding
(set-frame-parameter nil 'internal-border-width 20)

;; For new frames, padding + transparency, and disabling of scroll
;; bars.
(setq default-frame-alist '((alpha . (86 . 86))
                            (internal-border-width . 20)
                            (left-fringe . 0)
                            (right-fringe . 0)
                            (vertical-scroll-bars)))

;; https://stackoverflow.com/a/33298750
(defun on-frame-open (&optional frame)
  "If the FRAME created in terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

(add-hook 'after-make-frame-functions 'on-frame-open)

(when (string= system-type "windows-nt") (add-to-list 'default-frame-alist '(alpha . (100 . 100))))

;; Disable that positively grotesque emacs startup.
(setq inhibit-startup-message t)

;; Removing some unneeded UI elements
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)


(lambda ()
  (unless (string= system-type "windows-nt")
  (let ((path-from-shell (replace-regexp-in-string
        "[ \t\n]*$" "" (replace-regexp-in-string
            "\s" ":" (shell-command-to-string
                "$SHELL --login -c 'echo $PATH'")))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator)))))

; disable backup
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
; disable auto save
(setq auto-save-default nil)

;; Add a hook to after-make-frame-functions to set the font.
;; This shouldn't be necessary, but for some reason, if we do not do
;; this, then the font emacs renders end up being weirdly aliased
;; until we evaluate this line a second time.
(set-face-attribute 'default nil :font "Cascadia Mono PL" :height 110)
(add-hook 'after-make-frame-functions (lambda (frame) (set-face-attribute 'default frame :font "Cascadia Mono PL" :height 110)))

;; Set default working directory to the notes directory on Windows
;; (the only thing I use emacs for on Windows):
(when (string= system-type "windows-nt") (setq default-directory "C:\\Users\\may\\Documents\\notes"))

;; Set tab-width
(setq-default tab-width 2)

;; Turn on line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Turn on relative line numbers
(setq-default display-line-numbers-type 'relative)

; Turn off ring-bell
(setq ring-bell-function 'ignore)

;; Stops scrolling from jumping up a lot when we hit the bottom or top of the buffer viewport.
(setq scroll-conservatively 101)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Package configuration

;;; Commentary:
;;

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
       ("melpa-stable" . "https://stable.melpa.org/packages/")
       ("org" . "https://orgmode.org/elpa/")
       ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
;; TODO: We may not need this.
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 '("570263442ce6735821600ec74a9b032bc5512ed4539faf61168f2fdf747e0668" "ce4234c32262924c1d2f43e6b61312634938777071f1129c7cde3ebd4a3028da" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "b99e334a4019a2caa71e1d6445fc346c6f074a05fcbb989800ecbe54474ae1b0" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "bf948e3f55a8cd1f420373410911d0a50be5a04a8886cabe8d8e471ad8fdba8e" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" default))
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
	 '(go-mode yasnippet yasnippet-snippets eglot dockerfile-mode yaml-mode fish-mode hl-todo frames-only-mode tree-sitter-langs tree-sitter prettier-js flycheck counsel-projectile projectile rustic company-box company typescript-mode org-autolist markdown-mode evil-surround org-bullets evil-magit magit evil-collection evil general all-the-icons doom-themes helpful counsel which-key rainbow-delimiters doom-modeline command-log-mode use-package))
 '(warning-suppress-types '((use-package) (use-package) (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(use-package frames-only-mode
  :config
  (frames-only-mode))

(use-package dash)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("RET" . ivy-alt-done)
         ("TAB" . ivy-next-line)
         ("<backtab>" . ivy-previous-line)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))

(use-package ivy-rich
	:after ivy
  :init
  (ivy-rich-mode 1))

(use-package all-the-icons)
(require 'doom-modeline)
(use-package doom-modeline
  :ensure t
  :config
  (setq doom-modeline-height 35)

  ;; Set the global mode string to some spaces to add artificial
  ;; padding to the end of the bar.
  (setq mode-line-misc-info '("  "))

  ;; Customize what's in our bar.
  (doom-modeline-def-modeline 'custom-line
    '(bar modals matches buffer-info selection-info)
    '(vcs checker misc-info))
  
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'custom-line 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)
  
  (doom-modeline-mode 1))

;; Set theme.
(use-package doom-themes
  :init (load-theme 'doom-nord))

(use-package rainbow-delimiters
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Vim emulation.
(require 'evil)
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
  (evil-set-undo-system 'undo-redo)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;;(evil-set-initial-state 'messages-buffer-mode 'normal)
  ;;(evil-set-initial-state 'dashboard-mode 'normal))
)

;; Sensible defaults for EVIL application in different contexts.
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package magit)

(defun may/org-font-setup ()
  "Replace list hyphen with dot."
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 0.95)
                  (org-level-6 . 0.90)
                  (org-level-7 . 0.85)
                  (org-level-8 . 0.80)))
    (set-face-attribute (car face) nil :height (cdr face))))

(use-package org
  :config
  (setq org-ellipsis " ▾"
  org-hide-emphasis-markers t
  org-startup-indented t
  org-edit-src-content-indentation 0)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (may/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("●" "●" "●" "●" "●" "●" "●")))

(use-package org-autolist
  :hook (org-mode . org-autolist-mode))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode))

(use-package dockerfile-mode
	:ensure t)

(use-package yasnippet
	:ensure t
	:config
	(define-key yas-minor-mode-map [(tab)]        nil)
	(define-key yas-minor-mode-map (kbd "TAB")    nil)
	(define-key yas-minor-mode-map (kbd "<tab>")  nil))

(require 'yasnippet)
(use-package yasnippet-snippets
	:after yasnippet
	:ensure t
	:config
	(yas-reload-all)
	(dolist (mode '(org-mode-hook go-mode-hook rust-mode-hook))
		(add-hook mode (lambda () (yas-minor-mode)))))

(use-package eglot
  :ensure t)

(use-package company
	:after eglot
	:hook (eglot-managed-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-select-next))
        (:map company-active-map
         ("<backtab>" . company-select-previous))
  :custom
  (company-selection-wrap-around t)
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
	:config
	;; Taken from:
	;; https://www.reddit.com/r/emacs/comments/bm8r3c/comment/emutora/
	;; Adds company-yasnippet to all company backends, so that company
	;; will start showing snippets.
	(setq company-backends
				(mapcar (lambda (backends)
									(if (and (listp backends) (memq 'company-yasnippet backends))
											backends
										(append (if (consp backends)
																backends
															(list backends))
														'(:with company-yasnippet)))) company-backends)))

(use-package company-box
  :hook (company-mode . company-box-mode)
	;; Add a hook to disable that attrocious vomit green default color for snippets in company-box.
	:hook (company-box-mode . (lambda () (setq company-box-backends-colors '()))))

(use-package tree-sitter)
(use-package tree-sitter-langs
  :after tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; NOTE: We do not NEED flycheck. eglot works with flymake
;; out-of-the-box. Flycheck is a bit nicer to work with though, so we
;; keep it around.
(require 'flycheck)
(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (defun run-flycheck (_)
    (flycheck-buffer))
  (add-to-list 'window-buffer-change-functions 'run-flycheck)
	;; Stops Flycheck from annoyingly spawning a new window (or frame
	;; for us) and stealing focus just because we forgot to deleted the
	;; wrong character for a brief second.
	(setq flycheck-display-errors-function nil))

(use-package typescript-mode
  :hook (typescript-mode . eglot-ensure)
  :config
  (setq typescript-indent-level 2)
  ;; we choose this instead of tsx-mode so that eglot can automatically figure out language for server
  (define-derived-mode typescriptreact-mode typescript-mode "TypeScript TSX")
  ;; use our derived mode for tsx files
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescriptreact-mode))
  ;; by default, typescript-mode is mapped to the treesitter typescript parser
  ;; use our derived mode to map both .tsx AND .ts -> typescriptreact-mode -> treesitter tsx
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))

(use-package hl-todo
  :config
  (global-hl-todo-mode))

(use-package prettier-js
  :init
  (add-hook 'typescript-mode-hook 'prettier-js-mode))

(use-package go-mode
  :hook (go-mode . eglot-ensure)
  :custom
  (gofmt-command "goimports")
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package fish-mode)

(use-package yaml-mode)

(use-package rustic
	:init
	(push 'rustic-clippy flycheck-checkers)
	:config
	;; Note that due to the below line, we do not need to make sure we
	;; add eglot-ensure on hook.
	(setq rustic-lsp-client 'eglot)
	(setq rustic-format-trigger 'on-save)
	(modify-syntax-entry ?_ "w" rust-mode-syntax-table))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/code")
    (setq projectile-project-search-path '("~/code")))
  (setq projectile-switch-project-action #'projectile-dired))
(require 'projectile)

(use-package counsel-projectile
  :config (counsel-projectile-mode)
	(setq counsel-rg-base-command "rg --hidden -g '!.git/' --with-filename --no-heading --line-number --color never %s"))

(require 'general)
(use-package general
  :after org
  :init
  (setq-default general-override-states '(emacs
                                          hybrid
                                          normal
                                          visual
                                          motion
                                          operator
                                          replace))
  :config
  (general-override-mode)
  (general-auto-unbind-keys)

  (defun may/switch-to-other-buffer ()
    "Switches to the other buffer (defined by other-buffer)."
    (interactive)
    (switch-to-buffer (other-buffer)))

  (defun may/kill-current-buffer ()
    (interactive)
    (kill-buffer (current-buffer)))

	(defun may/rename-file ()
		(interactive)
		(let* ((root (projectile-acquire-root))
					 (source (projectile-completing-read "Rename: " (projectile-project-files root)))
					 (abs-source (concat root source))
					 (src-rel-dir (file-name-directory source))
					 (base-dir (concat (projectile-acquire-root) src-rel-dir))
					 (target (read-file-name "To: " base-dir source nil)))
			(rename-file abs-source target)))

	(defun may/delete-file ()
		(interactive)
		(let* ((root (projectile-acquire-root))
					 (fi (projectile-completing-read "Delete: " (projectile-project-files root)))
					 (abs-fi (concat root fi)))
			(delete-file abs-fi)))

	;;

  ;; We should probably split this into further functions for each prefix.
  ;; I think we should get the SPC prefix working in visual mode... so we can have commands work on the visual selection.
  (general-def
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC"
  "f" '(find-file :which-key "find file")
  "bas" '(switch-to-buffer :which-key "switch buffers")
  "bs" '(projectile-switch-to-buffer :which-key "switch buffers")
  "bk" '(may/kill-current-buffer :which-key "kill current buffer")
  "bb" '(may/switch-to-other-buffer :which-key "switch to other buffer")
  "hv" '(describe-variable :which-key "describe a variable")
  "hf" '(describe-function :which-key "describe a function")
  "hc" '(describe-command :which-key "describe a command")
  "x" '(counsel-M-x :which-key "execute a command")
  "rr" '(eval-last-sexp :which-key "evaluate sexp")
  "rb" '(eval-buffer :which-key "evaluate buffer")
  "gs" '(magit-status :which-key "run magit-status")
  "cc" '(with-editor-finish :which-key "finish the editing session")
  "lp" '(projectile-find-file :which-key "find file by name")
  "ls" '(projectile-ripgrep :which-key "find file by content search")
  "le" '(flymake-show-buffer-diagnostics :which-key "list flymake errors in a new frame")
  "lr" '(may/rename-file :which-key "rename a file in the project")
  "ld" '(may/delete-file :which-key "delete a file in the project")
  "ps" '(projectile-switch-project :which-key "switch project")
  "pd" '(projectile-dired :which-key "open project dired")
  "oi" '(org-toggle-inline-images :which-key "toggle Org inline images")
  "oe" '(visible-mode :which-key "toggle Org hide emphasis")
  "ol" '(org-insert-link :which-key "insert a link in Org")
  "o|" '(org-cycle :which-key "cycle visibility/format"))

  ;; Note that gd is already defined by evil. For some reason.
  (general-def
    :states '(normal motion)
    :keymaps 'override
    :prefix "g"
    "r" 'xref-find-references
    "i" 'eglot-find-implementation
    "n" 'flymake-goto-next-error
    "p" 'flymake-goto-previous-error
    "e" 'eglot-rename
    "k" 'eldoc-print-current-symbol-info)

  (general-def
     :keymaps 'transient-base-map
     "<escape>" 'transient-quit-one))


;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(provide 'init)

;;; init.el ends here
