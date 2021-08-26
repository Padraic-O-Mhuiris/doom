;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Patrick Morris"
      user-mail-address "patrick.morris.310@gmail.com")

(setq display-line-numbers-type t)

(setq doom-font (font-spec :family "Iosevka" :size 14 :slant 'normal :weight 'normal))
(setq doom-big-font (font-spec :family "Iosevka" :size 24))

(setq doom-theme 'doom-nord-light)

(setq auto-save-default t)

(setq haskell-stylish-on-save t)

(setq tab-width 2)
(setq standard-indent 2)

;;(setq org-todo-keywords
;;      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

;; Javascript settings
(setq-hook! js2-mode-hook js-indent-level 2)
(setq-hook! typescript-mode-hook typescript-indent-level 2)
(setq-hook! typescript-tsx-mode-hook web-mode-code-indent-offset 2)
;; Org
(setq org-directory "~/.org")
(setq org-roam-directory "~/.org")
(setq org-roam-db-location "~/.org/org-roam.db")
(setq org-roam-v2-ack t)
(setq org-agenda-files '("~/.org"))

(setq org-archive-location "~/.org/archive/%s_archive::* Archived Tasks")

(setq org-download-image-dir "~/.org/images")

(setq ledger-post-amount-alignment-column 100)
(setq ledger-post-account-alignment-column 2)

(setq all-the-icons-scale-factor 1.1)

;; (use-package! pinentry
;;         :init (setq epa-pinentry-mode `loopback)
;;                (pinentry-start))
;;
;;
