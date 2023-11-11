;;; pm/notes/config.el -*- lexical-binding: t; -*-

(after! (org org-roam)
  (setopt org-roam-directory org-directory
          org-roam-dailies-directory "daily/"
          org-roam-database-connector 'sqlite-builtin))
