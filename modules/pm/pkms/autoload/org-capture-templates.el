;;; pm/pkms/autoload/org-capture-templates.el -*- lexical-binding: t; -*-

;;;###autoload
(defun pm/intersperse (lst value)
  "Intersperse LST with VALUE."
  (if (null lst)
      '()
    (let ((rest-of-list (cdr lst)))
      (if (null rest-of-list)
          lst
        (cons (car lst) (cons value (pm/intersperse rest-of-list value)))))))

;;;###autoload
(defun pm/list-to-org (lst &optional level)
  (unless level (setq level 1))
  (mapconcat (lambda (item)
               (if (listp item)
                   (pm/list-to-org item (1+ level))
                 (concat (make-string level ?*) " " item "\n\n")))
             lst
             ""))

;;;###autoload
(cl-defun pm/list2str (lst &key (between "") (before "") (after ""))
  (apply #'concat `(,before ,(apply #'concat (pm/intersperse (cl-remove-if-not 'stringp lst) between)) ,after)))


;;;###autoload
(cl-defun pm/template-head-builder
    (&optional &key (title "${title}")
               (tags `())
               (aliases `())
               (refs `())
               (headings `())
               (prompt-for-tags nil)
               (project-path nil)
               (created "#+created_at: %U")
               (modified  "#+last_modified: %U"))
  "This function is the default builder for all note templates. It expects a series of keys and values in each case:"
  (let
      ((file-tags
        (if (or
             (> (length tags) 0)
             prompt-for-tags)
            (pm/list2str tags
                         :before (concat "#+filetags: "
                                         (if (> (length tags) 0) ":" ""))
                         :after (concat (if (> (length tags) 0) ":" "")
                                        (if prompt-for-tags "%^G" ""))
                         :between ":")
          nil))
       (properties (if (or
                        (> (length refs) 0)
                        (> (length aliases) 0))
                       (pm/list2str
                        `(,(when (> (length aliases) 0)
                             (pm/list2str aliases :between " " :before ":ROAM_ALIASES: " :after "\n"))
                          ,(when (> (length refs) 0)
                             (pm/list2str refs :between " " :before ":ROAM_REFS: " :after "\n")))
                        :before ":PROPERTIES:\n"
                        :after ":END:"
                        :between "\n")
                     nil))
       (olp (if (> (length headings) 0)
                (concat "\n" (pm/list-to-org headings))
              nil)))
    (pm/list2str `(,properties
                   ,(concat "#+title: " title)
                   ,created
                   ,modified
                   ,(when project-path (concat "#+project_path: " project-path))
                   ,file-tags
                   ,olp)

                 :between "\n")))

;;;###autoload
(cl-defun pm/template-entry-builder
    (&key (todo-state nil)
          (title-content nil)
          (entry-content nil)
          (levels 0)
          (tags `())
          (no-properties nil))
  (let
      ((tag-str (if (> (length tags) 0)
                    (pm/list2str tags :between ":" :before " :" :after ":")
                  nil))
       (levels-str (if (> levels 0)
                       (make-string levels ?*)
                     nil)))
    (pm/list2str `(,(when (> levels 0) (pm/list2str `(,levels-str
                                                      ,todo-state
                                                      ,title-content
                                                      ,tag-str)
                                                    :between " "))
                   ,(unless no-properties ":PROPERTIES:\n:CREATED:  %U\n:END:")
                   ,(when entry-content entry-content))
                 :between "\n")))

