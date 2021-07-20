set tabstop=2
set softtabstop=2
set shiftwidth=2

" move to next entry
inoremap ;; <Esc>/<..><Enter>"_c4l

" fast templates
inoremap ;a type: array<Enter>items:<Enter>$ref: '
inoremap ;g get:<Enter>tags:<Enter>- "<..>"<Enter>summary: <..><Enter>description: <..><esc>0kkt>ca<
inoremap ;o type: object<Enter>properties:<Enter>
inoremap ;p parameters:<Enter>- in: path<Enter>name: <..><Enter>schema:<Enter>type: <..> <Enter>required: <..><Enter>description: <..><esc>0kkkkt>ca<
inoremap ;r responses:<Enter>'200':<Enter>description: <..><Enter>content:<Enter>application/json:<Enter>schema:<Enter>type: <..><esc>0kkkkt>ca<
