(setq user-full-name "Patrick Morris"
      user-mail-address "patrick.morris.310@gmail.com")

(defvar pm/font-size (if (string= (system-name) "Oxygen")
                         14
                       24))

(setq doom-font (font-spec :family "Iosevka Comfy Fixed" :size pm/font-size)
      doom-big-font (font-spec :family "Iosevka Comfy Fixed" :size (floor (* pm/font-size 1.8)))
      doom-unicode-font (font-spec :family "Iosevka Comfy Fixed")
      doom-variable-pitch-font (font-spec :family "Iosevka Comfy Fixed"))

(setq doom-theme 'doom-feather-light)

(after! lsp-ui
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-doc-show-with-mouse t)
  (setq lsp-ui-doc-max-height 30))

;; (setq lsp-ui-sideline-enable t)
;; (setq lsp-ui-sideline-show-hover t)
;; (setq lsp-ui-sideline-show-diagnostics nil)
;; (setq lsp-ui-sideline-show-code-actions t)
;; (setq lsp-ui-sideline-delay 0.5))


;;; https://github.com/doomemacs/doomemacs/issues/7514
(defun apheleia-inhibit-me ()
  (setq apheleia-inhibit t))

(after! rustic
  (add-hook 'rustic-mode-hook 'apheleia-inhibit-me)
  (setq rustic-format-trigger 'on-save
        rustic-format-on-save-method #'lsp-format-buffer))

(after! solidity-mode
  (setq apheleia-formatters (delq (assoc 'prettier-solidity apheleia-formatters) apheleia-formatters)))
;; (set-formatter! 'solidityfmt '("forge" "fmt") :modes '(solidity-mode)))

(after! org
  (setopt time-stamp-active t
          time-stamp-start "#\\+last_modified:[ \t]"
          time-stamp-end "$"
          time-stamp-format (org-time-stamp-format 'long 'inactive)

          org-directory "~/notes"

          org-log-done 'note
          org-log-into-drawer t
          org-enforce-todo-dependencies t
          org-enforce-todo-checkbox-dependencies t

          org-directory "~/notes"

          org-todo-keywords '((sequence
                               "TODO(t)" ;; A task that needs doing and is ready to do
                               "PROG(p!)" ;; A task that is in progress
                               "READ(r!)" ;; A task to read something
                               "NEXT(n!)" ;; A task which should be done next
                               "WAIT(w@/!)" ;; A task which is held up for an external reason
                               "HOLD(h@/!)" ;; A task which is paused
                               "|"          ;;
                               "DONE(d!)"   ;; When a task is completed
                               "KILL(k@/!)" ;; When a task is rejected
                               "FAIL(f@/!)") ;; When a task is failed

                              (sequence
                               "NOTE" ;; Not necessary for agenda, just for highlighting in places
                               "LINK" ;; A naked url which is to be changed to a link note
                               "IDEA" ;; A piece of information which might manifest into something
                               "|")))
  (setopt org-agenda-files (directory-files-recursively "~/notes" org-agenda-file-regexp))

  (setopt
   org-roam-directory org-directory
   org-roam-dailies-directory "daily/"
   org-roam-database-connector 'sqlite-builtin)

  (org-roam-db-autosync-mode)

  (add-hook! 'org-after-todo-state-change-hook
    (lambda ()
      (when (not (org-entry-get nil "CREATED"))
        (org-set-property "CREATED" (format-time-string time-stamp-format (org-current-time))))))

  (add-hook! 'before-save-hook #'time-stamp)

  (+org-enable-auto-reformat-tables-h)
  (+org-enable-auto-update-cookies-h)

  (add-hook 'org-after-todo-statistics-hook #'org-summary-todo)
  ;; Weird bug
  (remove-hook! 'org-fold-reveal-start-hook #'org-decrypt-entry))
