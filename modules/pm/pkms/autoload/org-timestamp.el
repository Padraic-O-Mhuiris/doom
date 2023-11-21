;;; pm/pkms/autoload/org-timestamp.el -*- lexical-binding: t; -*-

;;;###autoload
(defun pm/current-timestamp ()
  (format-time-string
   pm/timestamp-format
   (org-current-time)))

;;;###autoload
(defun pm/org-set-created-property ()
  (org-set-property "CREATED" (pm/current-timestamp)))

;;;###autoload
(defun pm/org-insert-created-timestamp-on-doom-insert-h ()
  (when (not (org-entry-get nil "CREATED"))
    (pm/org-set-created-property)))

;;;###autoload
(defun pm/org-insert-created-timestamp-on-org-insert-h ()
  (save-excursion
    (org-back-to-heading)
    (pm/org-set-created-property)))

;;;###autoload
(cl-defun pm/current-time ()
  (let* ((now (ts-now))
         (hour (ts-H now))
         (minute (ts-M now))
         (hour-formatted (if (< hour 10)
                             (format "0%s" hour)
                           (format "%s" hour)))
         (minute-formatted (if (< minute 10)
                               (format "0%s" minute)
                             (format "%s" minute))))
    (concat hour-formatted ":" minute-formatted)))

;;;###autoload
(cl-defun pm/todays-date ()
  (let* ((now (ts-now))
         (day (ts-day now))
         (suffix (cond ((memq day '(11 12 13)) "th")
                       ((= 1 (% day 10)) "st")
                       ((= 2 (% day 10)) "nd")
                       ((= 3 (% day 10)) "rd")
                       (t "th"))))
    (concat (ts-day-name now)
            ", "
            (format "%s" (ts-day-of-month-num now))
            suffix
            " of "
            (format "%s" (ts-month-name now))
            " "
            (format "%s" (ts-year now)))))
