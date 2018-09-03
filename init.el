(package-initialize)
(require 'lsp-haskell)
(add-hook 'haskell-mode-hook #'lsp-haskell-enable)
