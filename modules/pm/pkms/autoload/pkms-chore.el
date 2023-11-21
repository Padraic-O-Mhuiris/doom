;;; pm/pkms/autoload/pkms-chore.el -*- lexical-binding: t; -*-

;;;###autoload
(cl-defun pm/chore-capture ()
  (interactive)
  (let (
        (headings '("House" "Car" "Emails"))
        (node (org-roam-populate (org-roam-node-create :title "Chores"))))
    (org-roam-capture-
     :goto nil
     :info nil
     :keys nil
     :templates `(("a" "House" entry
                   ,pm/note-todo-entry
                   :target (file+head+olp
                            "chore.org"
                            ,(pm/template-head-builder
                              :tags '("chore")
                              :headings headings)
                            ,'("House")))
                  ("b" "Car" entry
                   ,pm/note-todo-entry
                   :target (file+head+olp
                            "chore.org"
                            ,(pm/template-head-builder
                              :tags '("chore")
                              :headings headings)
                            ,'("Car")))
                  ("c" "Emails" entry
                   ,pm/note-todo-entry
                   :target (file+head+olp
                            "chore.org"
                            ,(pm/template-head-builder
                              :tags '("chore")
                              :headings headings)
                            ,'("Emails")))
                  ("d" "Clothes" entry
                   ,pm/note-todo-entry
                   :target (file+head+olp
                            "chore.org"
                            ,(pm/template-head-builder
                              :tags '("chore")
                              :headings headings)
                            ,'("Clothes"))))
     :node node
     :props '(:unnarrowed t))))

(pm/leader
 "nb" '(pm/chore-capture :which-key "capture chore"))
