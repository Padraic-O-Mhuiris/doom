;;; pm/notes/config.el -*- lexical-binding: t; -*-

(after! org
  (setopt org-directory "~/notes"
          org-roam-directory org-directory
          org-roam-dailies-directory "daily/"
          org-roam-database-connector 'sqlite-builtin)

  (org-roam-db-autosync-mode))
