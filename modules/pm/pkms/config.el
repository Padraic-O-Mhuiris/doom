(defvar pm/note-basic-entry (pm/template-entry-builder :entry-content "%?" :no-properties t))
(defvar pm/note-todo-entry (pm/template-entry-builder :todo-state "TODO" :levels 2 :title-content "%?"))
(defvar pm/note-journal-entry (pm/template-entry-builder :title-content "[%<%T>]\n %?" :levels 2 :no-properties t))
(defvar pm/note-idea-entry (pm/template-entry-builder :todo-state "IDEA" :levels 2 :title-content "%?"))
(defvar pm/note-link-entry (pm/template-entry-builder
                            :no-properties t
                            :entry-content "%(org-cliplink-capture)"))

(defvar pm/default-note-name-template "%<%s>__${slug}.org")
(defvar pm/daily-note-name-template "%<%Y-%m-%d>.org")
(defvar pm/people-note-name-template "people/<%s>__${slug}.org")
(defvar pm/basic-note-target `(file+head ,pm/default-note-name-template ,(pm/template-head-builder)))
(defvar pm/action-note-target
  `(file+head
    ,pm/default-note-name-template
    ,(pm/template-head-builder
      :headings '("Journal" "Tasks" "Ideas" "Links"))))

(defvar pm/note-find-prompt "<:📚:> ")

(use-package! ts)

(after! org
  (defvar pm/timestamp-format
    (org-time-stamp-format 'long 'inactive))

  (setopt time-stamp-active t
          time-stamp-start "#\\+last_modified:[ \t]"
          time-stamp-end "$"
          time-stamp-format pm/timestamp-format

          org-directory "~/notes"

          org-log-done 'note
          org-log-into-drawer t
          org-enforce-todo-dependencies t
          org-enforce-todo-checkbox-dependencies t

          org-directory "~/notes"

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
  (setopt
   org-roam-directory org-directory
   org-roam-dailies-directory "daily/"
   org-roam-database-connector 'sqlite-builtin)

  (org-roam-db-autosync-mode)

  (add-hook 'pm/org-insert-todo-heading-hook 'pm/org-insert-created-timestamp-on-org-insert-h)
  (add-hook 'org-after-todo-state-change-hook 'pm/org-insert-created-timestamp-on-doom-insert-h)

  (add-hook! 'before-save-hook #'time-stamp)

  (advice-add 'org-insert-todo-heading :after 'pm/run-org-insert-todo-heading-hook)
  (advice-add 'org-insert-todo-heading-respect-content :after 'pm/run-org-insert-todo-heading-hook)
  (advice-add 'org-insert-todo-subheading :after  'pm/run-org-insert-todo-heading-hook)

  (+org-enable-auto-reformat-tables-h)
  (+org-enable-auto-update-cookies-h)

  (add-hook 'org-after-todo-statistics-hook #'org-summary-todo)
  ;; Weird bug
  (remove-hook! 'org-fold-reveal-start-hook #'org-decrypt-entry))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(map! :leader
      (:prefix-map ("n" . "notes")
       "*" nil
       :desc "Find note" "f" #'pm/note-find
       :desc "Capture note" "c" #'pm/note-capture
       :desc "Capture chore" "b" #'pm/chore-capture
       :desc "Capture link" "l" #'pm/link-capture
       (:prefix-map ("p" . "project notes")
        :desc "Find project" "f" #'pm/project-note-find
        :desc "Go to project note" "g" #'pm/project-note-goto
        :desc "Capture project TODO" "t" #'pm/project-note-todo
        :desc "Capture project IDEA" "i" #'pm/project-note-idea
        :desc "Capture project link" "l" #'pm/project-note-link
        :desc "Capture project journal" "j" #'pm/project-note-journal)))

