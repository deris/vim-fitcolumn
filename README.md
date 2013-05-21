vim-fitcolumn
===

This is vim plugin for input repeatedly from current column
to above or below column specified 'character'.

Usage
---

```vim
" This is default key mapping
imap <C-k>  <Plug>(fitcolumn-abovecolumn)
imap <C-j>  <Plug>(fitcolumn-belowcolumn)
```

```vim
" If you want to change default key mapping, like this.
let g:fitcolumn_no_default_key_mappings = 1
imap <C-h>  <Plug>(fitcolumn-abovecolumn)
imap <C-l>  <Plug>(fitcolumn-belowcolumn)
```

```vim
" If you want to insert <Space> repeatedly from current column to above column specified 'character',
" set following key mappings.
let g:fitcolumn_no_default_key_mappings = 1
inoremap <expr> <C-k>  fitcolumn#fitabovecolumn({
    \ 'insertchar': ' ',
    \ })
inoremap <expr> <C-j>  fitcolumn#fitbelowcolumn({
    \ 'insertchar': ' ',
    \ })
```
