set tabstop=2
set softtabstop=2
set shiftwidth=2

" move to next entry
inoremap ;; <Esc>/<..><Enter>"_c4l

" fast templates
inoremap ;g get:<Enter>tags:<Enter>- "<..>"<Enter>summary: <..><Enter>description: <..><esc>0kkt>ca<
inoremap ;r responses:<Enter>'200':<Enter>description: <..><Enter>content:<Enter>application/json:<Enter>schema:<Enter>type: <..><esc>0kkkkt>ca<
