;; config for cedet

(require 'cedet)

;; semantic settings
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
				   global-semanticdb-minor-mode
				   global-semantic-idle-summary-mode
				   global-semantic-idle-completions-mode
				   ;;global-semantic-highlight-func-mode
				   ;;global-semantic-decoration-mode
				   ;;global-semantic-stickyfunc-mode
				   ;;semantic-highlight-edits-mode
				   global-semantic-idle-local-symbol-highlight-mode
				   global-semantic-show-unmatched-syntax-mode
				   global-semantic-show-parser-state-mode
				   global-semantic-mru-bookmark-mode))

(semantic-mode t)

;; semantic completion
(require 'semantic/ia)
;; semantic system header files in gcc
(require 'semantic/bovine/gcc)
(defun my-semantic-include-func ()
	(when '(file-exists-p "inc") (semantic-add-system-include "inc" 'c-mode))
	(when '(file-exists-p "inc") (semantic-add-system-include "inc" 'c++mode))
	(when '(file-exists-p "include") (semantic-add-system-include "include" 'c-mode))
	(when '(file-exists-p "include") (semantic-add-system-include "include" 'c++mode))
	(when '(file-exists-p "../include") (semantic-add-system-include "../include" 'c-mode))
	(when '(file-exists-p "../include") (semantic-add-system-include "../include" 'c++mode))
	(when '(file-exists-p "../../include") (semantic-add-system-include "../../include" 'c-mode))
	(when '(file-exists-p "../../include") (semantic-add-system-include "../../include" 'c++mode))
	(when '(file-exists-p "../inc") (semantic-add-system-include "../inc" 'c++mode))
	(when '(file-exists-p "../inc") (semantic-add-system-include "../inc" 'c-mode)))
(add-hook 'semantic-init-hooks 'my-semantic-include-func)

;; semantic completion hot-keys
(defun my-cedet-hook ()
	(local-set-key [(control return)] 'semantic-ia-complete-symbol)
	(local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
	(local-set-key "\C-c>" 'semantic-complete-analyze-inline)
	(local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'c++-mode-common-hook 'my-cedet-hook)

;; ede settings
(global-ede-mode t)
;; copyed the test project
;; (ede-cpp-root-project "Test"
;; :name "Test Project"
;; :file "~/work/project/CMakeLists.txt"
;; :include-path '("/"
;; "/Common"
;; "/Interfaces"
;; "/Libs"
;; )
;; :system-include-path '("~/exp/include")
;; :spp-table '(("isUnix" . "")
;; ("BOOST_TEST_DYN_LINK" . "")))

;; ecb settings
(require-package 'ecb)
(require 'ecb)

(provide 'init-cedet)
