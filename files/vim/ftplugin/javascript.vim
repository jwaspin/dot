let b:ale_linters = ['eslint']

set tabstop=2
set softtabstop=2
set shiftwidth=2

" move to next entry
inoremap ;; <Esc>/<..><Enter>"_c4l

" fast templates
inoremap ;a (<..>) => {<Enter><..><Enter>}<esc>0kkt>ca<
inoremap ;A async function <..>(<..>) {<Enter><..><Enter>}<esc>0kkt>ca<
inoremap ;c console.log(`<..>`);<esc>0t>ca<
inoremap ;C .catch((err) => {<Enter><..><Enter>})<esc>0kt>ca<
inoremap ;e export default 
inoremap ;f function <..>(<..>) {<Enter><..><Enter>}<esc>0kkt>ca<
inoremap ;F for (let i = 0; i < <..>; i++) {<Enter><..><Enter>}<esc>0kkt>ca<
inoremap ;i import <..> from '<..>';<esc>0t>ca<
inoremap ;J JSON.stringify(<..>, null, 2)<esc>0t>ca<
inoremap ;r const <..> = require('<..>');<esc>0t>ca<
inoremap ;R import React from 'react';<Enter><Enter>
inoremap ;t .then((<..>) => {<Enter><..><Enter>});<esc>kkt>ca<
inoremap ;` return ``;<esc>hi<Enter><esc>
