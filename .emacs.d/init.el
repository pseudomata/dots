;; Turn off some stuff for a cleaner looking minimal Emacs
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Do not want to create lockfiles
(setq create-lockfiles nil)

;; Display line numbers in every buffer
;; (global-display-line-numbers-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)  ; only in programming text buffers
(global-hl-line-mode 1)

;; The font to use
(set-frame-font "JetBrains Mono 14" nil t)

;; Tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; When scrolling pages up and down, go to start or end instead of error
(setq scroll-error-top-bottom t)

;; Using macOS so these are helpful
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; Using straight.el for package management, this bootstraps and installs it
;; see https://github.com/radian-software/straight.el
(setq package-enable-at-startup nil)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)

;; Load the Modus Operandi theme
;; See https://github.com/protesilaos/modus-themes
(straight-use-package 'modus-themes)  ; no longer needed in Emacs >= 28
(straight-use-package 'stimmung-themes)
(load-theme 'stimmung-themes-light t)

;; TODO: come back and configure packages like vertico, marginalia, corfu, consult, prescient
(use-package vertico
  :straight t
  :init
  (vertico-mode)
  (setq vertico-count 15)
  (setq vertico-resize t))

(use-package savehist
  :straight t
  :init
  (savehist-mode))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :straight t
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))
