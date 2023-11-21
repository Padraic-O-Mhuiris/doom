;;; pm/pkms/autoload/pkms.el -*- lexical-binding: t; -*-

;;;###autoload
(cl-defun pm/note-capture-new (&key node)
  (interactive)
  (if node
      (org-roam-capture-
       :goto nil
       :info nil
       :keys nil
       :templates `(("a" "Basic note" plain
                     ,pm/note-basic-entry
                     :target (file+head ,pm/default-note-name-template ,(pm/template-head-builder)))
                    ("b" "Basic note + alias prompt" plain
                     ,pm/note-basic-entry
                     :target (file+head
                              ,pm/default-note-name-template
                              ,(pm/template-head-builder :aliases `("%^{ALIAS}"))))
                    ("c" "Basic note + tag prompt" plain
                     ,pm/note-basic-entry
                     :target (file+head
                              ,pm/default-note-name-template
                              ,(pm/template-head-builder :prompt-for-tags t)))
                    ("d" "Basic note + tag prompt + alias prompt" plain
                     ,pm/note-basic-entry
                     :target (file+head
                              ,pm/default-note-name-template
                              ,(pm/template-head-builder :prompt-for-tags t :aliases `("%^{ALIAS}")))))
       :node node
       :props '(:unnarrowed t :empty-lines-before 1))
    (user-error "Node cannot be nil!")))

;;;###autoload
(cl-defun pm/note-capture-existing (&key node)
  (interactive)
  (if node
      (org-roam-capture-
       :goto nil
       :info nil
       :keys nil
       :templates `(("a" "Edit note" plain
                     ,pm/note-basic-entry
                     :target (file+head ,pm/default-note-name-template ,(pm/template-head-builder)))
                    ("b" "Edit note + goto" plain
                     ,pm/note-basic-entry
                     :target (file+head ,pm/default-note-name-template ,(pm/template-head-builder))
                     :jump-to-captured t)
                    ("c" "Insert TODO" entry
                     ,pm/note-todo-entry
                     :target (file+head ,pm/default-note-name-template ,(pm/template-head-builder))
                     :prepend t
                     :empty-lines 1)
                    ("d" "Insert TODO + goto" entry
                     ,pm/note-todo-entry
                     :target (file+head ,pm/default-note-name-template ,(pm/template-head-builder))
                     :prepend t
                     :empty-lines 1
                     :jump-to-captured t)
                    ("e" "Insert IDEA" entry
                     ,pm/note-idea-entry
                     :target (file+head ,pm/default-note-name-template ,(pm/template-head-builder))
                     :prepend t
                     :empty-lines 1)
                    ("f" "Insert IDEA + goto" entry
                     ,pm/note-idea-entry
                     :target (file+head ,pm/default-note-name-template ,(pm/template-head-builder))
                     :prepend t
                     :empty-lines 1
                     :jump-to-captured t))
       :node node
       :props '(:unnarrowed t)) ;;
    (user-error "Node cannot be nil!")))

;;;###autoload
(cl-defun pm/note-capture ()
  (interactive)
  (let ((node (pm/note-read)))
    (if (org-roam-node-file node)
        (pm/note-capture-existing :node node)
      (pm/note-capture-new :node node))))

;;;###autoload
(cl-defun pm/note-read (&key (initial-input nil)
                             (filter-fn nil)
                             (sort-fn nil)
                             (require-match nil)
                             (prompt pm/note-find-prompt))
  (org-roam-node-read initial-input filter-fn sort-fn require-match prompt))

;;;###autoload
(cl-defun pm/note-find ()
  (interactive)
  (org-roam-node-visit (pm/note-read :require-match t) nil))
