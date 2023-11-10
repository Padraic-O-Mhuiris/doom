(setq user-full-name "Patrick Morris"
      user-mail-address "patrick.morris.310@gmail.com")

(defvar pm/font-size (if (string= (system-name) "Oxygen")
                         16
                       24))

(setq doom-font (font-spec :family "Iosevka Comfy Fixed" :size pm/font-size)
      doom-big-font (font-spec :family "Iosevka Comfy Fixed" :size (floor (* pm/font-size 1.8)))
      doom-unicode-font (font-spec :family "Iosevka Comfy Fixed")
      doom-variable-pitch-font (font-spec :family "Iosevka Comfy Fixed"))

(setq doom-theme 'doom-nord-aurora)
