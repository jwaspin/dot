let b:ale_linters = ['eslint']

set tabstop=2
set softtabstop=2
set shiftwidth=2

" move to next entry
inoremap ;; <Esc>/<..><Enter>"_c4l

" fast templates
inoremap ;a async function <..>(<..>) {<Enter><..><Enter>}<esc>kkt>ca<
inoremap ;c console.log(`<..>`);<esc>0t>ca<
inoremap ;C .catch((err) => {<Enter><..><Enter>})<esc>kt>ca<
inoremap ;f function <..>(<..>) {<Enter><..><Enter>}<esc>kkt>ca<
inoremap ;F for (let i = 0; i < <..>; i++) {<Enter><..><Enter>}<esc>kkt>ca<
inoremap ;i import <..> from '<..>';<esc>0t>ca<
inoremap ;J JSON.stringify(<..>, null, 2);<esc>0t>ca<
inoremap ;r const <..> = require('<..>');<esc>0t>ca<
inoremap ;R import React from 'react';<Enter><Enter>
inoremap ;t .then((<..>) => {<Enter><..><Enter>});<esc>kkt>ca<
