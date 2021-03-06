;; config for cedet

(require 'cedet)

;; semantic settings
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
				   global-semanticdb-minor-mode
				   global-semantic-idle-summary-mode
				   ;;global-semantic-idle-completions-mode
				   ;;global-semantic-highlight-func-mode
				   ;;global-semantic-decoration-mode
				   ;;global-semantic-stickyfunc-mode
				   ;;semantic-highlight-edits-mode
				   global-semantic-idle-local-symbol-highlight-mode
				   global-semantic-show-unmatched-syntax-mode
				   global-semantic-show-parser-state-mode
				   global-semantic-mru-bookmark-mode))

(semantic-mode t)

;; auto c++ mode
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.c$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.hpp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp$" . c++-mode))

;; semantic completion
(require 'semantic/ia)
;; semantic system header files in gcc
(require 'semantic/bovine/gcc)
(defun my-semantic-include-func ()
	(semantic-add-system-include "./inc" 'c-mode)
	(semantic-add-system-include "./inc" 'c++-mode)
	(semantic-add-system-include "./inc" 'pike-mode)
	(semantic-add-system-include "./inc" 'lpc-mode)	
	(semantic-add-system-include "./include" 'c-mode)
	(semantic-add-system-include "./include" 'c++-mode)
	(semantic-add-system-include "./include" 'pike-mode)
	(semantic-add-system-include "./include" 'lpc-mode)	
	(semantic-add-system-include "./../include" 'c-mode)
	(semantic-add-system-include "./../include" 'c++-mode)
	(semantic-add-system-include "./../include" 'pike-mode)
	(semantic-add-system-include "./../include" 'lpc-mode)	
	(semantic-add-system-include "./../../include" 'c-mode)
	(semantic-add-system-include "./../../include" 'c++-mode)
	(semantic-add-system-include "./../../include" 'pike-mode)
	(semantic-add-system-include "./../../include" 'lpc-mode)	
	(semantic-add-system-include "./../inc" 'c++-mode)
	(semantic-add-system-include "./../inc" 'c-mode)
	(semantic-add-system-include "./../inc" 'pike-mode)
	(semantic-add-system-include "./../inc" 'lpc-mode)	
	(semantic-add-system-include "./" 'c-mode)
	(semantic-add-system-include "./" 'c++-mode)
	(semantic-add-system-include "./" 'pike-mode)
	(semantic-add-system-include "./" 'lpc-mode))
(add-hook 'semantic-init-hooks 'my-semantic-include-func)

;; semantic completion hot-keys
(local-set-key "\C-RET" 'semantic-ia-complete-symbol)
;;(local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu) cannot found this function
(local-set-key "\C-c>" 'semantic-complete-analyze-inline)
(local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)

;; mrub tag jump key
(global-set-key (kbd "C-o") 'semantic-mrub-switch-tags)
(global-set-key (kbd "M-]") 'semantic-ia-fast-jump)
(global-set-key (kbd "M-[ l") 'semantic-complete-jump-local)
(global-set-key (kbd "M-[ g") 'semantic-complete-jump)
;;(global-set-key (kbd "C-x o") 'open-line)

;; add sematic autocomplete to auto-complete menu
(add-to-list 'ac-sources 'ac-source-semantic)

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
;; (setq ecb-auto-activate t)
(custom-set-variables  
	'(ecb-windows-width 0.20)) 

;(global-set-key [M-left] 'windmove-left)
;(global-set-key [M-right] 'windmove-right)
;(global-set-key [M-up] 'windmove-up)
;(global-set-key [M-down] 'windmove-down)

(global-set-key (kbd "C-c o b")  'windmove-left)
(global-set-key (kbd "C-c o f") 'windmove-right)
(global-set-key (kbd "C-c o p")    'windmove-up)
(global-set-key (kbd "C-c o n")  'windmove-down)


(defun check-and-add-header-path (checkpath)
  "Check if CHECKPATH exists and it's a directory, if it is a directory, then and it to 'ac-clang-cflags and 'flycheck-clang-include-path."
  (if (file-directory-p checkpath)
    (progn
      (add-to-list 'flycheck-gcc-include-path checkpath)
      (add-to-list 'flycheck-clang-include-path checkpath))))

(defun my-c-setup ()
  "Setup local variables when loading a C/C++ file."
  (check-and-add-header-path "include")
  (check-and-add-header-path "../include")
  (check-and-add-header-path "inc")
  (check-and-add-header-path "/usr/include/python2.7")
  (check-and-add-header-path "../inc"))

(add-hook 'c-mode-common-hook 'my-c-setup)

(provide 'init-cedet)
