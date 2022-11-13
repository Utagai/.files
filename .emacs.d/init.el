;;; init.el --- Emacs configuration
;;; Code:

;; Start emacs as a server
(server-start)

;; Padding
(set-frame-parameter nil 'internal-border-width 20)

;; For new frames, padding + transparency, and disabling of scroll
;; bars.
;; TODO: I am curious to know if setting these is enough, and we no
;; longer need (scroll-bar-mode -1) or (set-fringe-mode 0).
(setq default-frame-alist '((alpha . (93 . 93))
                            (internal-border-width . 20)
                            (left-fringe . 0)
                            (right-fringe . 0)
                            (vertical-scroll-bars)))

(when (string= system-type "windows-nt") (add-to-list 'default-frame-alist '(alpha . (100 . 100))))

;; Disable that positively grotesque emacs startup.
(setq inhibit-startup-message t)

;; Removing some unneeded UI elements
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)
(menu-bar-mode -1)

;; Set emacs' exec path to match our shell PATH.
;; TODO: This can be written as a lambda.
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' variable `exec-path' via $PATH.

This would make variable `exec-path' match the PATH environment
variable used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)

  (unless (string= system-type "windows-nt")
  (let ((path-from-shell (replace-regexp-in-string
        "[ \t\n]*$" "" (replace-regexp-in-string
            "\s" ":" (shell-command-to-string
                "$SHELL --login -c 'echo $PATH'")))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator)))))

(set-exec-path-from-shell-PATH)

; disable backup
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
; disable auto save
(setq auto-save-default nil)

;; Set font
(set-face-attribute 'default nil :font "Cascadia Code PL" :height 100)

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
                term-mode-hook
                vterm-mode-hook))
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
   '("1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" default))
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
   '(hl-todo frames-only-mode vterm tree-sitter-langs tree-sitter prettier-js flycheck counsel-projectile projectile rustic go-mode company-box company typescript-mode lsp-mode org-autolist markdown-mode evil-surround org-bullets evil-magit magit evil-collection evil general all-the-icons doom-themes helpful counsel ivy-rich which-key rainbow-delimiters doom-modeline ivy command-log-mode use-package))
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

;; TODO: We should remove this I think.
(use-package command-log-mode)

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

;; TODO: Should we use :after ivy?
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package all-the-icons)
(use-package doom-modeline
  :ensure t
  :config
  (setq doom-modeline-height 35)

  ;; Set the global mode string to some spaces to add artificial
  ;; padding to the end of the bar.
  (setq mode-line-misc-info '("  "))

  (declare-function doom-modeline-def-modeline 'cover-flycheck-func-nodef-at-runtime)
  ;; Customize what's in our bar.
  (doom-modeline-def-modeline 'custom-line
    '(bar modals matches buffer-info selection-info)
    '(vcs checker misc-info))
  
  (defun setup-custom-doom-modeline ()
    (declare-function doom-modeline-set-modeline 'cover-flycheck-func-nodef-at-runtime)
    (doom-modeline-set-modeline 'custom-line 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)
  
  (doom-modeline-mode 1))

;; Set theme.
(use-package doom-themes
  :init (load-theme 'doom-nord))

;; TODO: I don't think we'll actually want this.
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

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
  (declare-function evil-set-undo-system 'cover-flycheck-func-nodef-at-runtime)
  (evil-set-undo-system 'undo-redo)

  ;; Use visual line motions even outside of visual-line-mode buffers
  ;; TODO: This is basically a thing that lets you treat a wrapped
  ;; line as if it was actually split across multiple lines. Could be
  ;; useful for markdown editing for example. We'll keep it out for
  ;; now.
  (declare-function evil-global-set-key 'cover-flycheck-func-nodef-at-runtime)
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

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

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

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (declare-function lsp-enable-which-key-integration 'cover-flycheck-func-nodef-at-runtime)
  (lsp-enable-which-key-integration t)
  (setq lsp-headerline-breadcrumb-enable nil))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-select-next))
        (:map lsp-mode-map
         ("<backtab>" . company-select-previous))
  :custom
  (company-selection-wrap-around t)
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package tree-sitter)
(use-package tree-sitter-langs
  :after tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (defun run-flycheck (_)
    (declare-function flycheck-buffer 'cover-flycheck-func-nodef-at-runtime)
    (flycheck-buffer))
  (add-to-list 'window-buffer-change-functions 'run-flycheck))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package hl-todo
  :config
  (global-hl-todo-mode))

(use-package prettier-js
  :init
  (add-hook 'typescript-mode-hook 'prettier-js-mode))

(use-package go-mode
  :hook (go-mode . lsp-deferred)
  :custom
  (gofmt-command "goimports")
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package rustic
  :hook (rust-mode . lsp-deferred))

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

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(unless (string= system-type "windows-nt")
(use-package vterm
  :after dash
  :functions (-map -filter -sort -map-indexed -first -first-item -second-item -last-item)
  :config
  (declare-function may/vterm/names "init.el")
  (defun may/vterm/names ()
    (-map
     (lambda (buf) (buffer-name buf))
     (-filter
      (lambda (buf) (with-current-buffer buf (string= "vterm-mode" major-mode)))
      (buffer-list))))

  (declare-function may/vterm/name-to-num "init.el")
  (defun may/vterm/name-to-num (s) (string-to-number (nth 1 (split-string s))))

  (declare-function may/vterm/get-next-num "init.el")
  (defun may/vterm/get-next-num ()
    ;; Define this first since we'll be referencing it a bunch.
    (let ((sorted-vterm-names (-sort (lambda (a b) (string< a b)) (may/vterm/names))))
      (if sorted-vterm-names
          (or
            ;; Find a gap in the vterm buffers to fill, starting from smallest numbered gap to largest.
            (-first-item (-first (lambda (it) (/= (-first-item it) (may/vterm/name-to-num (-second-item it))))
                                 (-map-indexed (lambda (idx it) (list (1+ idx) it)) sorted-vterm-names)))
            ;; If we do not find any such gap, just return the next number.
            (1+ (may/vterm/name-to-num (-last-item sorted-vterm-names))))
          ;; In the initial case when there are no vterm buffers yet, just start from 1.
          1)))

  (defun may/vterm/switch ()
    (interactive)
    (ivy-read "Switch to term: " (may/vterm/names)
              :require-match t
              :action (lambda (bufname) (switch-to-buffer bufname))))

  (declare-function may/vterm/make "init.el")
  (defun may/vterm/make (&optional name)
    (let ((base (format "[vterm] %d" (may/vterm/get-next-num))))
      (if (not (null name))
          (vterm (format "%s %s" base name))
        (vterm base))))

  (defun may/vterm/ask-make ()
    (interactive)
    (may/vterm/make (read-string "Name for new vterm: ")))))

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
  (declare-function general-override-mode 'cover-flycheck-func-nodef-at-runtime)
  (general-override-mode)
  (general-auto-unbind-keys)

  (defun may/switch-to-other-buffer ()
    "Switches to the other buffer (defined by other-buffer)."
    (interactive)
    (switch-to-buffer (other-buffer)))

  ;; TODO: There may be an issue with how we're doing this here. We
  ;; may need to grab the current buffer name, switch to the
  ;; other-buffer, and then kill the buffer that was current.
  (defun may/kill-current-buffer ()
    (interactive)
    (kill-buffer (current-buffer)))

  ;; We should probably split this into further functions for each prefix.
  ;; I think we should get the SPC prefix working in visual mode... so we can have commands work on the visual selection.
  (general-def
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC"
  "f" '(find-file :which-key "find file")
  "bs" '(counsel-switch-buffer :which-key "switch buffers")
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
  "lgd" '(evil-goto-definition :which-key "go to definition on point")
  "lgr" '(lsp-find-references :which-key "find references of point")
  "lp" '(projectile-find-file :which-key "find file by name")
  "ls" '(projectile-ripgrep :which-key "find file by content search")
  "tc" '(may/vterm/ask-make :which-key "create a vterm instance")
  "tt" '(may/vterm/switch :which-key "switch to a vterm instance")
  "ps" '(projectile-switch-project :which-key "switch project")
  "oi" '(org-toggle-inline-images :which-key "toggle Org inline images")
  "oe" '(visible-mode :which-key "toggle Org hide emphasis")
  "ol" '(org-insert-link :which-key "insert a link in Org")
  "o|" '(org-cycle :which-key "cycle visibility/format"))

  ;; Note that gd is already defined by evil. For some reason.
  (general-def
    :states '(normal motion)
    :keymaps 'override
    :prefix "g"
    "r" 'lsp-find-references
    "n" 'flycheck-next-error
    "p" 'flycheck-previous-error
    "e" 'lsp-rename
    "k" 'lsp-describe-thing-at-point)

  (general-def
     :keymaps 'transient-base-map
     "<escape>" 'transient-quit-one))


;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(provide 'init)

;;; init.el ends here
