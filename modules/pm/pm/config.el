(dolist (flag (doom-module-context-get 'flags))
  (load! (concat "contrib/" (substring (symbol-name flag) 1)) nil t))
