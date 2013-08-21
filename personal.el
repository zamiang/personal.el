;; Zamiang customizations begin here
;; for use with http://batsov.com/prelude/

(set-default-font "Consolas-13")

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(require 'auto-complete-config)
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.hamljs$" . haml-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(ac-config-default)
(auto-complete-mode 1)
(global-auto-complete-mode t)
(auto-complete-mode t)

(whitespace-mode -1)
(global-whitespace-mode -1)

;; for prelude
(setq prelude-guru nil)

;; make utf-8 for osx
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; autocleanup bad whitespace
(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace

;; set goto line hotkey
(global-set-key "\M-g" 'goto-line)

(global-set-key "\C-\\" 'indent-region)
(global-set-key "\C-c\C-c" 'comment-or-uncomment-region)

(electric-pair-mode -1)

(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

(setq x-select-enable-clipboard t)

;; (global-set-key "\C-c\C-f" 'follow-mode)

;; adds autocomplete
(add-to-list 'ac-modes 'css-mode)
(add-to-list 'ac-modes 'yaml-mode)
(add-to-list 'ac-modes 'rhtml-mode)
(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'haml-mode)
(add-to-list 'ac-modes 'js2-mode)
(add-to-list 'ac-modes 'ruby-mode)
(add-to-list 'ac-modes 'sass-mode)
(add-to-list 'ac-modes 'python-mode)


(defun kill-and-join-forward (&optional arg)
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
             (just-one-space 0)
             (backward-char 1)
             (kill-line arg))
    (kill-line arg)))

(global-set-key "\C-k" 'kill-and-join-forward)

;; very useful
(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))

(setq-default kill-read-only-ok t)

(defvar ffip-patterns
  '("*.html" "*.org" "*.txt" "*.md" "*.el" "*.clj" "*.py" "*.rb" "*.js" "*.pl" "*.coffee" "*.sass"
    "*.sh" "*.erl" "*.hs" "*.ml"))

(global-set-key (kbd "C-x f") 'find-file-in-project)

;; setup ack
;; http://www.emacswiki.org/emacs/Ack
(defvar ack-history nil
  "History for the `ack' command.")

(defun ack (command-args)
  (interactive
   (let ((ack-command "ack --nogroup --with-filename --all "))
     (list (read-shell-command "Run ack (like this): "
                               ack-command
                               'ack-history))))
  (let ((compilation-disable-input t))
    (compilation-start (concat command-args " < " null-device)
                       'grep-mode)))

;;(grep-apply-setting grep-command "ack --with-filename --nogroup --all")

;; disable prelude's default theme
(disable-theme 'zenburn)

;; enable chosen theme
(load-theme 'zenburn)
;;(load-theme 'solarized-light t)

(blink-cursor-mode (- (*) (*) (*)))
(setq cursor-in-non-selected-windows nil)

(global-set-key (kbd "M-z") 'undo)

(setq visible-bell t)
(setq ffap-machine-p-known 'reject)
