;;; pm/pkms/autoload/org.el -*- lexical-binding: t; -*-

;;;###autoload
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-todo-log-states)) ; turn off logging
  (org-todo (if (= n-not-done 0) "DONE" "TODO")))

;;;###autoload
(cl-defun pm/note-insert-keyword-and-value (&key node key value)
  (with-temp-buffer
    (insert-file-contents (org-roam-node-file node))
    (org-mode)
    (org-roam-set-keyword key value)
    (write-file (org-roam-node-file project-node))))

;;;###autoload
(defun pm/get-org-keywords-from-file (file keywords)
  "Collect values of KEYWORDS from an Org-mode FILE.
If KEYWORDS is nil, collect all buffer-wide settings."
  (with-temp-buffer
    (insert-file-contents file)
    (org-mode)
    (org-collect-keywords keywords)))
