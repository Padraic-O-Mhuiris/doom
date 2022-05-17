;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Patrick Morris"
      user-mail-address "patrick.morris.310@gmail.com")

(setq display-line-numbers-type t)

(defun pm/font-size ()
  ""
  (cond ((string= (system-name) "Hydrogen") 24)
        (t 16)))

(defun pm/big-font-size ()
  ""
  (cond ((string= (system-name) "Hydrogen") 32)
        (t 24)))


(setq doom-font (font-spec :family "Iosevka" :size (pm/font-size) :slant 'normal :weight 'normal))
(setq doom-big-font (font-spec :family "Iosevka" :size (pm/big-font-size)))

(setq doom-theme 'doom-city-lights)

(setq auto-save-default t)

(setq tab-width 2)
(setq standard-indent 2)

;; Javascript settings
(setq-hook! js2-mode-hook js-indent-level 2)
(setq-hook! typescript-mode-hook typescript-indent-level 2)
(setq-hook! typescript-tsx-mode-hook web-mode-code-indent-offset 2)

;;Haskell
(after! haskell
  (setq lsp-haskell-formatting-provider "ormolu")
  (setq haskell-interactive-popup-errors nil))


;; Org
(setq org-directory "~/.org")
(setq org-roam-directory "~/.org")
(setq org-roam-db-location "~/.org/org-roam.db")
(setq org-roam-v2-ack t)
(setq org-agenda-files '("~/.org"))

(setq time-stamp-active t
      time-stamp-start "#\\+LAST_MODIFIED:[ \t]*"
      time-stamp-end "$"
      time-stamp-format "\[%Y-%m-%d %a %H:%M:%S\]")

(add-hook 'before-save-hook 'time-stamp nil)

(setq org-noter-default-notes-file-names '("notes.org")
      org-noter-notes-search-path '("~/.org/literature")
      org-noter-separate-notes-from-heading t)

(after! org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 0.9))
  (setq org-capture-templates
        '(
          ;; inbox
          ("i" "inbox" entry
           (file "~/.org/inbox.org")
           "* TODO %?\nSCHEDULED: %t")
          )))


(setq org-roam-capture-templates
      '(
        ;; default
        ("d" "default" plain
         (file "~/.org/templates/default.org")
         :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+TITLE: ${title}\n")
         :unnarrowed t)

        ;; book
        ("b" "book" plain
         (file "~/.org/templates/book.org")
         :if-new
         (file+head "literature/book/${citekey}.org"
                    "#+TITLE: ${title}\n")
         :unnarrowed t)
        ;; project
        ("p" "project" plain
         (file "~/.org/templates/project.org")
         :if-new
         (file+head "projects/${slug}.org"
                    "#+TITLE: ${title}\n")
         :unnarrowed t)
        ;; people
        ("j" "people" plain
         (file "~/.org/templates/people.org")
         :if-new
         (file+head "people/${slug}.org"
                    "#+TITLE: ${title}\n")
         :unnarrowed t)
        ))

(setq org-roam-dailies-capture-templates
      '(("d" "daily" plain
         "%?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+TITLE: %<%Y-%m-%d>\n#+CREATED: %U\n#+LAST_MODIFIED: %U\n#+FILETAGS: :daily:\n"))))

(setq org-archive-location "~/.org/archive/%s_archive::* Archived Tasks")

(setq org-download-screenshot-method  "flameshot gui --raw > %s")
(setq org-noter-always-create-frame nil)

(setq ledger-post-amount-alignment-column 100)
(setq ledger-post-account-alignment-column 2)

(setq all-the-icons-scale-factor 1.1)
(setq solidity-flycheck-solc-checker-active t)

(setq beancount-number-alignment-column 100)
(setq beancount-account-chars 60)

(add-hook 'beancount-mode-hook #'outline-minor-mode)
