" fitcolumn - 上下いずれかの行の特定の文字と同じ列まで指定した文字を入力する
" Version: 0.0.0
" Copyright (C) 2013 deris0126
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists('g:loaded_pluginname')
  finish
endif
let g:loaded_pluginname = 1

let s:save_cpo = &cpo
set cpo&vim

inoremap <silent><expr> <Plug>(fitcolumn-abovecolumn)  fitcolumn#fitabovecolumn()
inoremap <silent><expr> <Plug>(fitcolumn-belowcolumn)  fitcolumn#fitbelowcolumn()

if !exists('g:fitcolumn_no_default_key_mappings') ||
  \ !g:fitcolumn_no_default_key_mappings
  imap <C-k>  <Plug>(fitcolumn-abovecolumn)
  imap <C-j>  <Plug>(fitcolumn-belowcolumn)
endif


let &cpo = s:save_cpo
unlet s:save_cpo

" __END__
" vim: foldmethod=marker
