;;; pm/org/config.el -*- lexical-binding: t; -*-

(after! org
  (defvar pm/timestamp-format
    (org-time-stamp-format 'long 'inactive))

  (defun pm/current-timestamp ()
    (format-time-string
     pm/timestamp-format
     (org-current-time)))

  (defun pm/org-set-created-property ()
    (org-set-property "CREATED" (pm/current-timestamp)))

  (defun pm/org-insert-created-timestamp-on-doom-insert-h ()
    (when (not (org-entry-get nil "CREATED"))
      (pm/org-set-created-property)))

  (defun pm/org-insert-created-timestamp-on-org-insert-h ()
    (save-excursion
      (org-back-to-heading)
      (pm/org-set-created-property)))

  (add-hook 'pm/org-insert-todo-heading-hook 'pm/org-insert-created-timestamp-on-org-insert-h)

  (defun pm/run-org-insert-todo-heading-hook (&rest _)
    (run-hooks 'pm/org-insert-todo-heading-hook))

  (setopt time-stamp-active t
          time-stamp-start "#\\+last_modified:[ \t]"
          time-stamp-end "$"
          time-stamp-format pm/timestamp-format

          org-directory "~/notes"

          org-log-done 'note
          org-log-into-drawer t
          org-enforce-todo-dependencies t
          org-enforce-todo-checkbox-dependencies t

          org-todo-keywords '((sequence
                               "TODO(t)" ;; A task that needs doing and is ready to do
                               "PROG(p!)" ;; A task that is in progress
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

  (add-hook! 'before-save-hook #'time-stamp)
  (add-hook 'org-after-todo-state-change-hook 'pm/org-insert-created-timestamp-on-doom-insert-h)


  (advice-add 'org-insert-todo-heading :after 'pm/run-org-insert-todo-heading-hook)
  (advice-add 'org-insert-todo-heading-respect-content :after 'pm/run-org-insert-todo-heading-hook)
  (advice-add 'org-insert-todo-subheading :after  'pm/run-org-insert-todo-heading-hook))
