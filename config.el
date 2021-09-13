;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Patrick Morris"
      user-mail-address "patrick.morris.310@gmail.com")

(use-package! org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref))

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

(setq time-stamp-active t
      time-stamp-start "#\\+LAST_MODIFIED:[ \t]*"
      time-stamp-end "$"
      time-stamp-format "\[%Y-%m-%d %a %H:%M:%S\]")

(add-hook 'before-save-hook 'time-stamp nil)

(setq org-noter-default-notes-file-names '("notes.org")
      org-noter-notes-search-path '("~/.org/literature")
      org-noter-separate-notes-from-heading t)

(setq reftex-default-bibliography '("~/.org/literature/library.bib"))

(setq org-ref-bibliography-notes  '("~/.org/literature/notes.org")
      org-ref-default-bibliography '("~/.org/literature/library.bib")
      org-ref-pdf-directory '("~/.org/literature/pdfs/"))

(setq bibtex-completion-bibliography "~/.org/literature/library.bib"
      bibtex-completion-library-path "~/.org/literature/pdfs"
      bibtex-completion-notes-path "~/.org/literature")

(setq orb-preformat-keywords
      '(("citekey" . "=key=") "title" "cover" "url" "tags" "date" "abstract" "year" "journal" "note" "volume" "pages" "doi" "isbn" "issn" "publisher" "file" "author-or-editor" "keywords")
      orb-process-file-field t
      orb-process-file-keyword t
      orb-file-field-extensions '("pdf"))


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

(setq org-download-image-dir "~/.org/images")

(setq ledger-post-amount-alignment-column 100)
(setq ledger-post-account-alignment-column 2)

(setq all-the-icons-scale-factor 1.1)

;; (use-package! pinentry
;;         :init (setq epa-pinentry-mode `loopback)
;;                (pinentry-start))
;;
;;
(setq solidity-flycheck-solc-checker-active t)
