(setq user-full-name "Patrick Morris"
      user-mail-address "patrick.morris.310@gmail.com")

(defvar pm/font-size (if (string= (system-name) "Oxygen")
                         14
                       24))

(setq doom-font (font-spec :family "Iosevka Comfy Fixed" :size pm/font-size)
      doom-big-font (font-spec :family "Iosevka Comfy Fixed" :size (floor (* pm/font-size 1.8)))
      doom-unicode-font (font-spec :family "Iosevka Comfy Fixed")
      doom-variable-pitch-font (font-spec :family "Iosevka Comfy Fixed"))

(setq doom-theme 'doom-nord-aurora)

(after! lsp-ui
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-doc-show-with-mouse t)
  (setq lsp-ui-doc-max-height 30)

  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-delay 0.5))
